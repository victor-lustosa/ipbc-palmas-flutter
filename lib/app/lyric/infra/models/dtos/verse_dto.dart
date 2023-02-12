class VerseDTO {
  final bool isChorus;
  final int id;
  final List versesList;

  @override
  String toString() {
    return 'VerseDTO{isChorus: $isChorus, id: $id, VersesList: $versesList}';
  }

  VerseDTO(
      {required this.isChorus, required this.id, required this.versesList});
}
