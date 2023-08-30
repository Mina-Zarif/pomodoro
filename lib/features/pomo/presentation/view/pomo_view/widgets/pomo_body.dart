import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/core/utils/assets_app.dart';
import 'package:pomodoro/core/widgets/custom_timer.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_cubit.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';
import 'package:pomodoro/features/pomo/presentation/view/pomo_view/widgets/custom_app_buttons.dart';
import 'package:pomodoro/features/pomo/presentation/view/pomo_view/widgets/custom_pomo_mode.dart';
import 'package:pomodoro/features/pomo/presentation/view/setting_view/setting_view.dart';

class PomoBody extends StatelessWidget {
  const PomoBody({super.key, required this.cubit, required this.state});

  final PomoCubit cubit;
  final PomoState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.25,
      ),
      child: Column(
        children: [
          CustomPomoMode(
            iconPath: (cubit.indexApp % 2 == 0 && cubit.indexApp == 0)
                ? AssetsApp.focusIcon
                : AssetsApp.breakIcon,
            iconColor:
                (cubit.darkMode) ? Colors.white : const Color(0xff350b0a),
            backgroundColor: cubit.darkMode
                ? darkSecondaryButtonColors[cubit.indexApp]
                : lightSecondaryButtonColors[cubit.indexApp],
            textColor: cubit.darkMode ? Colors.white : Colors.black,
            title: titles[cubit.indexApp],
          ),
          const SizedBox(height: 20),
          InkWell(
            onDoubleTap: () {},
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              if (state is TimerRunning) {
                cubit.pauseTimer();
              } else {
                if (cubit.sound == true) {
                  cubit.assetsAudioPlayer.open(Audio(AssetsApp.startTimerAudio),
                      volume: double.maxFinite);
                  cubit.assetsAudioPlayer.play();
                }
                cubit.startTimer();
              }
            },
            child: CustomTimer(
              duration: cubit.times[cubit.indexApp],
              isPlay: state is TimerRunning,
              timerColor: cubit.darkMode
                  ? darkTextColors[cubit.indexApp]
                  : lightTextColors[cubit.indexApp],
            ),
          ),
          const SizedBox(height: 15),
          CustomAppButtons(
            moreTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  isIos: defaultTargetPlatform == TargetPlatform.iOS,
                  child: const SettingView(),
                  inheritTheme: false,
                  ctx: context,
                ),
              );
            },
            fastForwardTap: () {
              cubit.skipTimer();
            },
            playOrPauseTap: () async {
              if (state is TimerRunning) {
                cubit.pauseTimer();
              } else {
                if (cubit.sound == true) {
                  cubit.assetsAudioPlayer.open(
                    Audio(AssetsApp.startTimerAudio),
                    volume: double.infinity,
                  );
                  cubit.assetsAudioPlayer.play();
                }
                cubit.startTimer();
              }
            },
            isPlay: (state is TimerRunning),
            mainButtonBackgroundColor: (cubit.darkMode)
                ? darkMainButtonColors[cubit.indexApp]
                : lightMainButtonColors[cubit.indexApp],
            secondaryButtonBackgroundColor: (cubit.darkMode)
                ? darkSecondaryButtonColors[cubit.indexApp]
                : lightSecondaryButtonColors[cubit.indexApp],
          ),
        ],
      ),
    );
  }
}
