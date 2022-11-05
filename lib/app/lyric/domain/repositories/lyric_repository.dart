import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';

import '../../../core/domain/repositories/repository.dart';

abstract class ILyricRepository<T>
    implements
        IGetRepository<T>,
        IAddRepository<T>,
        IUpdateRepository<T>,
        IDeleteRepository<T> {
    Future<List<LyricEntity>> filter(List<LyricEntity> lyrics,String letter);
}
