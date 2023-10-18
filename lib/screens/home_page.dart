import 'package:flutter/material.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/screens/client.dart';
import 'package:virtual_monitor_stream_pro/utils/server/server.dart';
import 'package:virtual_monitor_stream_pro/utils/side_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  if (getServerPreConfig().checkPreStartConfig)
                    ElevatedButton(
                      child: const Text('Pre config device'),
                      onPressed: () {
                        getServerPreConfig().startPreConfig();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Pre config device DONE!'),
                        ));
                        print("Pre config device DONE!");
                      },
                    ),
                ElevatedButton(
                  child: const Text('Start Server'),
                  onPressed: () async {
                    await getServerConfig().addVirtualMonitor();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('makeVirtualMonitor DONE!'),
                    ));
                    print("makeVirtualMonitor DONE!");

                    await getServerConfig().startServerStreaming();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('startServerStreaming DONE!'),
                    ));
                    print("startServerStreaming DONE!");
                  },
                ),
                ElevatedButton(
                  child: const Text('Stop Server'),
                  onPressed: () async {
                    await getServerConfig().removeVirtualMonitor();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('removeVirtualMonitor() DONE!'),
                    ));
                    print("removeVirtualMonitor() DONE!");
                  },
                ),
                ElevatedButton(
                  child: const Text('Client'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaPlayerScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
