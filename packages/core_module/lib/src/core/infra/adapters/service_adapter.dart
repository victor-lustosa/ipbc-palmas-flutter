//import 'dart:convert';

import 'package:core_module/core_module.dart';

class ServiceAdapter {
  static List<ServiceEntity> fromMapList(dynamic data) {
    List<ServiceEntity> list = [];
    for (dynamic entity in data) {
      list.add(
        ServiceEntity(
          id:
              entity['id'].runtimeType == String
                  ? entity['id']
                  : entity['id'].toString(),
          type: '',
          image: entity['image'],
          hour: entity['hour'],
          createAt: entity['createAt'],
          theme: entity['theme'],
          preacher: entity['preacher'],
          guideIsVisible: entity['guideIsVisible'],
          title: entity['title'],
          heading: entity['heading'],
          lyricsList: entity['lyricsList'],
          liturgiesList: entity['liturgiesList'],
        ),
      );
    }
    return list;
  }
}
