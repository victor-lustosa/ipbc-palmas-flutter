// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_user_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarUserDTOCollection on Isar {
  IsarCollection<IsarUserDTO> get isarUserDTOs => this.collection();
}

const IsarUserDTOSchema = CollectionSchema(
  name: r'IsarUserDTO',
  id: -368494295532080524,
  properties: {
    r'actionLink': PropertySchema(
      id: 0,
      name: r'actionLink',
      type: IsarType.string,
    ),
    r'aud': PropertySchema(
      id: 1,
      name: r'aud',
      type: IsarType.string,
    ),
    r'confirmationSentAt': PropertySchema(
      id: 2,
      name: r'confirmationSentAt',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 4,
      name: r'email',
      type: IsarType.string,
    ),
    r'emailChangeSentAt': PropertySchema(
      id: 5,
      name: r'emailChangeSentAt',
      type: IsarType.string,
    ),
    r'emailConfirmedAt': PropertySchema(
      id: 6,
      name: r'emailConfirmedAt',
      type: IsarType.string,
    ),
    r'invitedAt': PropertySchema(
      id: 7,
      name: r'invitedAt',
      type: IsarType.string,
    ),
    r'isAnonymous': PropertySchema(
      id: 8,
      name: r'isAnonymous',
      type: IsarType.bool,
    ),
    r'lastSignInAt': PropertySchema(
      id: 9,
      name: r'lastSignInAt',
      type: IsarType.string,
    ),
    r'newEmail': PropertySchema(
      id: 10,
      name: r'newEmail',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 11,
      name: r'phone',
      type: IsarType.string,
    ),
    r'phoneConfirmedAt': PropertySchema(
      id: 12,
      name: r'phoneConfirmedAt',
      type: IsarType.string,
    ),
    r'recoverySentAt': PropertySchema(
      id: 13,
      name: r'recoverySentAt',
      type: IsarType.string,
    ),
    r'role': PropertySchema(
      id: 14,
      name: r'role',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.string,
    )
  },
  estimateSize: _isarUserDTOEstimateSize,
  serialize: _isarUserDTOSerialize,
  deserialize: _isarUserDTODeserialize,
  deserializeProp: _isarUserDTODeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarUserDTOGetId,
  getLinks: _isarUserDTOGetLinks,
  attach: _isarUserDTOAttach,
  version: '3.1.0+1',
);

int _isarUserDTOEstimateSize(
  IsarUserDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.actionLink;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.aud.length * 3;
  {
    final value = object.confirmationSentAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.createdAt.length * 3;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.emailChangeSentAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.emailConfirmedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.invitedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastSignInAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.newEmail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phoneConfirmedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recoverySentAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.role;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.updatedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarUserDTOSerialize(
  IsarUserDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.actionLink);
  writer.writeString(offsets[1], object.aud);
  writer.writeString(offsets[2], object.confirmationSentAt);
  writer.writeString(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.email);
  writer.writeString(offsets[5], object.emailChangeSentAt);
  writer.writeString(offsets[6], object.emailConfirmedAt);
  writer.writeString(offsets[7], object.invitedAt);
  writer.writeBool(offsets[8], object.isAnonymous);
  writer.writeString(offsets[9], object.lastSignInAt);
  writer.writeString(offsets[10], object.newEmail);
  writer.writeString(offsets[11], object.phone);
  writer.writeString(offsets[12], object.phoneConfirmedAt);
  writer.writeString(offsets[13], object.recoverySentAt);
  writer.writeString(offsets[14], object.role);
  writer.writeString(offsets[15], object.updatedAt);
}

IsarUserDTO _isarUserDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarUserDTO(
    actionLink: reader.readStringOrNull(offsets[0]),
    aud: reader.readString(offsets[1]),
    confirmationSentAt: reader.readStringOrNull(offsets[2]),
    createdAt: reader.readString(offsets[3]),
    email: reader.readStringOrNull(offsets[4]),
    emailChangeSentAt: reader.readStringOrNull(offsets[5]),
    emailConfirmedAt: reader.readStringOrNull(offsets[6]),
    id: id,
    invitedAt: reader.readStringOrNull(offsets[7]),
    isAnonymous: reader.readBool(offsets[8]),
    lastSignInAt: reader.readStringOrNull(offsets[9]),
    newEmail: reader.readStringOrNull(offsets[10]),
    phone: reader.readStringOrNull(offsets[11]),
    phoneConfirmedAt: reader.readStringOrNull(offsets[12]),
    recoverySentAt: reader.readStringOrNull(offsets[13]),
    role: reader.readStringOrNull(offsets[14]),
    updatedAt: reader.readStringOrNull(offsets[15]),
  );
  return object;
}

P _isarUserDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarUserDTOGetId(IsarUserDTO object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarUserDTOGetLinks(IsarUserDTO object) {
  return [];
}

void _isarUserDTOAttach(
    IsarCollection<dynamic> col, Id id, IsarUserDTO object) {
  object.id = id;
}

extension IsarUserDTOQueryWhereSort
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QWhere> {
  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarUserDTOQueryWhere
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QWhereClause> {
  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarUserDTOQueryFilter
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QFilterCondition> {
  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'actionLink',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'actionLink',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actionLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actionLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actionLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'actionLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'actionLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'actionLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'actionLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionLink',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      actionLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'actionLink',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aud',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> audIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aud',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      audIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aud',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'confirmationSentAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'confirmationSentAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confirmationSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confirmationSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confirmationSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confirmationSentAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'confirmationSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'confirmationSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'confirmationSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'confirmationSentAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confirmationSentAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      confirmationSentAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'confirmationSentAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailChangeSentAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailChangeSentAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailChangeSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emailChangeSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emailChangeSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emailChangeSentAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emailChangeSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emailChangeSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emailChangeSentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emailChangeSentAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailChangeSentAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailChangeSentAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailChangeSentAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailConfirmedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailConfirmedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emailConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emailConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emailConfirmedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emailConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emailConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emailConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emailConfirmedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailConfirmedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      emailConfirmedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailConfirmedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invitedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invitedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invitedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invitedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invitedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invitedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invitedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invitedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invitedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      invitedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invitedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      isAnonymousEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAnonymous',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSignInAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSignInAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSignInAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSignInAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSignInAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSignInAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastSignInAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastSignInAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastSignInAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastSignInAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSignInAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      lastSignInAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastSignInAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newEmail',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newEmail',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> newEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> newEmailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> newEmailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      newEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phoneConfirmedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phoneConfirmedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneConfirmedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneConfirmedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneConfirmedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneConfirmedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      phoneConfirmedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneConfirmedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recoverySentAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recoverySentAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recoverySentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recoverySentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recoverySentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recoverySentAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recoverySentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recoverySentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recoverySentAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recoverySentAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recoverySentAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      recoverySentAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recoverySentAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'role',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      roleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'role',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'role',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'role',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition> roleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      roleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterFilterCondition>
      updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }
}

extension IsarUserDTOQueryObject
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QFilterCondition> {}

extension IsarUserDTOQueryLinks
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QFilterCondition> {}

extension IsarUserDTOQuerySortBy
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QSortBy> {
  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByActionLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionLink', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByActionLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionLink', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByAud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aud', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByAudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aud', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByConfirmationSentAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmationSentAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByConfirmationSentAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmationSentAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByEmailChangeSentAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailChangeSentAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByEmailChangeSentAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailChangeSentAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByEmailConfirmedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailConfirmedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByEmailConfirmedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailConfirmedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByInvitedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByInvitedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByIsAnonymous() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByIsAnonymousDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByLastSignInAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSignInAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByLastSignInAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSignInAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByNewEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEmail', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByNewEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEmail', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByPhoneConfirmedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneConfirmedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByPhoneConfirmedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneConfirmedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByRecoverySentAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recoverySentAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      sortByRecoverySentAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recoverySentAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarUserDTOQuerySortThenBy
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QSortThenBy> {
  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByActionLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionLink', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByActionLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionLink', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByAud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aud', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByAudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aud', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByConfirmationSentAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmationSentAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByConfirmationSentAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmationSentAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByEmailChangeSentAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailChangeSentAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByEmailChangeSentAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailChangeSentAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByEmailConfirmedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailConfirmedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByEmailConfirmedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailConfirmedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByInvitedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByInvitedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByIsAnonymous() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByIsAnonymousDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByLastSignInAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSignInAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByLastSignInAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSignInAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByNewEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEmail', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByNewEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEmail', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByPhoneConfirmedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneConfirmedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByPhoneConfirmedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneConfirmedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByRecoverySentAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recoverySentAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy>
      thenByRecoverySentAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recoverySentAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarUserDTOQueryWhereDistinct
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> {
  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByActionLink(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actionLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByAud(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aud', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct>
      distinctByConfirmationSentAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confirmationSentAt',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByCreatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByEmailChangeSentAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailChangeSentAt',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByEmailConfirmedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailConfirmedAt',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByInvitedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invitedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByIsAnonymous() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAnonymous');
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByLastSignInAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSignInAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByNewEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newEmail', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByPhoneConfirmedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneConfirmedAt',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByRecoverySentAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recoverySentAt',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByRole(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'role', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserDTO, IsarUserDTO, QDistinct> distinctByUpdatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }
}

extension IsarUserDTOQueryProperty
    on QueryBuilder<IsarUserDTO, IsarUserDTO, QQueryProperty> {
  QueryBuilder<IsarUserDTO, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> actionLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actionLink');
    });
  }

  QueryBuilder<IsarUserDTO, String, QQueryOperations> audProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aud');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations>
      confirmationSentAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confirmationSentAt');
    });
  }

  QueryBuilder<IsarUserDTO, String, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations>
      emailChangeSentAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailChangeSentAt');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations>
      emailConfirmedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailConfirmedAt');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> invitedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invitedAt');
    });
  }

  QueryBuilder<IsarUserDTO, bool, QQueryOperations> isAnonymousProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAnonymous');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> lastSignInAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSignInAt');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> newEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newEmail');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations>
      phoneConfirmedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneConfirmedAt');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations>
      recoverySentAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recoverySentAt');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'role');
    });
  }

  QueryBuilder<IsarUserDTO, String?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
