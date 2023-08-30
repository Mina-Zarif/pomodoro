import 'package:flutter/material.dart';

class CustomTimer extends StatelessWidget {
  const CustomTimer({
    super.key,
    required this.duration,
    this.isPlay = false,
    this.timerColor = Colors.white,
  });

  final Duration duration;
  final bool isPlay;
  final Color timerColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          (duration.inMinutes < 10)
              ? "0${duration.inMinutes}"
              : duration.inMinutes.toString(),
          style: TextStyle(
            fontSize: 100,
            fontWeight: isPlay ? FontWeight.w700 : FontWeight.w300,
            wordSpacing: 0,
            height: 0,
            color: timerColor,
          ),
        ),
        Text(
          ((duration.inSeconds - duration.inMinutes * 60) < 10)
              ? "0${(duration.inSeconds - duration.inMinutes * 60).toString()}"
              : (duration.inSeconds - duration.inMinutes * 60).toString(),
          style: TextStyle(
            fontSize: 100,
            fontWeight: isPlay ? FontWeight.w700 : FontWeight.w300,
            height: 0,
            color: timerColor,
          ),
        )
      ],
    );
  }
}
