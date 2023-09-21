import 'package:lyric_module/lyric_module.dart';

class ServicesModel extends ServicesEntity {
  ServicesModel({
    required String id,
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
        id: '',
      );

  ServicesModel copyWith({
    String? title,
    String? id,
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
