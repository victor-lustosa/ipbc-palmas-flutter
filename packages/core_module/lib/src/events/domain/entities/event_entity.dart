import '../../../../core_module.dart';

class EventEntity {
  EventEntity({
    this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.startDateTime,
    required this.endDateTime,
    required this.description,
    required this.createAt,
    required this.isAllDay,
    this.location,
    this.localName,
    this.signUpLink,
    this.contactLink,
    this.latitude,
    this.longitude,
  });

  final String? id;
  final String title;
  final String subtitle;
  final String image;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String description;
  final bool isAllDay;
  final String? location;
  final String? localName;
  final String? signUpLink;
  final String? contactLink;
  final DateTime createAt;
  final double? latitude;
  final double? longitude;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventEntity &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  factory EventEntity.empty() => EventEntity(
    id: MockUtil.createId(),
    title: '',
    subtitle: '',
    image: '',
    description: '',
    isAllDay: false,
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

  EventEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? description,
    bool? isAllDay,
    String? location,
    String? localName,
    String? signUpLink,
    String? contactLink,
    DateTime? createAt,
    double? latitude,
    double? longitude,
  }) {
    return EventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      description: description ?? this.description,
      location: location ?? this.location,
      isAllDay: isAllDay ?? this.isAllDay,
      createAt: createAt ?? this.createAt,
      startDateTime: this.startDateTime,
      endDateTime: this.endDateTime,
      localName: localName ?? this.localName,
      signUpLink: signUpLink ?? this.signUpLink,
      contactLink: contactLink ?? this.contactLink,
      latitude: this.latitude,
      longitude: this.longitude,
    );
  }
}
