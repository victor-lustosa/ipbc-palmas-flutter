import 'package:core_module/core_module.dart';

class ServicesModel extends ServicesEntity {
  ServicesModel({
    required int id,
    required String image,
    required String hour,
    required String path,
    required String title,
    required String heading,
  }) : super(
          id: id,
          image: image,
          path: path,
          hour: hour,
          title: title,
          heading: heading,
        );

  factory ServicesModel.empty() => ServicesModel(
        title: '',
        path: '',
        hour: '',
        image: '',
        heading: '',
        id: SupaServicesUtil.createId(),
      );

  ServicesModel copyWith({
    String? title,
    int? id,
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
    );
  }
}
