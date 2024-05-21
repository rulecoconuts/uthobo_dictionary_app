import 'package:dictionary_app/services/auditable/temporal_audtiable.dart';
import 'package:dictionary_app/services/auditable/user_auditable.dart';
import 'package:dictionary_app/services/serialization/serialization_utils.dart';
import 'package:dictionary_app/services/word_part/word_part_domain_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_word_part.g.dart';

@JsonSerializable()
class RemoteWordPart implements TemporalAuditable, UserAuditable {
  int? id;
  int wordId;
  int partId;
  String? definition;
  String? note;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  @override
  DateTime? createdAt;

  @JsonKey(
      fromJson: SerializationUtils.deserializeDate,
      toJson: SerializationUtils.serializeDate)
  @override
  DateTime? updatedAt;

  @override
  int? createdBy;

  @override
  int? updatedBy;

  RemoteWordPart(
      {this.id,
      required this.wordId,
      required this.partId,
      this.definition,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Map<String, dynamic> toJson() => _$RemoteWordPartToJson(this);

  factory RemoteWordPart.fromJson(Map<String, dynamic> json) =>
      _$RemoteWordPartFromJson(json);

  WordPartDomainObject toDomain() {
    return WordPartDomainObject(
        wordId: wordId,
        partId: partId,
        id: id,
        definition: definition,
        note: note,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy);
  }

  factory RemoteWordPart.fromDomain(WordPartDomainObject domain) {
    return RemoteWordPart(
        wordId: domain.wordId,
        partId: domain.partId,
        id: domain.id,
        definition: domain.definition,
        note: domain.note,
        createdAt: domain.createdAt,
        createdBy: domain.createdBy,
        updatedAt: domain.updatedAt,
        updatedBy: domain.updatedBy);
  }
}
