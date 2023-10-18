// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/screens/home_page.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';

void main() {
  prepareApp();
  runApp(const VirtualMonitorStreamPro());
}

void prepareApp() {
  WidgetsFlutterBinding.ensureInitialized();

  // Necessary initialization for package:media_kit.
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
      home: const HomePage(),
    );
  }

  void disposeApp() {
    // FFmpegKit.cancel();
  }
}
