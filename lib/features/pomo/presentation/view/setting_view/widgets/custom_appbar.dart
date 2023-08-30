import 'package:flutter/material.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_cubit.dart';
import 'package:pomodoro/features/pomo/presentation/mange/pomo_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  const CustomAppBar({super.key, required this.cubit, required this.state});

  final PomoCubit cubit;
  final PomoState state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      leading: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          cubit.setAppData();
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      title: const Text(
        "Settings",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
