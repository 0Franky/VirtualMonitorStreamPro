const STREAM_PROTOCOL = 'udp';
const CLIENT_URI_PARAMS = '?overrun_nonfatal=1';
const CLIENT_INIT_PLAYER_PARAMS = [
  ['no-cache', ''],
  ['untimed', ''],
  ['no-demuxer-thread', ''],
  ['vd-lavc-threads', '1'],
  // ['keep-open', ''],
  // ['hwdec-codecs', 'all'],
  // ['cache-secs', '0'],
  // ['demuxer-readahead-secs', '0'],
];
const DEFAULT_CLIENT_IP = "192.168.1.10";
const DEFAULT_PORT = "12345";
