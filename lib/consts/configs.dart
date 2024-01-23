const STREAM_PROTOCOL = 'udp';
const CLIENT_URI_PARAMS = '?overrun_nonfatal=1';
const CLIENT_INIT_PLAYER_PARAMS = {
  'rtsp-transport': 'udp',
  'profile': 'low-latency',

  'scorrect-pts': 'no',
  'fps': '23.976',

  'cache': 'no',
  'cache-on-disk': 'no',

  'demuxer-thread': 'no',
  'demuxer-max-bytes': '0',
  
  'vd-lavc-threads': '1',

  // 'no-cache': '',
  'untimed': '',
  // 'no-demuxer-thread': '',
  // 'vd-lavc-threads': '1',

  // 'keep-open': '',
  // 'hwdec-codecs': 'all',
  // 'cache-secs': '0',
  // 'demuxer-readahead-secs': '0',
};
const DEFAULT_CLIENT_IP = "192.168.1.10";
const DEFAULT_PORT = 12345;
const DEFAULT_WIDTH = 1920;
const DEFAULT_HEIGHT = 1080;
const DEFAULT_REFRASH_RATE = 60;
const DEFAULT_SCREEN_SIZE = "${DEFAULT_WIDTH}x$DEFAULT_HEIGHT";
