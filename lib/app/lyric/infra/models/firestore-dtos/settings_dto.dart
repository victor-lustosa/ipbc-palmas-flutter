
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsDTO {
  const SettingsDTO({
    required this.updateAt,
  });
  final Timestamp updateAt;
}
