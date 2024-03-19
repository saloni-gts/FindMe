
import 'package:flutter/cupertino.dart';

class Button{
  String? name;
  bool isSelected=false;
  Button({required this.name,  this.isSelected= false});

  Button.fromjson(Map<String,dynamic>json){
    name=json["name"];
    isSelected=json["isSelected"];
  }

}

class newButton{
  String name;
  int id;
  String amount;
  bool buttonisSelected;
  newButton({required this.name,  this.buttonisSelected= false, this.id=0, this.amount="£25.5"});

}

class premiumPlans{
  String name;
  int id;
  int showTick;
  bool isSelected=false;
  premiumPlans({required this.name, this.id=0, required this.isSelected,required this.showTick});

}





//more feature class model

class Choice {
  Choice({required this.title, required this.image,required this.type});
  final String title;
  final AssetImage image;
  int type;
  final Color color = Color(0xff2A3C6A);

}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}


class PetWeightData{
  String petWeight;
  String weightDate;
  PetWeightData({required this.petWeight,required this.weightDate});

}




class LogoutModel{
  final String title;
  final AssetImage image;
  final type;
  final Color color = Color(0xff2A3C6A);
  LogoutModel({required this.title, required this.image,required this.type,});
}
class goPremium{
  String name;
  int id;
  int showTick1;
  int showTick2;

  goPremium({required this.id,required this.name,required this.showTick1,required this.showTick2});
}

