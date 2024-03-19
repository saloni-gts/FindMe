import 'package:hive/hive.dart';
part 'LocationModel.g.dart';

@HiveType(typeId: 3)
class LocationHiveModel{
@HiveField(0)
bool isLocSelected=false;
LocationHiveModel(this.isLocSelected);
}