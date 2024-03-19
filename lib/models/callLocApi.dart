import 'package:hive/hive.dart';
part 'callLocApi.g.dart';


@HiveType(typeId: 4)
class LocApiHiveModel{
  @HiveField(0)
  bool isCallLocApi=false;
  LocApiHiveModel(this.isCallLocApi);
}