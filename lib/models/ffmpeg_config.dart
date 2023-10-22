import 'package:virtual_monitor_stream_pro/consts/configs.dart';

class FfmpegConfig {
  final String ffmpegGrubber;
  final String display;
  final String displayOptions;
  final int framerate;
  final int width;
  final int height;

  final bool useHWAcceleration;
  final String hwAccelerationDeviceConfig;
  final String hwAccelerationOptionalConfig;
  final String videoCodec;

  final int qualityIndex;
  final String rate;
  final String bufsize;
  final String optionalParams;

  final String ffmpegProgramFile;
  final String ffmpegPath;

  final String protocol;
  final String clientIp;
  final int clientPort;

  FfmpegConfig({
    required this.ffmpegGrubber,
    required this.videoCodec,
    required this.display,
    required this.useHWAcceleration,
    this.displayOptions = "",
    this.hwAccelerationDeviceConfig = "",
    this.hwAccelerationOptionalConfig = "",
    this.framerate = DEFAULT_REFRASH_RATE,
    this.width = DEFAULT_WIDTH,
    this.height = DEFAULT_HEIGHT,
    this.qualityIndex = 26,
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
      '-f $ffmpegGrubber -s ${width}x$height -framerate $framerate $displayOptions ${useHWAcceleration ? '$hwAccelerationDeviceConfig $hwAccelerationOptionalConfig' : ''} -i $display -c:v $videoCodec ${useHWAcceleration ? '-qp:v $qualityIndex -b:v $rate -minrate $rate' : ''} -bf 0 $optionalParams ${useHWAcceleration ? '-maxrate $rate' : ''} -bufsize $bufsize -f rawvideo $STREAM_PROTOCOL://$DEFAULT_CLIENT_IP:$DEFAULT_PORT';

  String get ffmpegConfigCmd =>
      '$ffmpegPath$ffmpegProgramFile $ffmpegConfigParams';

  static FfmpegConfig getCpuConfig({
    required String ffmpegProgramFile,
    required String ffmpegGrubber,
    required String display,
    String displayOptions = "",
    int framerate = 30,
  }) {
    return FfmpegConfig(
      useHWAcceleration: false,
      ffmpegProgramFile: ffmpegProgramFile,
      ffmpegGrubber: ffmpegGrubber,
      display: display,
      videoCodec: "libx264",
      framerate: framerate,
      optionalParams:
          "-profile:v baseline -trellis 0 -subq 1 -level 32 -preset superfast -tune zerolatency -crf 30 -threads 0 -refs 4 -coder 0 -b_strategy 0 -sc_threshold 0 -x264-params vbv-maxrate=2000:slice-max-size=1500:keyint=30:min-keyint=10: -pix_fmt yuv420p -an",
      displayOptions: displayOptions,
    );
  }
}
