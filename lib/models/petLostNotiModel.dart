import 'package:hive/hive.dart';
part 'petLostNotiModel.g.dart';

@HiveType(typeId: 5)
class petLostHiveModel{
  @HiveField(0)
  bool isNotiOn=false;
  petLostHiveModel(this.isNotiOn);

}