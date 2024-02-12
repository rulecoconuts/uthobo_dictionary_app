import 'package:dictionary_app/services/server/server_details.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

mixin ServerUtilsAccessor {
  Dio dio() => GetIt.I<Dio>();
  ServerDetails serverDetails() => GetIt.I<ServerDetails>();
}
