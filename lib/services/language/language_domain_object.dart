import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';

class LanguageDomainObject implements TemporalAuditable, UserAuditable {
  int? id;
  String name;
  String? description;

  @override
  DateTime? createdAt;

  @override
  DateTime? updatedAt;

  @override
  int? createdBy;

  @override
  int? updatedBy;

  LanguageDomainObject(
      {required this.name,
      this.id,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  @override
  int get hashCode =>
      id != null ? Object.hash(id, null) : Object.hash(name, null);

  @override
  bool operator ==(dynamic other) =>
      other is LanguageDomainObject && hashCode == other.hashCode;
}
