import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';
import 'package:virtual_monitor_stream_pro/style/theme.dart';
// import 'package:window_manager/window_manager.dart';

class ClientScreen extends StatelessWidget {
  final String loopbackAddress;

  ClientScreen({this.loopbackAddress = '127.0.0.1:$DEFAULT_PORT'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Opacity(
          opacity: 0.8,
          child: appAppBar(
            context: context,
            title: '$APP_NAME - Client',
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.fullscreen_rounded,
                ),
                onPressed: toggleFullScreen,
              )
            ],
          ),
        ),
      ),
      body: MediaPlayer(source: loopbackAddress),
    );
  }

  void toggleFullScreen() async {
    // if (await windowManager.isFullScreen()) {
    //   await windowManager.setFullScreen(true);
    // } else {
    //   await windowManager.setFullScreen(false);
    // }
  }
}

class MediaPlayer extends StatefulWidget {
  final String source;

  MediaPlayer({required this.source});

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  late final player = Player(
    configuration: const PlayerConfiguration(
      // logLevel: MPVLogLevel.debug,
      title: '$APP_NAME Client',
      muted: true,
      protocolWhitelist: [STREAM_PROTOCOL],
    ),
  );

  late final controller = VideoController(
    player,
    configuration: VideoControllerConfiguration(
      enableHardwareAcceleration: true,
      width: MediaQuery.of(context).size.width.toInt(),
      height: MediaQuery.of(context).size.height.toInt(),
    ),
  );

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    if (player.platform is NativePlayer) {
      for (final config in CLIENT_INIT_PLAYER_PARAMS.entries) {
        await (player.platform as dynamic)
            .setProperty(config.key, config.value);
      }
    }

    if (kDebugMode) {
      print('================');
      print('$STREAM_PROTOCOL://${widget.source}$CLIENT_URI_PARAMS');
      print(
          '${CLIENT_INIT_PLAYER_PARAMS.entries.map((e) => '--${e.key}=${e.value}').toList().join(" ")} $STREAM_PROTOCOL://${widget.source}$CLIENT_URI_PARAMS');
      print('================');
    }
    player.open(Media('$STREAM_PROTOCOL://${widget.source}$CLIENT_URI_PARAMS'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Video(
        controller: controller,
        controls: NoVideoControls,
      ),
    );
  }
}
