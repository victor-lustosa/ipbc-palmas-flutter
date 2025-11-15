import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

mixin DeviceInfoMixin {
  Future<bool> isBrowserOnDevice() async {
    if (!kIsWeb) {
      return false;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;

    String userAgent = (webInfo.userAgent ?? '').toLowerCase();

    return userAgent.toLowerCase().contains('android') ||
        userAgent.contains('iphone') ||
        userAgent.contains('ipad') ||
        userAgent.contains('ipod');
  }
}
