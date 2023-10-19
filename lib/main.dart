// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/screens/home_page_screen.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await prepareApp();
  runApp(const VirtualMonitorStreamPro());
}

Future<void> prepareApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  MediaKit.ensureInitialized();
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
