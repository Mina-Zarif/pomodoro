import 'package:flutter/material.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter(
      {super.key,
      required this.counter,
      required this.onTapAdd,
      required this.onTapRemove,
      this.iconsColor,
      this.backgroundColor});

  final int counter;
  final Function() onTapAdd, onTapRemove;
  final Color? iconsColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTapAdd,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: backgroundColor ?? const Color(0xff661919),
            child: Icon(
              Icons.add,
              size: 17,
              color: iconsColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffEAEAEA),
            ),
          ),
          child: Center(
            child: Text(counter.toString()),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTapRemove,
          child: CircleAvatar(
            backgroundColor: backgroundColor ?? const Color(0xff661919),
            radius: 12,
            child: Icon(
              Icons.remove,
              size: 17,
              color: iconsColor,
            ),
          ),
        )
      ],
    );
  }
}
