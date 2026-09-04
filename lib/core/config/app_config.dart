import 'package:flutter/foundation.dart';

class AppConfig {
  static const String appName = 'Gaia Connect';
  static const String appVersion = '1.0.0';

  static const String _devBaseUrl = 'http://localhost:8000';
  static const String _prodBaseUrl = 'https://api.gaiaconnect.dev';

  static String get apiBaseUrl {
    if (kDebugMode) return _devBaseUrl;
    return _prodBaseUrl;
  }

  static String get syncEndpoint => '$apiBaseUrl/api/v1/sync';

  static const String emergencyNumber = '112';
  static const String appNameLower = 'gaiaconnect';
}
