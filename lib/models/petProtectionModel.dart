import 'package:find_me/components/globalnavigatorkey.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProtectionModel {
  Users? users;
  List<petMessengerContact> petMessenger = [];
  List<PetExtraContacts> petExtraContacts = [];
  List<PetIdentifiers> petIdentifiers = [];

  ProtectionModel({
    this.users,
    required this.petMessenger,
    required this.petExtraContacts,
    required this.petIdentifiers,
  });

  ProtectionModel.fromJson(Map<String, dynamic> json) {
    print("PetMessenger${json["PetMessenger"]}");
    users = Users.fromJson(json["users"]);

    List _petExtraContactsTemp2 = json["PetMessenger"] ?? [];
// List temp = fromJson["teacherData"] ?? [];

    petMessenger = _petExtraContactsTemp2
        .map((element) => petMessengerContact.fromJson(
              element,
            ))
        .toList();

    print("petMessenger.length${petMessenger.length}");

    List _petExtraContactsTemp = json["PetExtraContacts"] ?? [];
    petExtraContacts =
        _petExtraContactsTemp.map((e) => PetExtraContacts.fromJson(e)).toList();

    List _petIdentifiersTemp = json["PetIdentifiers"] ?? [];
    petIdentifiers =
        _petIdentifiersTemp.map((e) => PetIdentifiers.fromJson(e)).toList();
  }
}

class Users {
  String? petName;
  String? microchip;
  String? petPhoto;
  String? phoneCode;
  int? mobileNumber;
  int? loginType;
  String? email;

  Users(
      {this.petName,
      this.microchip,
      this.petPhoto,
      this.phoneCode,
      this.mobileNumber,
      this.loginType,
      this.email});

  Users.fromJson(Map<String, dynamic> json) {
    petName = json["petName"];
    microchip = json["microchip"];
    petPhoto = json["petPhoto"];
    phoneCode = json["phoneCode"];
    mobileNumber = json["mobileNumber"];
    loginType = json["loginType"];
    email = json["email"];
  }
}

class PetExtraContacts {
  int? id;
  int? petId;
  int? userId;
  String? countryCode;
  int? mobileNumber;
  int? isDeleted;
  String? createdAt;
  String? updateAt;
  String? flag;

  PetExtraContacts(
      {this.id,
      this.petId,
      this.userId,
      this.countryCode,
      this.mobileNumber,
      this.isDeleted,
      this.createdAt,
      this.updateAt});

  PetExtraContacts.fromJson(Map<String, dynamic> json) {
    PetProvider petProvider=Provider.of(GlobalVariable.navState.currentContext!,listen: false);
    id = json["id"];
    petId = json["petId"];
    userId = json["userId"];
    countryCode = json["countryCode"];
    print("country code api model====${countryCode!}");
    mobileNumber = json["mobileNumber"];
    isDeleted = json["isDeleted"];
    createdAt = json["createdAt"];
    updateAt = json["updateAt"];
    flag=petProvider.getContryFlag(countryCode!);
    print("flag api model====${flag}");
  }
}

class PetIdentifiers {
  int? id;
  int? petId;
  String? userId;
  String? name;
  int? type;
  int? isDeleted;
  String? createdAt;
  String? updateAt;

  PetIdentifiers(
      {this.id,
      this.petId,
      this.userId,
      this.name,
      this.type,
      this.isDeleted,
      this.createdAt,
      this.updateAt});

  PetIdentifiers.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    petId = json["petId"];
    userId = json["userId"];
    name = json["name"];
    type = json["type"];
    isDeleted = json["isDeleted"];
    createdAt = json["createdAt"];
    updateAt = json["updateAt"];
  }
}

class petMessengerContact {
  int? id;
  int? petId;
  int? userId;
  String? name;
  int? type;
  int? isDeleted;
  String? createdAt;
  String? updateAt;

  petMessengerContact(
      {this.id,
      this.petId,
      this.userId,
      this.name,
      this.type,
      this.isDeleted,
      this.createdAt,
      this.updateAt});

  petMessengerContact.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    petId = json["petId"];
    userId = json["userId"];
    name = json["name"];
    type = json["type"];
    isDeleted = json["isDeleted"];
    createdAt = json["createdAt"];
    updateAt = json["updateAt"];
  }
}

class TeacherData {
  List<petMessengerContact> teacherDataList = [];

  TeacherData.fromJson(Map<String, dynamic> json) {
    List temp = json["PetMessenger"] ?? [] as List;
    teacherDataList =
        temp.map((element) => petMessengerContact.fromJson(element)).toList();
  }
}
