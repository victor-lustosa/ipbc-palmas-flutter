
class EventEntity {
  EventEntity({
    this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.startDateTime,
    required this.endDateTime,
    required this.description,
    required this.location,
    required this.localName,
    required this.signUpLink,
    required this.contactLink,
    required this.createAt,
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
  final String location;
  final String localName;
  final String signUpLink;
  final String contactLink;
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
}
