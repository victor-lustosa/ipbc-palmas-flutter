class ServicesEntity {
  ServicesEntity({
      required this.image,
      required this.id,
      required this.hour,
      required this.title,
      required this.heading,
      required this.path});

  final String heading;
  final String path;
  final String title;
  final int id;
  final String image;
  final String hour;
}
