import 'dart:io';

import 'package:virtual_monitor_stream_pro/models/server_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server_stub.dart'
    as stub;
import 'package:virtual_monitor_stream_pro/utils/server/server_windows.dart'
    as windows;
import 'package:virtual_monitor_stream_pro/utils/server/server_linux.dart'
    as linux;

ServerPreConfig getServerPreConfig() {
  if (Platform.isLinux) {
    return linux.Internal_GetServerPreConfig();
  } else if (Platform.isWindows) {
    return windows.Internal_GetServerPreConfig();
  } else {
    return stub.Internal_GetServerPreConfig();
  }
}

ServerConfigInterface getServerConfig() {
  if (Platform.isLinux) {
    return linux.Internal_GetServerConfig();
  } else if (Platform.isWindows) {
    return windows.Internal_GetServerConfig();
  } else {
    return stub.Internal_GetServerConfig();
  }
}
