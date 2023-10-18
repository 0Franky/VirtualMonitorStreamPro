import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:process_run/shell.dart';

abstract class ServerConfigInterface {
  late String ffmpegGrubber;
  String vaapiDeviceConfig = "";
  String scaleVaapiConfig = "";
  late String videoCodec;
  late String display;
  String displayOptions = "";
  String qualityIndex = '26';
  String rate = "2000K";
  String bufsize = "512k";
  String framerate = "60";
  String width = "1920";
  String height = "1080";
  String optionalParams = "";
  late String ffmpegCmd =
      '-f $ffmpegGrubber -s ${width}x$height -framerate $framerate $displayOptions $vaapiDeviceConfig $scaleVaapiConfig -i $display -c:v $videoCodec -qp:v $qualityIndex -bf 0 $optionalParams -b:v $rate -minrate $rate -maxrate $rate -bufsize $bufsize -f rawvideo $STREAM_PROTOCOL://$DEFAULT_CLIENT_IP:$DEFAULT_PORT';

  late List<String> addVirtualMonitorCmds;
  late List<String> removeVirtualMonitorCmds;

  FFmpegSession? fFmpegSession;

  Future<void> startServerStreaming() async {
    print(ffmpegCmd);
    fFmpegSession = await FFmpegKit.execute(ffmpegCmd);
    final returnCode = await fFmpegSession!.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      if (kDebugMode) {
        print("SUCCESS");
      }
    } else if (ReturnCode.isCancel(returnCode)) {
      if (kDebugMode) {
        print("CANCEL");
      }
    } else {
      if (kDebugMode) {
        print("ERROR");
      }
    }
  }

  void stopServerStreaming() {
    if (fFmpegSession != null) FFmpegKit.cancel(fFmpegSession!.getSessionId());
  }

  Future<void> addVirtualMonitor() async {
    var shell = Shell();
    for (final cmd in addVirtualMonitorCmds) {
      await Future.any([
        shell.run(cmd),
        Future.delayed(const Duration(seconds: 1)),
      ]);
    }
  }

  Future<void> removeVirtualMonitor() async {
    var shell = Shell();
    for (final cmd in removeVirtualMonitorCmds) {
      await Future.any([
        shell.run(cmd),
        Future.delayed(const Duration(seconds: 1)),
      ]);
    }
  }
}
