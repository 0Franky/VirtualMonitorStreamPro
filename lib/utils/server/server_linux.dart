import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_platform_interface.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';

class ServerLinux implements ServerPlatformInterface {
  static String ffmpegProgramFile = "ffmpeg";
  static String ffmpegGrubber = "x11grab";

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
      ffmpegProgramFile: ffmpegProgramFile,
      ffmpegGrubber: ffmpegGrubber,
      display: ":0.0",
      hwAccelerationOptionalConfig: "-vaapi_device /dev/dri/renderD128",
      hwAccelerationDeviceConfig:
          '-vf \'format=nv12,hwupload,scale_vaapi=w=$DEFAULT_WIDTH:h=$DEFAULT_HEIGHT\'',
      videoCodec: "h264_vaapi",
      optionalParams: "-preset superfast -tune zerolatency",
    );
  }

  FfmpegConfig Internal_GetServerFfmpegCpuConfig() {
    return FfmpegConfig.getCpuConfig(
      ffmpegProgramFile: ffmpegProgramFile,
      ffmpegGrubber: ffmpegGrubber,
      display: ":0.0",
    );
  }

  // @override
// List<VirtualMonitorConfig> Internal_GetServerVirtualMonitorConfig() => [---];
}
