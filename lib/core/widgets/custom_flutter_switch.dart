import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pomodoro/constants.dart';

class CustomFlutterSwitch extends StatelessWidget {
  const CustomFlutterSwitch(
      {super.key,
      required this.onToggle,
      required this.switchValue,
      this.inactiveColor = const Color(0xffEAEAEA),
      this.activeColor = defaultColor});

  final bool switchValue;
  final Function(bool value) onToggle;
  final Color inactiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 55,
      height: 30,
      value: switchValue,
      onToggle: onToggle,
      inactiveColor: inactiveColor,
      activeColor: activeColor,
      // toggleColor: Colors.grey.shade200
    );
  }
}
