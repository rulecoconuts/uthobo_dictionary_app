import 'dart:convert';

import 'package:dictionary_app/services/auth/auth.dart';
import 'package:dictionary_app/services/auth/storage/auth_storage.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/storage/app_object_storage.dart';

class SimpleAuthStorage implements AuthStorage {
  final AppObjectStorage storage;
  final SerializationUtils serializationUtils;

  SimpleAuthStorage({required this.storage, required this.serializationUtils});

  @override
  Future clear() async {
    await storage.clear();
  }

  @override
  Future delete(String key) async {
    await storage.delete(key);
  }

  @override
  Future<Auth?> get(String key) async {
    String? authString = await storage.get(key);
    if (authString == null) return null;
    Map<String, dynamic> map = json.decode(authString);
    return serializationUtils.deserialize<Auth>(map);
  }

  @override
  Future put(String key, Auth auth) async {
    return await storage.put(key, serializationUtils.serialize<Auth>(auth));
  }
}
