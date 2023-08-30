import 'package:hive/hive.dart';

part 'app_data.g.dart';

@HiveType(typeId: 0)
class AppData extends HiveObject {
  AppData(
      {required this.isDark,
      required this.times,
      required this.shortBreaksTimes,
      required this.notification,
      required this.sound,
      required this.autoResume});

  @HiveField(0)
  bool isDark;

  @HiveField(1)
  List<String> times;

  @HiveField(2)
  int shortBreaksTimes;

  @HiveField(3)
  bool sound;

  @HiveField(4)
  bool notification;

  @HiveField(5)
  bool autoResume;
}
