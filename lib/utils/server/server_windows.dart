import 'dart:io';

import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_platform_interface.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';
import 'package:virtual_monitor_stream_pro/models/virtual_monitor_config.dart';

final usbmmiddPath =
    "${Directory.current.path}${Platform.pathSeparator}resources${Platform.pathSeparator}usbmmidd_v2${Platform.pathSeparator}";

class ServerWindows implements ServerPlatformInterface {
  static String ffmpegProgramFile = "ffmpeg.exe";
  static String ffmpegGrubber = "gdigrab";
  static String display = "desktop";

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

  FfmpegConfig Internal_GetServerFfmpegCpuConfig() {
    return FfmpegConfig.getCpuConfig(
      ffmpegProgramFile: ffmpegProgramFile,
      ffmpegGrubber: ffmpegGrubber,
      display: display,
      displayOptions:
          "-offset_x 0 -offset_y 0 -video_size ${DEFAULT_WIDTH}x$DEFAULT_HEIGHT",
    );
  }

  VirtualMonitorConfig Internal_GetServerVirtualMonitorConfig() {
    return VirtualMonitorConfig(
      addVirtualMonitorCmds: [
        'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 1'
      ],
      removeVirtualMonitorCmds: [
        'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 0'
      ],
    );
  }

  FfmpegConfig getHwAccConfig(String hwAcc) {
    return FfmpegConfig(
      useHWAcceleration: true,
      ffmpegProgramFile: ffmpegProgramFile,
      ffmpegGrubber: ffmpegGrubber,
      display: display,
      hwAccelerationDeviceConfig:
          "-init_hw_device $hwAcc:0 -hwaccel $hwAcc -hwaccel_device $hwAcc",
      displayOptions:
          "-offset_x 0 -offset_y 0 -video_size ${DEFAULT_WIDTH}x$DEFAULT_HEIGHT",
      videoCodec: "h264_nvenc",
    );
  }
}
