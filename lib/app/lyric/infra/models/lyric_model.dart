import 'package:ipbc_palmas/app/lyric/infra/converts/json_to_verse.dart';

import '../../domain/entities/lyric_entity.dart';
import '../../domain/entities/verse_entity.dart';

class LyricModel extends LyricEntity {
  LyricModel(
      {required String id,
      required String title,
      required String group,
      required List<VerseEntity> verses})
      : super(id: id, title: title, group: group, verses: verses);

  factory LyricModel.empty() =>
      LyricModel(id: '', title: '', group: '', verses: []);

  LyricModel copyWith({
    String? id,
    String? title,
    String? group,
    List<VerseEntity>? verses,
  }) {
    return LyricModel(
      id: id ?? this.id,
      title: title ?? this.title,
      group: group ?? this.group,
      verses: verses ?? this.verses,
    );
  }

//TODO: ler a lista de versos que vem dentro do objeto lyrics e ja retornar essa lista
  static LyricEntity fromMap(dynamic json) {
    return LyricEntity(
      id: json['id'],
      title: json['title'],
      group: json['group'],
      verses: [
        if (json.containsKey('verses'))
          //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
          ...(json['verses'] as List).map(JsonToVerse.fromMap).toList(),
      ],
    );
  }
}
