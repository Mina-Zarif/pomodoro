Duration parseDuration(String s) {
  int minutes = 0;
  int seconds = 0;
  List<String> parts = s.split(':');
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  seconds = (int.parse(parts[parts.length - 1]));
  return Duration(minutes: minutes, seconds: seconds);
}
