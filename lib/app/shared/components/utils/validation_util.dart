// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class ValidationUtil {

  final String firebaseDatabase = 'firebase';

 static String validationDatasource()  {
    switch (DateFormat('EEEE').format(DateTime.now())) {
      case 'Friday':
        return 'firebase';
      case 'Thursday':
        return 'hive';
      case 'Saturday':
        return 'firebase';
      case 'Sunday':
        return 'firebase';
      default:
        return 'hive';
    }
  }
 }