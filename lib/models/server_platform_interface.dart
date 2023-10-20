import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

// TODO - convert abstract singleton class?

abstract class ServerPlatformInterface {
  ServerPreConfig Internal_GetServerPreConfig();

  List<FfmpegConfig> Internal_GetServerFfmpegConfig();

  // List<VirtualMonitorConfig> Internal_GetServerVirtualMonitorConfig();
}