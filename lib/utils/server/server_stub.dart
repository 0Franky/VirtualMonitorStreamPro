import 'package:virtual_monitor_stream_pro/models/server_config.dart';
import 'package:virtual_monitor_stream_pro/models/server_pre_config.dart';
import 'package:virtual_monitor_stream_pro/utils/errors/no_server_command_found.dart';

ServerPreConfig Internal_GetServerPreConfig() => ServerPreConfig();

ServerConfigInterface Internal_GetServerConfig() =>
    throw const NoServerCommandFound();
