class LiturgyEntity {
  final bool isAdditional;
  final String sequence;
  final String? additional;
  final String? id;
  LiturgyEntity({
    this.id,
    required this.isAdditional,
    required this.sequence,
    required this.additional,
  });
}

class LiturgySupabase {
  final String? id;
  final List<Map<String, dynamic>> liturgy;

  LiturgySupabase({this.id, required this.liturgy});
}