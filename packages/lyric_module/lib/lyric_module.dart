library lyric_module;

export 'src/lyric/domain/use-cases/lyrics_use_cases.dart';
export 'src/lyric/domain/entities/lyric_entity.dart';
export 'src/lyric/domain/entities/verse_entity.dart';

export 'src/lyric/infra/adapters/lyric_adapter.dart';
export 'src/lyric/infra/adapters/verse_adapter.dart';

export 'src/lyric/infra/adapters/hive-dtos/hive_lyric_adapter.dart';
export 'src/lyric/infra/adapters/hive-dtos/hive_verse_adapter.dart';

export 'src/lyric/infra/use-cases/lyrics_use_cases.dart';

export 'src/lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
export 'src/lyric/infra/models/lyric_model.dart';

export 'src/lyric/infra/models/hive-dtos/hive_verse_dto.dart';

export 'package:core_module/core_module.dart';
