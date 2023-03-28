
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import '../../core/external/firestore_datasource.dart';
import '../../lyric/infra/adapters/firestore-dtos/settings_dto_adapter.dart';
import 'package:provider/provider.dart';

import '../../lyric/infra/models/firestore-dtos/settings_dto.dart';
class ValidationUtil {

  static Future<DateTime> verifyUpdateFirebase(BuildContext context, DateTime updateAt)  async {
    SettingsDTO settings = SettingsDTO(updateAt: Timestamp.now());
    FirestoreDatasource fire = context.read<FirestoreDatasource>();

    Stream<List> data = await fire.verifyUpdateDatasource('settings');
    data.map((entity) => settings = SettingsDTOAdapter.fromMap(entity));
    return settings.updateAt.toDate();
  }

 static String validationDatasource()  {
    switch (DateFormat('EEEE').format(DateTime.now())) {
      case 'Friday':
        return 'firebase';
      case 'Saturday':
        return 'firebase';
      case 'Sunday':
        return 'firebase';
      default:
        return 'hive';
    }
  }
 }

main() async{
// var result = await ValidationUtil.validationDatasource(DateTime.parse('2023-04-01 00:00:00.000'));
// print(result.toString());
}