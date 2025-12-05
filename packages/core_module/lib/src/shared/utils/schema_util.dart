import '../../../core_module.dart';

class SchemaUtil {
  SchemaUtil._();

  static Map<String, Object> lyricParams({Map<String, dynamic>? extra}) {
    return {
      'table': 'lyrics',
      'orderBy': 'create_at',
      'ascending': false,
      'selectFields':
          'id, title, artist, album_cover, is_hymn, create_at, verses, hymn_number',
      ...?extra,
    };
  }

  static Map<String, Object> servicesParams({Map<String, dynamic>? extra}) {
    return {
      'table': 'services',
      'orderBy': 'create_at',
      'ascending': false,
      ...?extra,
    };
  }

  static Map<String, Object> eventParams({Map<String, dynamic>? extra}) {
    return {
      'table': 'event',
      'orderBy': 'create_at',
      'ascending': false,
      ...?extra,
    };
  }

  static Map<String, Object> servicesCollectionParams({
    Map<String, dynamic>? extra,
  }) {
    return {
      'table': 'service',
      'orderBy': 'create_at',
      'ascending': false,
      'selectFields':
          'id, create_at, image, title, theme, preacher, service_date, heading, type, guide_is_visible, liturgies, service_lyrics (lyrics(id, title, artist, is_hymn, album_cover, create_at, verses, hymn_number)))',
      ...?extra,
    };
  }

  static Map<String, Object> hymnSearchScheme({
    String? searchField,
    int? limit,
  }) => {
    'table': 'lyrics',
    'orderBy': 'hymn_number',
    'likeColumn': SearchParameters.title.column,
    'likeValue': searchField ?? '',
    'ascending': true,
    'filterColumn': 'is_hymn',
    'filterValue': true,
    'selectFields':
        'id, title, artist, album_cover, create_at, verses, is_hymn, hymn_number',
    if (limit != null && limit > 0) 'limit': limit,
  };

  static Map<String, Object> generalSearchScheme({
    String? searchField,
    required selectedIndex,
    int? limit,
  }) => {
    'table': 'lyrics',
    'orderBy': 'create_at',
    'likeColumn': SearchParameters.values[selectedIndex].column,
    'likeValue': searchField ?? '',
    'ascending': false,
    'selectFields':
        'id, title, artist, album_cover, create_at, verses, is_hymn, hymn_number',
    if (limit != null && limit > 0) 'limit': limit,
  };
}
