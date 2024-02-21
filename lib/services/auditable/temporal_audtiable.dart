import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:json_annotation/json_annotation.dart';

abstract interface class TemporalAuditable {
  DateTime? get createdAt;

  set createdAt(DateTime? value);

  DateTime? get updatedAt;

  set updatedAt(DateTime? value);
}
