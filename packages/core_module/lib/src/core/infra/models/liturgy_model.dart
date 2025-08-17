import 'package:core_module/core_module.dart';

class LiturgyModel extends LiturgyEntity {
  LiturgyModel({
    required super.id,
    required super.isAdditional,
    required super.sequence,
    required super.additional,
  });

  factory LiturgyModel.empty() => LiturgyModel(
    id: MockUtil.createId(),
    isAdditional: false,
    sequence: '',
    additional: '',
  );

  LiturgyModel copyWith({
    String? id,
    bool? isAdditional,
    String? sequence,
    String? additional,
  }) {
    return LiturgyModel(
      id: id ?? this.id,
      isAdditional: isAdditional ?? this.isAdditional,
      sequence: sequence ?? this.sequence,
      additional: additional ?? this.additional,
    );
  }
}
