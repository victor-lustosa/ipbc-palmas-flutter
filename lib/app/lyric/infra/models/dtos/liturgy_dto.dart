class LiturgyDTO {
  final bool isAdditional;
  final String sequence;
  final String additional;

  LiturgyDTO(
      {required this.isAdditional,
      required this.sequence,
      required this.additional});

  @override
  String toString() {
    return 'LiturgyDTO{isAdditional: $isAdditional, sequence: $sequence, additional: $additional}';
  }
}
