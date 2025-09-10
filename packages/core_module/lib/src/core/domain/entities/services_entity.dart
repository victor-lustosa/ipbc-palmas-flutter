import '../../../../core_module.dart';

class ServicesEntity {
  ServicesEntity({
    this.dayOfWeek,
    required this.image,
    required this.id,
    required this.serviceDate,
    required this.title,
    required this.heading,
    required this.path,
  });

  final String heading;
  final String path;
  final int? dayOfWeek;
  final String title;
  final String id;
  final String image;
  final DateTime serviceDate;

  factory ServicesEntity.empty() => ServicesEntity(
    title: '',
    path: '',
    serviceDate: DateTime.now(),
    image: '',
    heading: '',
    id: MockUtil.createId(),
    dayOfWeek: null,
  );

  ServicesEntity copyWith({
    String? title,
    String? id,
    int? dayOfWeek,
    String? path,
    DateTime? serviceDate,
    String? image,
    String? heading,
  }) {
    return ServicesEntity(
      title: title ?? this.title,
      image: image ?? this.image,
      serviceDate: serviceDate ?? this.serviceDate,
      heading: heading ?? this.heading,
      id: id ?? this.id,
      path: path ?? this.path,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    );
  }
}
