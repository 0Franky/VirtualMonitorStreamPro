import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:virtual_monitor_stream_pro/consts/configs.dart';
import 'package:virtual_monitor_stream_pro/consts/strings.dart';

class MediaPlayerScreen extends StatelessWidget {
  final String loopbackAddress;

  MediaPlayerScreen({this.loopbackAddress = '127.0.0.1'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaPlayer(source: loopbackAddress),
    );
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
    // TODO - asked to media-kit group
    // player.setParams(CLIENT_INIT_PLAYER_PARAMS);
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
