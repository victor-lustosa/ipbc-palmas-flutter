import '../../models/firestore-dtos/settings_dto.dart';

class SettingsDTOAdapter {

  static SettingsDTO fromMap(dynamic json) {
    return SettingsDTO(
      updateAt: json['updateAt'],
    );
  }

}
