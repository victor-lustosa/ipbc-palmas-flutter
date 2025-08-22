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


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LiturgyEntity &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}