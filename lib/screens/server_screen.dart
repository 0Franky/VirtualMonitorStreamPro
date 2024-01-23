import 'package:flutter/material.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/models/ffmpeg_config.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  final vSpacer = 30.0;

  final serverPreConfig = getServerPreConfig();
  final serverConfig = getServerConfig();
  late FfmpegConfig selectedFfmpegConfig;

  @override
  void initState() {
    super.initState();

    selectedFfmpegConfig = serverConfig.ffmpegConfigs[0];
  }

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
            DropdownButton<FfmpegConfig>(
              alignment: AlignmentDirectional.center,
              value: selectedFfmpegConfig,
              items: serverConfig.ffmpegConfigs
                  .map(
                    (config) => DropdownMenuItem(
                      value: config,
                      child: Text(config.configName),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFfmpegConfig = value!;
                });
              },
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
    serverPreConfig.startPreConfig();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Pre config device DONE!'),
    ));
    print("Pre config device DONE!");
  }

  void onStartServer(BuildContext context) async {
    await serverConfig.addVirtualMonitor();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('makeVirtualMonitor DONE!'),
    ));
    print("makeVirtualMonitor DONE!");

    await serverConfig.startServerStreaming(selectedFfmpegConfig!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('startServerStreaming DONE!'),
    ));
    print("startServerStreaming DONE!");
  }

  void onStopServer(BuildContext context) async {
    serverConfig.stopServerStreaming();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('stopServerStreaming() DONE!'),
    ));
    print("stopServerStreaming() DONE!");

    await serverConfig.removeVirtualMonitor();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('removeVirtualMonitor() DONE!'),
    ));
    print("removeVirtualMonitor() DONE!");
  }
}
