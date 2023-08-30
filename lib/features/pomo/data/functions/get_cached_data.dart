import 'package:hive_flutter/hive_flutter.dart';

List<dynamic> getCacheData<Type>(String boxName) {
  var boxData = Hive.box<Type>(boxName);
  return boxData.values.toList();
}
