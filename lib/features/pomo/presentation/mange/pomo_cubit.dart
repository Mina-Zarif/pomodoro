import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/core/utils/app_data.dart';
import 'package:pomodoro/core/utils/local_notification.dart';
import 'package:pomodoro/core/utils/theming.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';

import '../../data/functions/calc_seconds_reminder.dart';
import '../../data/functions/get_cached_data.dart';
import '../../data/functions/parse_duration.dart';

class PomoCubit extends Cubit<PomoState> {
  PomoCubit() : super(PomoInitial()) {
    LocalNotificationService.initialize();
  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  List<Duration> defultTimes = [
    const Duration(minutes: 25), // focusTime
    const Duration(minutes: 5), // shortBreak
    const Duration(minutes: 15), // longBreak
  ];
  List<Duration> times = [
    const Duration(minutes: 25), // focusTime
    const Duration(minutes: 5), // shortBreak
    const Duration(minutes: 15), // longBreak
  ];

  TextEditingController focusLengthController =
          TextEditingController(text: "25:00"),
      shortBreakLenController = TextEditingController(text: "05:00"),
      longBreakLenController = TextEditingController(text: "15:00");

  int pomoUntilLongBreak = 1, shortBreaks = 0, indexApp = 0, counter = 1;

  bool darkMode = (ThemeMode.system == ThemeMode.dark),
      isPlay = true,
      sound = true,
      notification = true,
      autoResume = false;

  ThemeData appTheme = (ThemeMode.system == ThemeMode.light)
      ? AppThemes.lightTheme
      : AppThemes.darkTheme;

  Timer _timer = Timer.periodic(
    const Duration(),
    (timer) {},
  );

  void getAppData() {
    List data = getCacheData<AppData>(boxName);
    if (data.isEmpty) {
      setAppData();
    } else {
      AppData appData = AppData(
        autoResume: data[0].autoResume,
        isDark: data[0].isDark,
        times: data[0].times,
        shortBreaksTimes: data[0].shortBreaksTimes,
        notification: data[0].notification,
        sound: data[0].sound,
      );
      darkMode = appData.isDark;
      autoResume = appData.autoResume;
      focusLengthController.text = appData.times[0];
      shortBreakLenController.text = appData.times[1];
      longBreakLenController.text = appData.times[2];
      for (int i = 0; i < 3; i++) {
        defultTimes[i] = parseDuration(appData.times[i]);
        times[i] = defultTimes[i];
      }
      pomoUntilLongBreak = appData.shortBreaksTimes;
      notification = appData.notification;
      sound = appData.sound;
    }
    emit(GetCachedDataState());
  }

  void setAppData() {
    var boxData = Hive.box<AppData>(boxName);
    boxData.put(
      0,
      AppData(
        isDark: darkMode,
        times: [
          focusLengthController.text,
          shortBreakLenController.text,
          longBreakLenController.text
        ],
        shortBreaksTimes: pomoUntilLongBreak,
        notification: notification,
        sound: sound,
        autoResume: autoResume,
      ),
    );
  }

  void startTimer() {
    _startTimer();
  }

  void pauseTimer() {
    _timer.cancel();
    emit(TimerPaused());
  }

  void resumeTimer() {
    _startTimer();
  }

  void skipTimer() {
    _timer.cancel();
    counter++;
    indexApp = calcIndex();
    setDefultValues();
    emit(TimerSkipped());
  }

  void _startTimer() {
    emit(TimerRunning());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (times[indexApp].inSeconds > 0) {
        times[indexApp] -= const Duration(seconds: 1);
        emit(TimerRunning());
      } else {
        _timer.cancel();
        if (notification == true) {
          LocalNotificationService.showTextNotification(
            title: "${titles[indexApp]} Finished",
            body: "${titles[indexApp]} Timer Has Been Finished",
          );
        }
        counter++;
        indexApp = calcIndex();
        setDefultValues();
        emit(TimerFinished());
        if (autoResume == true) {
          _startTimer();
        }
      }
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  void playOrPause() {
    isPlay = !isPlay;
    emit(PlayOrPauseTimerState());
  }

  void changeModeTheme() {
    darkMode = !darkMode;
    if (appTheme == AppThemes.lightTheme) {
      appTheme = AppThemes.darkTheme;
    } else {
      appTheme = AppThemes.lightTheme;
    }
    emit(ChangingLightThemeModeState(darkMode));
  }

  void enableNotification() {
    notification = !notification;
    emit(EnableNotificationAndSoundState());
  }

  void notificationSound() {
    sound = !sound;
    emit(EnableNotificationAndSoundState());
  }

  void autoResumeToggle() {
    autoResume = !autoResume;
    emit(EnableAutoResumeToggleState());
  }

  void focusLenOnTap(Duration changedTime) {
    times[0] = changedTime;
    defultTimes[0] = changedTime;
    emit(SetNewDurationState());
  }

  void addPomoUntilLongBreak() {
    pomoUntilLongBreak++;
    emit(UpdatePomoUtilLongBreak());
  }

  void removePomoUntilLongBreak() {
    if (pomoUntilLongBreak > 0) {
      pomoUntilLongBreak--;
    }
    emit(UpdatePomoUtilLongBreak());
  }

  void longBreakLenOnTap(Duration changedTime) {
    times[2] = changedTime;
    defultTimes[2] = changedTime;
    emit(SetNewDurationState());
  }

  void shortBreakOnTap(Duration changedTime) {
    times[1] = changedTime;
    defultTimes[1] = changedTime;
    emit(SetNewDurationState());
  }

  void applyNewFocusDuration() {
    String secs = calcSecsReminder(
        minutes: times[0].inMinutes, seconds: times[0].inSeconds);
    defultTimes[0] = times[0];
    focusLengthController.text = "${times[0].inMinutes}:$secs";
    emit(ApplyNewDurationState());
  }

  void applyNewShortBreakDuration() {
    String secs = calcSecsReminder(
        minutes: times[1].inMinutes, seconds: times[1].inSeconds);
    defultTimes[1] = times[1];
    shortBreakLenController.text = "${times[1].inMinutes}:$secs";
    emit(ApplyNewDurationState());
  }

  void applyNewLongDurationDuration() {
    String secs = calcSecsReminder(
        minutes: times[2].inMinutes, seconds: times[2].inSeconds);
    defultTimes[2] = times[2];
    longBreakLenController.text = "${times[2].inMinutes}:$secs";
    emit(ApplyNewDurationState());
  }

  void setDefultValues() {
    times[0] = defultTimes[0];
    times[1] = defultTimes[1];
    times[2] = defultTimes[2];
    emit(SetDefaultDurationState());
  }

  int calcIndex() {
    if (counter % 2 == 1) {
      return 0;
    } else if (shortBreaks < pomoUntilLongBreak) {
      shortBreaks++;
      return 1;
    }
    shortBreaks = 0;
    counter = 0;
    return 2;
  }
}
