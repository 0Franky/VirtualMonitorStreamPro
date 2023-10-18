import 'dart:io';

// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session.dart';
// import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
// import 'package:flutter/foundation.dart';
import 'package:virtual_monitor_stream_pro/consts/configs.dart';
// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:process_run/shell.dart';

abstract class ServerConfigInterface {
  late String ffmpegGrubber;
  late String videoCodec;
  late String display;
  String vaapiDeviceConfig = "";
  String scaleVaapiConfig = "";
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

  // FFmpegSession? ffmpegSession;
  var ffmpegShell = Shell();

  Future<void> startServerStreaming() async {
    print(ffmpegCmd);
    // ffmpegSession = await FFmpegKit.execute(ffmpegCmd);
    // final returnCode = await ffmpegSession!.getReturnCode();

    // if (ReturnCode.isSuccess(returnCode)) {
    //   if (kDebugMode) {
    //     print("SUCCESS");
    //   }
    // } else if (ReturnCode.isCancel(returnCode)) {
    //   if (kDebugMode) {
    //     print("CANCEL");
    //   }
    // } else {
    //   if (kDebugMode) {
    //     print("ERROR");
    //   }
    // }

    final ffmpegPath =
        "${Directory.current.path}${Platform.pathSeparator}resources${Platform.pathSeparator}ffmpeg${Platform.pathSeparator}";
    print("${ffmpegPath}ffmpeg.exe $ffmpegCmd");
    ffmpegShell.run("${ffmpegPath}ffmpeg.exe $ffmpegCmd");
  }

  void stopServerStreaming() {
    // if (ffmpegSession != null) FFmpegKit.cancel(ffmpegSession!.getSessionId());
    ffmpegShell.kill();
  }

  Future<void> addVirtualMonitor() async {
    for (final cmd in addVirtualMonitorCmds) {
      final asyncFn = () async {
        final shell = Shell();
        await shell.run(cmd);
      };
      await Future.any([
        asyncFn(),
        Future.delayed(const Duration(seconds: 5)),
      ]);
    }
  }

  Future<void> removeVirtualMonitor() async {
    for (final cmd in removeVirtualMonitorCmds) {
      final asyncFn = () async {
        final shell = Shell();
        await shell.run(cmd);
      };
      await Future.any([
        asyncFn(),
        Future.delayed(const Duration(seconds: 5)),
      ]);
    }
  }
}
