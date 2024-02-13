class SerializationUtils {
  final Map<Type, Function(Map<String, dynamic> jsonMap)> _deserializers = {};
  final Map<Type, Map<String, dynamic> Function(dynamic entity)> _serializers =
      {};

  void addDeserializer<T>(T Function(Map<String, dynamic> jsonMap) fromJson) {
    _deserializers[T] = fromJson;
  }

  void addSerializer<T>(Map<String, dynamic> Function(T entity) toJson) {
    _serializers[T] = toJson as Map<String, dynamic> Function(dynamic);
  }

  static double? deSerializeDouble(dynamic rawVal) {
    if (rawVal == null) return null;

    if (rawVal is double) return rawVal;

    if (rawVal is int) return rawVal.toDouble();

    return double.parse(rawVal);
  }

  static String? serializeDouble(double? val) {
    if (val == null) return null;

    return "$val";
  }

  static int? deSerializeInt(dynamic rawVal) {
    if (rawVal == null) return null;

    if (rawVal is int) return rawVal;

    if (rawVal is double) return rawVal.toInt();

    double d = double.parse(rawVal);

    return d.toInt();
  }

  static int deserializeIntNonNull(dynamic rawVal) {
    if (rawVal == null) return 0;

    if (rawVal is int) return rawVal;

    if (rawVal is double) return rawVal.toInt();

    double d = double.parse(rawVal);

    return d.toInt();
  }

  static String? serializeInt(int? val) {
    if (val == null) return null;
    return "$val";
  }

  T Function(Map<String, dynamic> jsonMap) getDeserializer<T>() {
    return _deserializers[T] as T Function(Map<String, dynamic>);
  }

  Map<String, dynamic> serialize<T>(T entity) {
    return (_serializers[T] ?? (e) => (e as dynamic).toJson()).call(entity);
  }

  T deserialize<T>(Map<String, dynamic> jsonMap) {
    return getDeserializer<T>().call(jsonMap);
  }

  List<T> deserializeList<T>(List<dynamic> jsonList,
      {T Function(Map<String, dynamic> map)? fromJson}) {
    var f = fromJson ?? getDeserializer<T>();

    return jsonList.map((e) => e as Map<String, dynamic>).map(f).toList();
  }
}
