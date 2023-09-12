library lyric_module;

export 'src/domain/use-cases/lyrics_use_cases.dart';
export 'src/domain/entities/lyric_entity.dart';
export 'src/domain/entities/verse_entity.dart';

export 'src/infra/adapters/lyric_adapter.dart';
export 'src/infra/adapters/verse_adapter.dart';

export 'src/infra/adapters/hive-dtos/hive_lyric_adapter.dart';
export 'src/infra/adapters/hive-dtos/hive_verse_adapter.dart';

export 'src/infra/use-cases/lyrics_use_cases.dart';

export 'src/infra/models/hive-dtos/hive_lyric_dto.dart';
export 'src/infra/models/hive-dtos/hive_lyric_dto.g.dart';
export 'src/infra/models/lyric_model.dart';

export 'src/infra/models/hive-dtos/hive_verse_dto.dart';
export 'src/infra/models/hive-dtos/hive_verse_dto.g.dart';

export 'package:core_module/core_module.dart';
