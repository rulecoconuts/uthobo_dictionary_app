import 'dart:async';

abstract interface class AppObjectStorage {
  Future put(String key, dynamic value);
  Future get(String key);
  Future delete(String key);
  Future clear();
}
