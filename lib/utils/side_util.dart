import 'package:universal_platform/universal_platform.dart';

bool checkServer() {
  return UniversalPlatform.isLinux || UniversalPlatform.isWindows;
}

bool checkClient() {
  return !UniversalPlatform.isWeb;
}
