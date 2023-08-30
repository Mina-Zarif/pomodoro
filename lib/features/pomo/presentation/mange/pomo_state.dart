abstract class PomoState {}

class PomoInitial extends PomoState {}

class SetNewDurationState extends PomoState {}

class SetDefaultDurationState extends PomoState {}

class ApplyNewDurationState extends PomoState {}

class UpdatePomoUtilLongBreak extends PomoState {}

class ChangingLightThemeModeState extends PomoState {
  final bool isDarkMode;

  ChangingLightThemeModeState(this.isDarkMode);
}

class PlayOrPauseTimerState extends PomoState {}

class TimerRunning extends PomoState {
/*  final Duration remainingTime;

  TimerRunning({required this.remainingTime});*/
}

class TimerFinished extends PomoState {}

class TimerSkipped extends PomoState {}

class TimerPaused extends PomoState {}

class GetCachedDataState extends PomoState {}

class EnableNotificationAndSoundState extends PomoState {}

class EnableAutoResumeToggleState extends PomoState {}
