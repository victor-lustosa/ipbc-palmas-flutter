import 'package:core_module/core_module.dart';

class ServicesModel extends ServicesEntity {
  ServicesModel({
    required super.dayOfWeek,
    required super.id,
    required super.image,
    required super.hour,
    required super.path,
    required super.title,
    required super.heading,
  });

  factory ServicesModel.empty() => ServicesModel(
    title: '',
    path: '',
    hour: '',
    image: '',
    heading: '',
    id: MockUtil.createId(),
    dayOfWeek: null,
  );

  ServicesModel copyWith({
    String? title,
    String? id,
    int? dayOfWeek,
    String? path,
    String? hour,
    String? image,
    String? heading,
  }) {
    return ServicesModel(
      title: title ?? this.title,
      image: image ?? this.image,
      hour: hour ?? this.hour,
      heading: heading ?? this.heading,
      id: id ?? this.id,
      path: path ?? this.path,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    );
  }
}
