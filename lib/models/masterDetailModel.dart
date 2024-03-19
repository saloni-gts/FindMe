



import 'package:find_me/components/customdropdown.dart';

class MasterDetails {
  int? id;
  String? name;
  String? createdAt;
  bool? buttonisSelected;
  List<CatagoryList>catagoryList=[];

  MasterDetails({
    this.id,
    this.name,
    this.createdAt,
    this.buttonisSelected=false,
    required this.catagoryList,
});

  MasterDetails.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
  createdAt=json["createdAt"];
  List _categoryListTemp=json["catagoryList"] ??[];
    catagoryList=_categoryListTemp.map((e) => CatagoryList.fromJson(e)).toList();
print("Category added ${catagoryList.length}");
  }

}

class CatagoryList implements DropDownModel{
  int? id;
  String? name;
  int? categoriesId;
  int? type;
  String? createdAt;
  String? updateAt;


  CatagoryList(
      {this.id,
        this.name,
        this.categoriesId,
        this.type,
        this.createdAt,
        this.updateAt});

  CatagoryList.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    categoriesId=json["categoriesId"];
    type=json["type"];
    createdAt=json["createdAt"];
    updateAt=json["updateAt"];
  }

  @override
  String? getOptionName() {

    return name;
  }

}