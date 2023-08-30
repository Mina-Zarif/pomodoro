import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatelessWidget {
  const CustomTimePicker({
    super.key,
    required this.textEditingController,
    required this.onChange,
    required this.onTapOK,
    this.initDuration,
    required this.onTapCancel,
  });

  final TextEditingController textEditingController;
  final Function(Duration changedTimer) onChange;
  final Function() onTapOK, onTapCancel;
  final Duration? initDuration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: TextField(
        controller: textEditingController,
        showCursor: false,
        keyboardType: TextInputType.none,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(11),
            ),
            borderSide: BorderSide(
              color: Color(0xffEAEAEA),
            ),
          ),
        ),
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext builder) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 32, bottom: 32, start: 50, end: 50),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      children: [
                        CupertinoTimerPicker(
                          alignment: AlignmentDirectional.topCenter,
                          mode: CupertinoTimerPickerMode.ms,
                          minuteInterval: 1,
                          secondInterval: 1,
                          initialTimerDuration:
                              initDuration ?? const Duration(minutes: 25),
                          onTimerDurationChanged: (Duration changedTimer) {
                            onChange(changedTimer);
                          },
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                onTapCancel();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => onTapOK(),
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
