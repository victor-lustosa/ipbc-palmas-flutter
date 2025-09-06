import 'package:core_module/core_module.dart';

class EventModel extends EventEntity {
  EventModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.image,
    required super.startDateTime,
    required super.endDateTime,
    required super.description,
    required super.location,
    required super.localName,
    required super.signUpLink,
    required super.contactLink,
    required super.createAt,
    required super.latitude,
    required super.longitude,
  });

  factory EventModel.empty() => EventModel(
    id: MockUtil.createId(),
    title: '',
    subtitle: '',
    image: '',
    description: '',
    location: '',
    createAt: DateTime.now(),
    startDateTime: DateTime.now(),
    endDateTime: DateTime.now(),
    localName: '',
    signUpLink: '',
    contactLink: '',
    latitude: 0.0,
    longitude: 0.0,
  );

  EventModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? description,
    String? location,
    String? localName,
    String? signUpLink,
    String? contactLink,
    DateTime? createAt,
    double? latitude,
    double? longitude,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      description: description ?? this.description,
      location: location ?? this.location,
      createAt: createAt ?? this.createAt,
      startDateTime: this.startDateTime,
      endDateTime: this.endDateTime,
      localName: this.localName,
      signUpLink: this.signUpLink,
      contactLink: this.contactLink,
      latitude: this.latitude,
      longitude: this.longitude,
    );
  }
}
