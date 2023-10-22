import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_platform_interface.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';
import 'package:virtual_monitor_stream_pro/utils/errors/no_server_command_found.dart';

class ServerStub implements ServerPlatformInterface {
  @override
  ServerPreConfig Internal_GetServerPreConfig() => ServerPreConfig();

  @override
  List<FfmpegConfig> Internal_GetServerFfmpegConfig() =>
      throw const NoServerCommandFound();

  @override
  FfmpegConfig Internal_GetServerFfmpegCpuConfig() =>
      throw const NoServerCommandFound();

  // @override
// List<VirtualMonitorConfig> Internal_GetServerVirtualMonitorConfig() => [---];
}
