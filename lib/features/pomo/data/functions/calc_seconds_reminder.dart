String calcSecsReminder({required int minutes, required int seconds}) {
  int reminderSecs = (seconds) - ((minutes) * 60);
  return (reminderSecs < 10) ? "0$reminderSecs" : reminderSecs.toString();
}
