import 'package:virtual_monitor_stream_pro/consts/configs.dart';

class FfmpegConfig {
  final String ffmpegGrubber;
  final String display;
  final String displayOptions;
  final String framerate;
  final String width;
  final String height;

  final bool useHWAcceleration;
  final String vaapiDeviceConfig;
  final String scaleVaapiConfig;
  final String videoCodec;

  final String qualityIndex;
  final String rate;
  final String bufsize;
  final String optionalParams;

  final String ffmpegProgramFile;
  final String ffmpegPath;

  final String protocol;
  final String clientIp;
  final String clientPort;

  FfmpegConfig({
    required this.ffmpegGrubber,
    required this.videoCodec,
    required this.display,
    required this.useHWAcceleration,
    this.displayOptions = "",
    this.vaapiDeviceConfig = "",
    this.scaleVaapiConfig = "",
    this.framerate = DEFAULT_REFRASH_RATE,
    this.width = DEFAULT_WIDTH,
    this.height = DEFAULT_HEIGHT,
    this.qualityIndex = '26',
    this.rate = "2000K",
    this.bufsize = "512k",
    this.optionalParams = "",
    this.ffmpegProgramFile = "ffmpeg",
    this.ffmpegPath = "ffmpeg",
    this.protocol = STREAM_PROTOCOL,
    this.clientIp = DEFAULT_CLIENT_IP,
    this.clientPort = DEFAULT_PORT,
  });

  String get ffmpegConfigParams =>
      '-f $ffmpegGrubber -s ${width}x$height -framerate $framerate $displayOptions ${useHWAcceleration ? '$vaapiDeviceConfig $scaleVaapiConfig' : ''} -i $display -c:v $videoCodec -qp:v $qualityIndex -bf 0 $optionalParams -b:v $rate -minrate $rate -maxrate $rate -bufsize $bufsize -f rawvideo $STREAM_PROTOCOL://$DEFAULT_CLIENT_IP:$DEFAULT_PORT';

  String get ffmpegConfigCmd => '${ffmpegPath}$ffmpegProgramFile $ffmpegConfigParams';
}
