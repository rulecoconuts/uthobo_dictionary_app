import 'package:dictionary_app/accessors/flavor_utils_accessor.dart';
import 'package:dictionary_app/config/ioc_config.dart';
import 'package:dictionary_app/services/storage/app_object_storage.dart';
import 'package:dictionary_app/services/storage/hive_backed_app_object_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class StorageConfig extends IocConfig with FlavorUtilsAccessor {
  @override
  void config() {
    GetIt.I.registerLazySingletonAsync<AppObjectStorage>(
      () async => HiveBackedAppObjectStorage.secure(
          "${appFlavor().name}_general_store"),
    );
  }
}
