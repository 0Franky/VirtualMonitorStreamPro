import 'package:flutter/material.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/screens/client_screen.dart';
import 'package:virtual_monitor_stream_pro/screens/server_screen.dart';
import 'package:virtual_monitor_stream_pro/utils/side_util.dart';
import 'package:virtual_monitor_stream_pro/windgets/card_button.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  final vSpacer = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: vSpacer,
          children: [
            Text(
              'Welcome on $APP_NAME',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (checkServer())
              Text(
                'How do you want to use it?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            // SizedBox(height: 5),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: vSpacer * 2,
              children: [
                if (checkServer())
                  CardButton(
                    icon: Icons.dns_rounded, // Icons.cast
                    text: "Server",
                    onPress: () => onOpenServerScreen(context),
                  ),
                CardButton(
                  icon: Icons.connected_tv_rounded,
                  text: "Client",
                  onPress: () => onOpenClientScreen(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onOpenServerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ServerScreen(),
      ),
    );
  }

  void onOpenClientScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientScreen(),
      ),
    );
  }
}
