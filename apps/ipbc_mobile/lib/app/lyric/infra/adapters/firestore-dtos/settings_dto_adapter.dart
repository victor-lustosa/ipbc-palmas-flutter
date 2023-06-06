import '../../models/firestore-dtos/settings_dto.dart';

class SettingsDTOAdapter {
  static SettingsDTO fromMap(dynamic json) {
    return SettingsDTO(
      fireId: json['fireId'],
    );
  }

  static Map<String, dynamic> toMap(SettingsDTO entity) {
    return {
      'fireId': entity.fireId,
    };
  }
}
