import 'dart:convert';

import '../../domain/entities/lyric_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

import '../../domain/entities/verse_entity.dart';
import '../models/lyric_model.dart';

class LyricAdapter {

  static List<LyricModel> listFromJson(String source) => listFromMap(json.decode(source));

  static LyricEntity fromJson(String source) => fromMap(json.decode(source));

  static List<LyricModel> listFromMap(dynamic json) {
    List<LyricModel> results = [];
    LyricModel lyricModel = LyricModel.empty();
    for(int i = 0; i < json['lyrics'].length ; i++){
      LyricEntity entity = fromMap(json['lyrics'][0]);
      results.add(lyricModel.copyWith(
          id:entity.id,
          title: entity.title,
          createAt: entity.createAt,
          group: entity.group,
          albumCover: entity.albumCover,
          verses: entity.verses));
    }
    return results;
  }
  static LyricEntity fromMap(dynamic json) {
    return LyricEntity(
      albumCover: json['albumCover'],
      id: json['id'],
      createAt: json['createAt'] == ''
          ? ''
          : DateFormat('dd/MM/yyyy, HH:mm')
              .format((json['createAt'] as Timestamp).toDate()),
      title: json['title'],
      group: json['group'],
      verses: [
        if (json.containsKey('verses'))
          //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
          ...(json['verses'] as List).map(VerseAdapter.fromMap).toList(),
      ],
    );
  }

  static Map<String, dynamic> toMap(LyricEntity data) {
    return {
      'id': data.id,
      'title': data.title,
      'createAt': data.createAt,
      'albumCover': data.albumCover,
      'group': data.group,
      'verses': VerseAdapter.toMap(data.verses),
    };
  }
}

class VerseAdapter {

  static List verseDecode(dynamic json){
    List results = [];
    for(int i = 0; i < json[0].length ; i++){
      results.add(json[0]['verse$i']);
    }
    return results;
  }

  static VerseEntity fromMap(dynamic json) {
    return VerseEntity(
      id: json['id'],
      isChorus: json['isChorus'],
      versesList: json['versesList'][0]['verse0'] != null ? verseDecode(json['versesList']) : json['versesList'],
    );
  }

  static List<Map<String, dynamic>> toMap(List<VerseEntity> data) {
    return data
        .map((entity) => {
              'id': entity.id,
              'title': entity.isChorus,
              'createAt': entity.versesList,
            })
        .toList();
  }
}
