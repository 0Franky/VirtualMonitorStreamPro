import 'dart:io';

// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session.dart';
// import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
// import 'package:flutter/foundation.dart';
// import 'package:virtual_monitor_stream_pro/consts/configs.dart';
// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:process_run/shell.dart';
import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/models/virtual_monitor_config.dart';

class ServerConfig {
  final List<FfmpegConfig> ffmpegConfigs;
  final VirtualMonitorConfig virtualMonitorConfigs;

  // FFmpegSession? ffmpegSession;
  Shell ffmpegShell = Shell();

  ServerConfig({
    required this.ffmpegConfigs,
    required this.virtualMonitorConfigs,
  });

  Future<void> startServerStreaming(FfmpegConfig currFfmpegConfig) async {
    print(currFfmpegConfig.ffmpegConfigCmd);
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

    // final ffmpegPath =
    //     "${Directory.current.path}${Platform.pathSeparator}resources${Platform.pathSeparator}ffmpeg${Platform.pathSeparator}";
    // print("${ffmpegPath}$ffmpegProgramFile $ffmpegCmd");
    await ffmpegShell.run(currFfmpegConfig.ffmpegConfigCmd);
  }

  void stopServerStreaming() {
    // if (ffmpegSession != null) FFmpegKit.cancel(ffmpegSession!.getSessionId());
    ffmpegShell.kill(ProcessSignal.sigkill);
  }

  Future<void> addVirtualMonitor() async {
    for (final cmd in virtualMonitorConfigs.addVirtualMonitorCmds) {
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
    for (final cmd in virtualMonitorConfigs.removeVirtualMonitorCmds) {
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
