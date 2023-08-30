// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPomoMode extends StatelessWidget {
  const CustomPomoMode({
    super.key,
    required this.title,
    required this.iconPath,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.transparent,
  });

  final String title, iconPath;
  final Color textColor, iconColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: iconColor),
      ),
      padding: const EdgeInsetsDirectional.only(
          start: 10, bottom: 8, top: 8, end: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            color: iconColor,
          ),
          const SizedBox(width: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
