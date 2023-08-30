import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_cubit.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';
import 'package:pomodoro/features/pomo/presentation/view/setting_view/widgets/custom_appbar.dart';
import 'package:pomodoro/features/pomo/presentation/view/setting_view/widgets/setting_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomoCubit, PomoState>(
      builder: (context, state) {
        PomoCubit cubit = BlocProvider.of(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: cubit.darkMode
                ? Colors.black
                : lightBackgroundColors[cubit.indexApp],
            appBar: CustomAppBar(
              state: state,
              cubit: cubit,
            ),
            body: SettingBody(
              state: state,
              cubit: BlocProvider.of<PomoCubit>(context),
            ),
          ),
        );
      },
    );
  }
}
