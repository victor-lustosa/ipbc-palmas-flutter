import 'dart:convert';
import 'package:core_module/core_module.dart';

import '../../../shared/mixins/flatten_mixin.dart';

// ignore: depend_on_referenced_packages

class ServiceAdapter {
  ServiceAdapter._();

  static ServiceModel fromJson(String source) => fromMap(json.decode(source));

  static List<ServiceEntity> fromJsonList(String source) =>
      fromMapList(json.decode(source));

  static ServiceModel fromMap(dynamic json) {
    return ServiceModel(
      id: json['id'],
      image: json['image'],
      serviceLiturgiesTableId: json['service_liturgies_table_id'],
      liturgiesTableId: json['liturgies_table_id'],
      serviceDate: DateTime.parse(json['service_date']),
      createAt: DateTime.parse(json['create_at']),
      type: json['type'],
      theme: json['theme'],
      preacher: json['preacher'],
      heading: json['heading'],
      title: json['title'],
      guideIsVisible: json['guide_is_visible'],
      liturgiesList: json.containsKey('liturgies_list')
          ? LiturgyAdapter.fromMapList(json['service_liturgies']['liturgies'])
          : [],
      lyricsList: LyricAdapter.fromMapList(json['service_lyrics']['lyrics']),
    );
  }
  static ServiceModel toModel(ServiceEntity data) {
    return ServiceModel(
      id: data.id,
      image: data.image,
      serviceLiturgiesTableId: data.serviceLiturgiesTableId,
      serviceDate: data.serviceDate,
      createAt: data.createAt,
      type: data.type,
      theme: data.theme,
      preacher: data.preacher,
      heading: data.heading,
      title: data.title,
      guideIsVisible: data.guideIsVisible,
      liturgiesList: data.liturgiesList ?? [],
      lyricsList: data.lyricsList ?? [],
      liturgiesTableId: data.liturgiesTableId,
    );
  }

  static Map<String, dynamic> toMap(ServiceEntity data) {
    return {
      if (data.id != null) 'id': data.id,
      'image': data.image,
      'create_at': data.createAt.toIso8601String(),
      'heading': data.heading,
      'title': data.title,
      'type': data.type,
      'theme': data.theme,
      'service_date': data.serviceDate.toIso8601String(),
      'preacher': data.preacher,
      'service_liturgies_table_id': data.serviceLiturgiesTableId,
      'liturgies_table_id': data.liturgiesTableId,
      'guide_is_visible': data.guideIsVisible,
    };
  }
  static Map<String, dynamic> serviceLiturgiesToMap(ServiceLiturgiesSupabase data) {
    return {
      if (data.id != null) 'id': data.id,
      'service_id': data.serviceId,
      'liturgy_id': data.liturgyId,
    };
  }

  static List<ServiceEntity> fromMapList(dynamic data) {
    List<ServiceEntity> services = [];
    for (dynamic entity in data) {
      services.add(
        ServiceEntity(
          id: entity['id'].runtimeType == String
              ? entity['id']
              : entity['id'].toString(),
          type: '',
          image: entity['image'],
          serviceLiturgiesTableId: entity['service_liturgies_table_id'],
          liturgiesTableId: entity['liturgies_table_id'],
          createAt: DateTime.parse(entity['create_at']),
          serviceDate: DateTime.parse(entity['service_date']),
          theme: entity['theme'],
          preacher: entity['preacher'],
          guideIsVisible: entity['guide_is_visible'],
          title: entity['title'],
          heading: entity['heading'],
          liturgiesList: entity.containsKey('service_liturgies')
              ? LiturgyAdapter.fromSupabase(
                  FlattenMixin.flattenByKey(
                    entity['service_liturgies'],
                    'liturgies',
                  ),
                )
              : [],
          lyricsList:
              entity.containsKey('service_lyrics') &&
                  entity['service_lyrics'].isNotEmpty
              ? LyricAdapter.fromMapList(
                  FlattenMixin.flattenByKey(entity['service_lyrics'], 'lyrics'),
                )
              : [],
        ),
      );
    }
    return services;
  }
}
