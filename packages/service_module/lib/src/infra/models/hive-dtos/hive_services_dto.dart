import 'package:hive/hive.dart';

part 'hive_services_dto.g.dart';

@HiveType(typeId: 5)
class HiveServicesDTO {

  @HiveField(0)
  String id;

  @HiveField(1)
  String heading;

  @HiveField(2)
  String path;

  @HiveField(3)
  String title;

  @HiveField(4)
  String image;

  @HiveField(5)
  String hour;

  HiveServicesDTO(
      {required this.id,
      required this.heading,
      required this.path,
      required this.title,
      required this.image,
      required this.hour,
     });
}