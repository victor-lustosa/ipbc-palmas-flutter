import 'package:core_module/core_module.dart';

class EventModel extends EventEntity {
  EventModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.image,
    required super.dateHour,
    required super.description,
    required super.location,
    required super.link,
    required super.linkDescription,
    required super.createAt,
  });

  factory EventModel.empty() => EventModel(
    id: SupaServicesUtil.createId(),
    title: '',
    subtitle: '',
    image: '',
    dateHour: DateTime.now(),
    description: '',
    location: '',
    link: '',
    linkDescription: '',
    createAt: DateTime.now(),
  );

  EventModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    String? hour,
    DateTime? dateHour,
    String? description,
    String? location,
    String? link,
    String? linkDescription,
    DateTime? createAt,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      dateHour: dateHour ?? this.dateHour,
      description: description ?? this.description,
      location: location ?? this.location,
      link: link ?? this.link,
      linkDescription: linkDescription ?? this.linkDescription,
      createAt: createAt ?? this.createAt,
    );
  }
}
