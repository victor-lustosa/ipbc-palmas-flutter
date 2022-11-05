import '../../../core/infra/datasources/datasource.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../domain/repositories/lyric_repository.dart';
import '../models/lyric_model.dart';

class LyricRepository implements ILyricRepository<LyricEntity> {
  final IGetDatasource datasource;

  LyricRepository({required this.datasource});

  List<LyricEntity> _convert(List<Map> list) {
    return list.map(LyricModel.fromMap).toList();
  }

  @override
  Stream<List<LyricEntity>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }

  @override
  Future<List<LyricEntity>> filter(List<LyricEntity> lyrics, String letter) {
    List<LyricEntity> lyricsResult = [];
    for (LyricEntity lyric in lyrics) {
      if (lyric.title[0].toLowerCase() == letter.toLowerCase()) {
        lyricsResult.add(lyric);
      }
    }
    return Future.value(lyricsResult);
  }

  @override
  Future<void> add(T) async {
    // TODO: implement add
  }

  @override
  Future<void> delete(T) async {
    // TODO: implement delete
  }

  @override
  Future<void> update(T) async {
    // TODO: implement update
  }
}
