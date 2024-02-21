import 'package:json_annotation/json_annotation.dart';
part 'api_sort.g.dart';

@JsonSerializable()
class ApiSort {
  final String name;
  final ApiSortDirection direction;

  const ApiSort({required this.name, this.direction = ApiSortDirection.asc});

  @override
  String toString() {
    return "$name,${direction.name}";
  }

  @override
  int get hashCode => Object.hashAll([name, direction]);

  @override
  bool operator ==(dynamic other) =>
      other is ApiSort && hashCode == other.hashCode;

  Map<String, dynamic> toJson() => _$ApiSortToJson(this);

  factory ApiSort.fromJson(json) => _$ApiSortFromJson(json);
}

enum ApiSortDirection { asc, desc }
