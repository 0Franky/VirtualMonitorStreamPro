import 'package:process_run/shell.dart';

class ServerPreConfig {
  final List<String> preStartConfigCmds;
  bool get checkPreStartConfig => preStartConfigCmds.isNotEmpty;

  ServerPreConfig({this.preStartConfigCmds = const []});

  startPreConfig() async {
    if (!checkPreStartConfig) return;

    var shell = Shell();
    for (final cmd in preStartConfigCmds) {
      await Future.any([
        shell.run(cmd),
        Future.delayed(const Duration(seconds: 1)),
      ]);
    }
  }
}