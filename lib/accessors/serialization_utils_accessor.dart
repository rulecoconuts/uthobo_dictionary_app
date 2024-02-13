import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:get_it/get_it.dart';

mixin SerializationUtilsAccessor {
  SerializationUtils serializationUtils() => GetIt.I<SerializationUtils>();
}
