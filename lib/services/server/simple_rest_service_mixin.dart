import 'dart:convert';

import 'package:dictionary_app/services/auth/login/web_service_mixin.dart';
import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/server/api_error.dart';
import 'package:dio/dio.dart';

/// A simple REST service that used dio to send HTTP requests
mixin SimpleDioBackedRESTServiceMixin<T>
    on
        AuthBackedWebServiceMixin,
        CreationService<T>,
        UpdateService<T>,
        DeletionService<T> {
  SerializationUtils getSerializationUtils();

  Dio getDio();

  String getEndpoint();

  Future<String> getCreationUrl(T model) async {
    return getEndpoint();
  }

  Future<String> getBulkCreationUrl(List<T> models) async {
    return "${getEndpoint()}/bulk";
  }

  T deserialize(Map<String, dynamic> map) {
    return getSerializationUtils().deserialize<T>(map);
  }

  Map<String, dynamic> serialize(T model) {
    return getSerializationUtils().serialize<T>(model);
  }

  List<Map<String, dynamic>> serializeList(List<T> models) {
    return getSerializationUtils().serializeList(models);
  }

  List<T> deserializeList(List<Map<String, dynamic>> models) {
    return getSerializationUtils().deserializeList(models);
  }

  ApiPage<T> deserializeIntoPage(Map<String, dynamic> map) {
    return getSerializationUtils().deserializeIntoPage<T>(map);
  }

  /// Create model
  @override
  Future<T> create(T model) async {
    try {
      var dio = getDio();
      var response = await dio.post(await getCreationUrl(model),
          data: serialize(model),
          options: Options(headers: await generateAuthHeaders()));

      // parse response body into [T]
      return deserialize(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  /// Create multiple models
  @override
  Future<List<T>> createAll(List<T> models) async {
    try {
      var dio = getDio();
      var response = await dio.post(await getBulkCreationUrl(models),
          data: serializeList(models),
          options: Options(headers: await generateAuthHeaders()));

      // parse response body into [T]
      return deserializeList(
          (response.data as List).cast<Map<String, dynamic>>());
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  Future<String> getUpdateUrl(T model) async {
    return getEndpoint();
  }

  void handleDioException(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      if (e.response?.data is! Map) throw e;
      throw getSerializationUtils().deserialize<ApiError>(e.response!.data);
    }

    throw e;
  }

  /// Update model
  @override
  Future<T> update(T model) async {
    try {
      var dio = getDio();
      var response = await dio.put(await getUpdateUrl(model),
          data: serialize(model),
          options: Options(headers: await generateAuthHeaders()));

      // parse response body into [T]
      return deserialize(response.data);
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  int getID(T model) {
    return (model as dynamic).id;
  }

  Future<String> getDeletionUrl(T model) async {
    return "${await getEndpoint()}/${getID(model)}";
  }

  @override

  /// Delete model
  Future<bool> delete(T model) async {
    try {
      var dio = getDio();
      var response = await dio.delete(await getDeletionUrl(model),
          options: Options(headers: await generateAuthHeaders()));

      // parse response body into [T]
      return true;
    } on DioException catch (e) {
      handleDioException(e);
    }

    return false;
  }
}
