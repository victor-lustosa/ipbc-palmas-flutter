import '../../models/firestore-dtos/settings_dto.dart';

class SettingsDTOAdapter {
  static SettingsDTO fromMap(dynamic json) {
    return SettingsDTO(
      fireUpdateId: json['fireUpdateId'],
    );
  }

  static Map<String, dynamic> toMap(SettingsDTO entity) {
    return {
      'fireUpdateId': entity.fireUpdateId,
    };
  }
}
