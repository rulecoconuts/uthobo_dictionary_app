import 'dart:async';
import 'dart:convert';

import 'package:dictionary_app/services/storage/app_object_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class HiveBackedAppObjectStorage implements AppObjectStorage {
  final LazyBox box;

  HiveBackedAppObjectStorage({required this.box});

  @override
  Future delete(String key) async {
    box.delete(key);
  }

  @override
  Future get(String key) async {
    return box.get(key);
  }

  @override
  Future put(String key, value) async {
    await box.put(key, value);
  }

  @override
  Future clear() async {
    await box.clear();
  }

  /// Generate an encrypted HiveBackedAppObjectStorage instance
  static Future<HiveBackedAppObjectStorage> secure(String label) async {
    var secureStorage = FlutterSecureStorage();
    String encryptionKeyLabel = "${label}_encryption_key";
    String? encryptionKey = await secureStorage.read(key: encryptionKeyLabel);

    if (encryptionKey == null) {
      // Generate and store encryption key if it does not exist

      final key = Hive.generateSecureKey();
      encryptionKey = base64UrlEncode(key);
      await secureStorage.write(key: encryptionKeyLabel, value: encryptionKey);
    }

    return HiveBackedAppObjectStorage(
      box: await Hive.openLazyBox(label,
          encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey))),
    );
  }
}
