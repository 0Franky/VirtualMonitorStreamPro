import 'dart:io';

import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_platform_interface.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

final usbmmiddPath =
    "${Directory.current.path}${Platform.pathSeparator}resources${Platform.pathSeparator}usbmmidd_v2${Platform.pathSeparator}";

class ServerWindows implements ServerPlatformInterface {
  @override
  ServerPreConfig Internal_GetServerPreConfig() =>
      ServerPreConfig(preStartConfigCmds: [
        'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 0'
      ]);

  @override
  List<FfmpegConfig> Internal_GetServerFfmpegConfig() => [
        getHwAccConfig("cuda"),
        getHwAccConfig("qsv"),
      ];

  // addVirtualMonitorCmds = [
  //   'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 1'
  // ];
  // removeVirtualMonitorCmds = [
  //   'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 0'
  // ];

  static FfmpegConfig getHwAccConfig(String hwAcc) {
    return FfmpegConfig(
      useHWAcceleration: true,
      ffmpegProgramFile: "ffmpeg.exe",
      ffmpegGrubber: "gdigrab",
      vaapiDeviceConfig:
          "-init_hw_device $hwAcc:0 -hwaccel $hwAcc -hwaccel_device $hwAcc",
      displayOptions:
          "-offset_x 0 -offset_y 0 -video_size ${DEFAULT_WIDTH}x$DEFAULT_HEIGHT",
      videoCodec: "h264_nvenc",
      display: "desktop",
    );
  }

  // @override
// List<VirtualMonitorConfig> Internal_GetServerVirtualMonitorConfig() => [---];
}
