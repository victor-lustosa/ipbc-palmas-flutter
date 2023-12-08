
import 'package:logger/logger.dart';

class AnalyticsUtil {

  static final _logger = Logger();

  static void recordError({
    required String name,
    required Exception error,
    required StackTrace st,
  }) {
    _logger.d('Record Error analytics event: $name');
    }
  static void  setCustomKey({
    required String name,
    required String key,
    required String value,
  }) {
    _logger.d('Custom Key analytics event: $name');
  }
}