
import 'package:core_module/core_module.dart';

class ValidationUtil {

  final String firebaseDatabase = 'firebase';

  static String validationDatasource() {
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
