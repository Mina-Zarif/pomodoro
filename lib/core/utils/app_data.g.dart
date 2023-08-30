// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppDataAdapter extends TypeAdapter<AppData> {
  @override
  final int typeId = 0;

  @override
  AppData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppData(
      isDark: fields[0] as bool,
      times: (fields[1] as List).cast<String>(),
      shortBreaksTimes: fields[2] as int,
      notification: fields[4] as bool,
      sound: fields[3] as bool,
      autoResume: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isDark)
      ..writeByte(1)
      ..write(obj.times)
      ..writeByte(2)
      ..write(obj.shortBreaksTimes)
      ..writeByte(3)
      ..write(obj.sound)
      ..writeByte(4)
      ..write(obj.notification)
      ..writeByte(5)
      ..write(obj.autoResume);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
