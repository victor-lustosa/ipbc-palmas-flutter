import 'package:logger/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AnalyticsUtil {

  final _logger = Logger();

  void recordError({
    required String name,
    required Exception error,
    required StackTrace st,
  }) {
    _logger.d('Record Error analytics event: $name');
      FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
    }
  void setCustomKey({
    required String name,
    required String key,
    required String value,
  }) {
    _logger.d('Custom Key analytics event: $name');
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  }
}