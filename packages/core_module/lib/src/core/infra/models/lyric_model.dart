
import 'package:core_module/core_module.dart';

class LyricModel extends LyricEntity {
  LyricModel(
      {required super.id,
      required super.title,
      required super.createAt,
      required super.albumCover,
      required super.group,
      required super.verses});

  factory LyricModel.empty() => LyricModel(
        id: SupaServicesUtil.createId(),
        createAt: DateTime.now(),
        title: '',
        group: '',
        albumCover: '',
        verses: [],
      );

  LyricModel copyWith({
    int? id,
    String? title,
    DateTime? createAt,
    String? group,
    String? albumCover,
    List<VerseEntity>? verses,
  }) {
    return LyricModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      albumCover: albumCover ?? this.albumCover,
      group: group ?? this.group,
      verses: verses ?? this.verses,
    );
  }
}
