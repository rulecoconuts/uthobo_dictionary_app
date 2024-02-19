abstract interface class UserAuditable {
  int? get createdBy;
  set createdBy(int? value);
  int? get updatedBy;
  set updatedBy(int? value);
}
