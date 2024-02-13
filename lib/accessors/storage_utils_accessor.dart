import 'package:dictionary_app/services/storage/app_object_storage.dart';
import 'package:get_it/get_it.dart';

mixin StorageUtilsAccessor {
  Future<AppObjectStorage> generalStorage() =>
      GetIt.I.getAsync<AppObjectStorage>();
}
