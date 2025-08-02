mixin FlattenMixin {
  static List<Map<String, dynamic>> flattenByKey(dynamic data, String key) {
    if (data == null) return [];

    return (data as List<dynamic>)
        .map((item) => Map<String, dynamic>.from(item[key]))
        .toList();
  }
}