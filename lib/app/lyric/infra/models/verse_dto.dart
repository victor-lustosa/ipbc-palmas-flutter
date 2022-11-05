class VerseDTO {
  final bool isChorus;
  final int id;
  final List VersesList;

  @override
  String toString() {
    return 'VerseDTO{isChorus: $isChorus, id: $id, VersesList: $VersesList}';
  }

  VerseDTO(
      {required this.isChorus, required this.id, required this.VersesList});
}
