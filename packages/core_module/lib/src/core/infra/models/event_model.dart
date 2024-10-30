
import 'package:core_module/core_module.dart';

class EventModel extends EventEntity {
  EventModel(
      {required super.id,
      required super.title,
      required super.subtitle,
      required super.image,
      required super.hour,
      required super.date,
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
      hour: '',
      date: '',
      description: '',
      location: '',
      link: '',
      linkDescription: '',
      createAt: DateTime.now(),
     );

  EventModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? image,
    String? hour,
    String? date,
    String? description,
    String? location,
    String? link,
    String? linkDescription,
    DateTime? createAt,})
  {   return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      hour: hour ?? this.hour,
      date: date ?? this.date,
      description: description ?? this.description,
      location: location ?? this.location,
      link: link ?? this.link,
      linkDescription: linkDescription ?? this.linkDescription,
      createAt: createAt ?? this.createAt,
    );
  }
}