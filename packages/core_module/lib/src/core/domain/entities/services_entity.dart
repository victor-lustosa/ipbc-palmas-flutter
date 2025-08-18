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
}
