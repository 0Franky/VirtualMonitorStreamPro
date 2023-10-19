import 'package:flutter/material.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/style/colors.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: appSeedColor,
    brightness: Brightness.dark,
  ),
);

AppBar appAppBar({
  required BuildContext context,
  String title = APP_NAME,
  List<Widget>? actions,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(title),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: actions,
  );
}
