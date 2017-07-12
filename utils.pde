public String secondsToMMSS(int totalSecs) {
  int minutes = totalSecs / 60;
  int seconds = totalSecs % 60;
  return String.format("%02d:%02d", minutes, seconds);
}