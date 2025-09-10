import '../../../../core_module.dart';

class LiturgyEntity {
  final bool isAdditional;
  final String sequence;
  final String? additional;
  final String? id;

  LiturgyEntity({
    this.id,
    required this.isAdditional,
    required this.sequence,
    required this.additional,
  });


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LiturgyEntity &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  factory LiturgyEntity.empty() => LiturgyEntity(
    id: MockUtil.createId(),
    isAdditional: false,
    sequence: '',
    additional: '',
  );

  LiturgyEntity copyWith({
    String? id,
    bool? isAdditional,
    String? sequence,
    String? additional,
  }) {
    return LiturgyEntity(
      id: id ?? this.id,
      isAdditional: isAdditional ?? this.isAdditional,
      sequence: sequence ?? this.sequence,
      additional: additional ?? this.additional,
    );
  }
}