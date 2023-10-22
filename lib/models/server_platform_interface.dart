import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

abstract class ServerPlatformInterface {
  static late final String ffmpegProgramFile;
  static late final String ffmpegGrubber;

  ServerPreConfig Internal_GetServerPreConfig();

  List<FfmpegConfig> Internal_GetServerFfmpegConfig();

  FfmpegConfig Internal_GetServerFfmpegCpuConfig();

  // List<VirtualMonitorConfig> Internal_GetServerVirtualMonitorConfig();
}
