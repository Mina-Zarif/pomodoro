import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/core/utils/assets_app.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_cubit.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';
import 'package:pomodoro/features/pomo/presentation/view/pomo_view/widgets/pomo_body.dart';

class PomoView extends StatelessWidget {
  const PomoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PomoCubit, PomoState>(
      listener: (context, state) {
        PomoCubit cubit = BlocProvider.of(context);
        if (state is TimerFinished && cubit.sound == true) {
          cubit.assetsAudioPlayer.open(Audio(AssetsApp.finishTimerAudio),volume: double.maxFinite);
          cubit.assetsAudioPlayer.play();
        }
      },
      builder: (context, state) {
        PomoCubit cubit = BlocProvider.of(context);
        return Scaffold(
          backgroundColor: cubit.darkMode
              ? Colors.black
              : lightBackgroundColors[cubit.indexApp],
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: PomoBody(
                cubit: cubit,
                state: state,
              ),
            ),
          ),
        );
      },
    );
  }
}
