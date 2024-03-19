import '../components/customdropdown.dart';

class MasterEvent{

  int? id;
  String? name;
  String? createdAt;
  String? categoryName;
  bool? buttonisSelected;
  List<EvntCatagoryList>evtCatagoryList=[];


  MasterEvent({

    this.id,
    this.name,
    this.createdAt,
    this.categoryName,
    this.buttonisSelected=false,
    required this.evtCatagoryList,

});



  MasterEvent.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    createdAt=json["createdAt"];
    categoryName=json["categoryName"];
    List _categoryListTemp=json["catagoryList"] ??[];
    evtCatagoryList=_categoryListTemp.map((e) => EvntCatagoryList.fromJson(e)).toList();
    print("Category added ${evtCatagoryList.length}");
  }

}


class EvntCatagoryList implements DropDownModel{
  int? id;
  String? name;
  int? EventCatgoriesId;
  int? type;
  // int? userId;
  String? createdAt;
  String? updateAt;


  EvntCatagoryList(
      {this.id,
        this.name,
        this.EventCatgoriesId,
        this.type,
        // this.userId,
        this.createdAt,
        this.updateAt
      });

  EvntCatagoryList.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    EventCatgoriesId=json["EventCatgoriesId"];
    type=json["type"];
    createdAt=json["createdAt"];
    updateAt=json["updateAt"];
  }

  @override
  String? getOptionName() {

    return name;
  }

}
