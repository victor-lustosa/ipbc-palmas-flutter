// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_token_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarTokenDTOCollection on Isar {
  IsarCollection<IsarTokenDTO> get isarTokenDTOs => this.collection();
}

const IsarTokenDTOSchema = CollectionSchema(
  name: r'IsarTokenDTO',
  id: 7663332924803667737,
  properties: {
    r'token': PropertySchema(id: 0, name: r'token', type: IsarType.string),
  },
  estimateSize: _isarTokenDTOEstimateSize,
  serialize: _isarTokenDTOSerialize,
  deserialize: _isarTokenDTODeserialize,
  deserializeProp: _isarTokenDTODeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarTokenDTOGetId,
  getLinks: _isarTokenDTOGetLinks,
  attach: _isarTokenDTOAttach,
  version: '3.1.0+1',
);

int _isarTokenDTOEstimateSize(
  IsarTokenDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.token;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarTokenDTOSerialize(
  IsarTokenDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.token);
}

IsarTokenDTO _isarTokenDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTokenDTO(token: reader.readStringOrNull(offsets[0]));
  object.id = id;
  return object;
}

P _isarTokenDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarTokenDTOGetId(IsarTokenDTO object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarTokenDTOGetLinks(IsarTokenDTO object) {
  return [];
}

void _isarTokenDTOAttach(
  IsarCollection<dynamic> col,
  Id id,
  IsarTokenDTO object,
) {
  object.id = id;
}

extension IsarTokenDTOQueryWhereSort
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QWhere> {
  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarTokenDTOQueryWhere
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QWhereClause> {
  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension IsarTokenDTOQueryFilter
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QFilterCondition> {
  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition>
  tokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'token'),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition>
  tokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'token'),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> tokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition>
  tokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> tokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> tokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'token',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition>
  tokenStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> tokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> tokenContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition> tokenMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'token',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition>
  tokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'token', value: ''),
      );
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterFilterCondition>
  tokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'token', value: ''),
      );
    });
  }
}

extension IsarTokenDTOQueryObject
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QFilterCondition> {}

extension IsarTokenDTOQueryLinks
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QFilterCondition> {}

extension IsarTokenDTOQuerySortBy
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QSortBy> {
  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterSortBy> sortByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterSortBy> sortByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }
}

extension IsarTokenDTOQuerySortThenBy
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QSortThenBy> {
  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterSortBy> thenByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QAfterSortBy> thenByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }
}

extension IsarTokenDTOQueryWhereDistinct
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QDistinct> {
  QueryBuilder<IsarTokenDTO, IsarTokenDTO, QDistinct> distinctByToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token', caseSensitive: caseSensitive);
    });
  }
}

extension IsarTokenDTOQueryProperty
    on QueryBuilder<IsarTokenDTO, IsarTokenDTO, QQueryProperty> {
  QueryBuilder<IsarTokenDTO, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarTokenDTO, String?, QQueryOperations> tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token');
    });
  }
}
