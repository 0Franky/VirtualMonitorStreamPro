import 'package:flutter/material.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server.dart';

class ServerScreen extends StatelessWidget {
  const ServerScreen({super.key});

  final vSpacer = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(context: context, title: '$APP_NAME - Server'),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: vSpacer,
          children: [
            if (getServerPreConfig().checkPreStartConfig)
              ElevatedButton(
                child: const Text('Pre config device'),
                onPressed: () => onStartPreConfig(context),
              ),
            ElevatedButton(
              child: const Text('Start Server'),
              onPressed: () => onStartServer(context),
            ),
            ElevatedButton(
              child: const Text('Stop Server'),
              onPressed: () => onStopServer(context),
            ),
          ],
        ),
      ),
    );
  }

  void onStartPreConfig(BuildContext context) {
    getServerPreConfig().startPreConfig();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Pre config device DONE!'),
    ));
    print("Pre config device DONE!");
  }

  void onStartServer(BuildContext context) async {
    await getServerConfig().addVirtualMonitor();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('makeVirtualMonitor DONE!'),
    ));
    print("makeVirtualMonitor DONE!");

    await getServerConfig().startServerStreaming(getServerConfig().ffmpegConfigs[0]);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('startServerStreaming DONE!'),
    ));
    print("startServerStreaming DONE!");
  }

  void onStopServer(BuildContext context) async {
    await getServerConfig().removeVirtualMonitor();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('removeVirtualMonitor() DONE!'),
    ));
    print("removeVirtualMonitor() DONE!");
  }
}
