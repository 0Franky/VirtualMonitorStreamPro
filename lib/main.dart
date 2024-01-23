// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/screens/home_page_screen.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';
// import 'package:window_manager/window_manager.dart';

void main() async {
  await prepareApp();
  runApp(const VirtualMonitorStreamPro());
}

Future<void> prepareApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isDesktop) {
    // await windowManager.ensureInitialized();
  }
  MediaKit.ensureInitialized();
  VideoPlayerMediaKit.ensureInitialized(
    android: true,          // default: false    -    dependency: media_kit_libs_android_video
    // iOS: true,              // default: false    -    dependency: media_kit_libs_ios_video
    // macOS: true,            // default: false    -    dependency: media_kit_libs_macos_video
    windows: true,          // default: false    -    dependency: media_kit_libs_windows_video
    linux: true,            // default: false    -    dependency: media_kit_libs_linux
  );
}

class VirtualMonitorStreamPro extends StatefulWidget {
  const VirtualMonitorStreamPro({super.key});

  @override
  State<VirtualMonitorStreamPro> createState() =>
      _VirtualMonitorStreamProState();
}

class _VirtualMonitorStreamProState extends State<VirtualMonitorStreamPro> {
  @override
  void dispose() {
    disposeApp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: appTheme,
      home: const HomePageScreen(),
    );
  }

  void disposeApp() {
    // FFmpegKit.cancel();
  }
}
