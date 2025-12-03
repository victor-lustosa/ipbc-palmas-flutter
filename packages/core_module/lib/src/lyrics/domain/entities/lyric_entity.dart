import 'package:core_module/core_module.dart';

class LyricEntity {
  final String? id;
  final String title;
  final String artist;
  final String albumCover;
  final String createAt;
  final bool isHymn;
  final List<VerseEntity> verses;
  LyricEntity({
    this.id,
    required this.title,
    required this.createAt,
    required this.albumCover,
    required this.artist,
    required this.verses,
    required this.isHymn,
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

  factory LyricEntity.empty() => LyricEntity(
    createAt: '',
    title: '',
    artist: '',
    albumCover: '',
    isHymn: false,
    verses: [],
  );

  LyricEntity copyWith({
    String? id,
    String? title,
    String? createAt,
    String? artist,
    String? albumCover,
    bool? isHymn,
    List<VerseEntity>? verses,
  }) {
    return LyricEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      albumCover: albumCover ?? this.albumCover,
      artist: artist ?? this.artist,
      isHymn: isHymn ?? this.isHymn,
      verses: verses ?? this.verses,
    );
  }
}
