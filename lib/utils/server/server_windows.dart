import 'dart:io';

import 'package:virtual_monitor_stream_pro/models/server_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

final usbmmiddPath =
    "${Directory.current.path}${Platform.pathSeparator}resources${Platform.pathSeparator}usbmmidd_v2${Platform.pathSeparator}";

ServerPreConfig Internal_GetServerPreConfig() =>
    ServerPreConfig(preStartConfigCmds: [
      'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 0'
    ]);

ServerConfigInterface Internal_GetServerConfig() => _WindowsServerConfig();

class _WindowsServerConfig extends ServerConfigInterface {
  _WindowsServerConfig() {
    const hwAcc = "cuda";

    ffmpegGrubber = "gdigrab";
    vaapiDeviceConfig =
        "-init_hw_device $hwAcc:0 -hwaccel $hwAcc -hwaccel_device $hwAcc";
    displayOptions =
        "-offset_x 0 -offset_y 0 -video_size ${width}x$height";
    videoCodec = "h264_nvenc";
    display = "desktop";

    addVirtualMonitorCmds = [
      'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 1'
    ];
    removeVirtualMonitorCmds = [
      'cmd /k "${usbmmiddPath}deviceinstaller64.exe" enableidd 0'
    ];
  }
}
