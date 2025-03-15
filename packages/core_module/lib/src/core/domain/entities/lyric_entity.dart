import 'package:core_module/core_module.dart';

class LyricEntity {
  final String id;
  final String title;
  final String group;
  final String albumCover;
  final DateTime createAt;
  // final List<VerseEntity> verses;
  LyricEntity({
    required this.id,
    required this.title,
    required this.createAt,
    required this.albumCover,
    required this.group,
    // required this.verses
  });
}
