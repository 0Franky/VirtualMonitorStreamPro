import 'dart:io';

import 'package:virtual_monitor_stream_pro/models/server_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_platform_interface.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server_stub.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server_windows.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server_linux.dart';

ServerPreConfig getServerPreConfig() {
  ServerPlatformInterface server;

  if (Platform.isLinux) {
    server = ServerLinux();
  } else if (Platform.isWindows) {
    server = ServerWindows();
  } else {
    server = ServerStub();
  }

  return server.Internal_GetServerPreConfig();
}

ServerConfig getServerConfig() {
  ServerPlatformInterface server;

  if (Platform.isLinux) {
    server = ServerLinux();
  } else if (Platform.isWindows) {
    server = ServerWindows();
  } else {
    server = ServerStub();
  }

  return ServerConfig(
    ffmpegConfigs: [
      ...server.Internal_GetServerFfmpegConfig(),
      server.Internal_GetServerFfmpegCpuConfig(),
    ],
    virtualMonitorConfigs: server.Internal_GetServerVirtualMonitorConfig(),
  );
}
