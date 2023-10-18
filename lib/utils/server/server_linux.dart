import 'package:virtual_monitor_stream_pro/models/server_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

ServerPreConfig Internal_GetServerPreConfig() => ServerPreConfig();

ServerConfigInterface Internal_GetServerConfig() => _LinuxServerConfig();

class _LinuxServerConfig extends ServerConfigInterface {
  _LinuxServerConfig() {
    ffmpegGrubber = "x11grab";
    display = ":0.0";
    scaleVaapiConfig = "-vaapi_device /dev/dri/renderD128";
    vaapiDeviceConfig =
        '-vf \'format=nv12,hwupload,scale_vaapi=w=$width:h=$height\'';
    videoCodec = "h264_vaapi";
    optionalParams = "-preset superfast -tune zerolatency";

    addVirtualMonitorCmds = [
      "xrandr --addmode VIRTUAL1 ${width}x$height",
      "xrandr --output VIRTUAL1 --mode ${width}x$height --left-of eDP1",
    ];
    removeVirtualMonitorCmds = [
      "xrandr --output VIRTUAL1 --off",
    ];
  }
}
