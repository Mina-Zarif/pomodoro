import 'package:flutter/material.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/core/widgets/custom_counter.dart';
import 'package:pomodoro/core/widgets/custom_flutter_switch.dart';
import 'package:pomodoro/core/widgets/custom_setting_item.dart';
import 'package:pomodoro/core/widgets/custom_time_picker.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_cubit.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key, required this.cubit, required this.state});

  final PomoCubit cubit;
  final PomoState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 32, start: 32, end: 32),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            CustomSettingItem(
              title: "Dark Mode",
              actionWidget: CustomFlutterSwitch(
                onToggle: (value) => cubit.changeModeTheme(),
                switchValue: cubit.darkMode,
                activeColor: lightTextColors[cubit.indexApp],
              ),
            ),
            CustomSettingItem(
              title: "Focus length",
              actionWidget: CustomTimePicker(
                initDuration: cubit.defultTimes[0],
                textEditingController: cubit.focusLengthController,
                onChange: (changedTimer) => cubit.focusLenOnTap(changedTimer),
                onTapCancel: () =>
                    cubit.focusLenOnTap(const Duration(minutes: 25)),
                onTapOK: () {
                  cubit.applyNewFocusDuration();
                  Navigator.of(context).pop();
                },
              ),
            ),
            CustomSettingItem(
              title: "Pomo until long break",
              actionWidget: CustomCounter(
                backgroundColor: lightTextColors[cubit.indexApp],
                iconsColor: Colors.white,
                counter: cubit.pomoUntilLongBreak,
                onTapAdd: () => cubit.addPomoUntilLongBreak(),
                onTapRemove: () => cubit.removePomoUntilLongBreak(),
              ),
            ),
            CustomSettingItem(
              title: "Short break length",
              actionWidget: CustomTimePicker(
                textEditingController: cubit.shortBreakLenController,
                initDuration: cubit.defultTimes[1],
                onChange: (changedTimer) => cubit.shortBreakOnTap(changedTimer),
                onTapCancel: () =>
                    cubit.focusLenOnTap(const Duration(minutes: 25)),
                onTapOK: () {
                  cubit.applyNewShortBreakDuration();
                  Navigator.pop(context);
                },
              ),
            ),
            CustomSettingItem(
              title: "Long break length",
              actionWidget: CustomTimePicker(
                initDuration: cubit.defultTimes[2],
                textEditingController: cubit.longBreakLenController,
                onChange: (changedTimer) =>
                    cubit.longBreakLenOnTap(changedTimer),
                onTapCancel: () =>
                    cubit.focusLenOnTap(const Duration(minutes: 25)),
                onTapOK: () {
                  cubit.applyNewLongDurationDuration();
                  Navigator.pop(context);
                },
              ),
            ),
            CustomSettingItem(
              title: "Auto resume timer",
              actionWidget: CustomFlutterSwitch(
                onToggle: (value) => cubit.autoResumeToggle(),
                switchValue: cubit.autoResume,
                activeColor: lightTextColors[cubit.indexApp],
              ),
            ),
            CustomSettingItem(
              title: "Sound",
              actionWidget: CustomFlutterSwitch(
                onToggle: (value) => cubit.notificationSound(),
                switchValue: cubit.sound,
                activeColor: lightTextColors[cubit.indexApp],
              ),
            ),
            CustomSettingItem(
              title: "Notifications",
              actionWidget: CustomFlutterSwitch(
                onToggle: (value) => cubit.enableNotification(),
                switchValue: cubit.notification,
                activeColor: lightTextColors[cubit.indexApp],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
