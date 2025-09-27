class VerseEntity {
  final int id;
  final bool isChorus;
  final List<String> versesList;

  VerseEntity({
    required this.id,
    required this.isChorus,
    required this.versesList,
  });

  VerseEntity copyWith({
    bool? isChorus,
    List<String>? versesList,
  }) {
    return VerseEntity(
      id: id,
      isChorus: isChorus ?? this.isChorus,
      versesList: versesList ?? this.versesList,
    );
  }
}
