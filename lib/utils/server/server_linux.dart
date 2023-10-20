import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_platform_interface.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

class ServerLinux implements ServerPlatformInterface {
  @override
  ServerPreConfig Internal_GetServerPreConfig() =>
      ServerPreConfig(preStartConfigCmds: [
        // "sudo apt install ffmpeg", // OR
        // "pacman -S ffmpeg", // OR
        // "yay -S ffmpeg-full-git", // OR
      ]);

  @override
  List<FfmpegConfig> Internal_GetServerFfmpegConfig() => [
        getHwAccConfig("cuda"),
        getHwAccConfig("cuda"),
        getHwAccConfig("vaapi"),
      ];

  // addVirtualMonitorCmds = [
  //   "xrandr --addmode VIRTUAL1 ${width}x$height",
  //   "xrandr --output VIRTUAL1 --mode ${width}x$height --left-of eDP1",
  // ];
  // removeVirtualMonitorCmds = [
  //   "xrandr --output VIRTUAL1 --off",
  // ];

  FfmpegConfig getHwAccConfig(String hwAcc) {
    return FfmpegConfig(
      useHWAcceleration: true,
      ffmpegGrubber: "x11grab",
      display: ":0.0",
      scaleVaapiConfig: "-vaapi_device /dev/dri/renderD128",
      vaapiDeviceConfig:
          '-vf \'format=nv12,hwupload,scale_vaapi=w=$DEFAULT_WIDTH:h=$DEFAULT_HEIGHT\'',
      videoCodec: "h264_vaapi",
      optionalParams: "-preset superfast -tune zerolatency",
    );
  }

  // @override
// List<VirtualMonitorConfig> Internal_GetServerVirtualMonitorConfig() => [---];
}
