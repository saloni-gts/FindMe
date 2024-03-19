import 'package:hive/hive.dart';
part 'languagemodel.g.dart';
@HiveType(typeId: 2)

class LanguageHiveModel{
  @HiveField(0)
  bool isLanguageSelected=false;

  // @HiveField(1)
  // bool isLocSelected=false;


  LanguageHiveModel(this.isLanguageSelected,);
}