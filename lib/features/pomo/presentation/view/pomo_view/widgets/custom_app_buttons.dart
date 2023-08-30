import 'package:flutter/material.dart';
import 'package:pomodoro/core/widgets/custom_button.dart';

class CustomAppButtons extends StatelessWidget {
  const CustomAppButtons(
      {super.key,
      required this.moreTap,
      required this.playOrPauseTap,
      required this.fastForwardTap,
      required this.isPlay,

      required this.mainButtonBackgroundColor,
      required this.secondaryButtonBackgroundColor});

  final Function() moreTap, playOrPauseTap, fastForwardTap;
  final bool isPlay;
  final Color
      mainButtonBackgroundColor,
      secondaryButtonBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          width: 60,
          height: 45,
          onTap: moreTap,

          backgroundColor: secondaryButtonBackgroundColor,
          icon: const Icon(Icons.more_horiz),
        ),
        const SizedBox(width: 10),
        CustomButton(
          onTap: playOrPauseTap,
          highlightColor: Colors.white,
          splashColor: Colors.white,
          backgroundColor: mainButtonBackgroundColor,
          width: 80,
          height: 50,
          icon:
              (isPlay) ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
        ),
        const SizedBox(width: 10),
        CustomButton(
          onTap: fastForwardTap,
          backgroundColor: secondaryButtonBackgroundColor,
          width: 60,
          height: 45,
          icon: const Icon(Icons.skip_next),
        )
      ],
    );
  }
}

/*class AnimatedIconExample extends StatefulWidget {
  const AnimatedIconExample({super.key});

  @override
  State<AnimatedIconExample> createState() => _AnimatedIconExampleState();
}

class _AnimatedIconExampleState extends State<AnimatedIconExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: animation,
        size: 25.0,
        semanticLabel: 'Show menu',
      ),
    );
  }
}*/
