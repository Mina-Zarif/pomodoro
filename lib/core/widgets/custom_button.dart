import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.width,
      required this.height,
      required this.icon,
      this.highlightColor = Colors.transparent,
      this.splashColor = Colors.transparent});

  final Function() onTap;
  final Color backgroundColor, highlightColor, splashColor;
  final double width, height;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        onDoubleTap: () {},
        borderRadius: BorderRadius.circular(16),
        highlightColor: highlightColor,
        splashColor: splashColor,
        child: icon,
      ),
    );
  }
}
