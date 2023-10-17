import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/screens/client.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';
import 'package:virtual_monitor_stream_pro/utils/side_util.dart';

void main() {
  prepareApp();
  runApp(const MyApp());
}

void prepareApp() {
  WidgetsFlutterBinding.ensureInitialized();

  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: appTheme,
      home:  MediaPlayerScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(APP_NAME),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome on $APP_NAME',
            ),
            if (checkServer())
              const Text(
                'How do you want to use it?',
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (checkServer())
                  const Text(
                    'Server',
                  ),
                const Text(
                  'Client',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
