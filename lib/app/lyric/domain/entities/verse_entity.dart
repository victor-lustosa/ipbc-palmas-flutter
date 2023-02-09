class VerseEntity {
  final int id;
  final bool isChorus;
    final List versesList;

  VerseEntity(
      {required this.id, required this.isChorus, required this.versesList});

  @override
  String toString() {
    return 'VerseEntity{id: $id, isChorus: $isChorus, versesList: $versesList}';
  }
}
