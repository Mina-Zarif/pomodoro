import 'package:flutter/material.dart';

class CustomSettingItem extends StatelessWidget {
  const CustomSettingItem({
    super.key,
    required this.title,
    required this.actionWidget,
  });

  final String title;
  final Widget actionWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          actionWidget,
        ],
      ),
    );
  }
}
