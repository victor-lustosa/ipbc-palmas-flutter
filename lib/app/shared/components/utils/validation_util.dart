import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import '../../../core/external/firestore_datasource.dart';

class ValidationUtil {

  final String firebaseDatabase = 'firebase';

  static Future<String> verifyUpdateFirebase(BuildContext context)  async {
    String fireUpdateId = await context.read<FirestoreDatasource>().verifyUpdateDatasource('settings');
    return fireUpdateId;
  }

 static String validationDatasource()  {
    switch (DateFormat('EEEE').format(DateTime.now())) {
      case 'Friday':
        return 'firebase';
      case 'Thursday':
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