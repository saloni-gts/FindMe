class PetDetails {
  bool? isJoinPet;
  int? userId;
  int? id;
  String? createdDate;
  String? updatedDate;
  int? formType;
  String? petName;
  String? petType;
  String? microchip;
  String? petPhoto;
  String? birthDate;
  String? breedName;
  String? sterilization;
  String? color;
  String? size;
  String? shortDescription;
  String? contact;
  String? city;
  String? gender;
  int? qrCodeId;
  String? qrActivationCode;
  String? qrTagNumber;
  int? isLost;
  int? isQrAttached;
  int? isPetQrCount;
  double? profilePercantage;
  String? ownerName;
  int? isPremium;
  PetDetails({this.id});
  PetDetails.fromjs(Map<String, dynamic> json,bool val) {
    isJoinPet=val;
    userId = json["userId"];
    id = json["id"];
    createdDate = json["createdDate"];
    updatedDate = json["updatedDate"];
    formType = json["formType"];
    petName = json["petName"];
    petType = json["petType"];
    microchip = json["microchip"];
    petPhoto = json["petPhoto"];
    birthDate = json["birthDate"];
    breedName = json["breedName"];
    sterilization = json["sterilization"];
    color = json["color"];
    size = json["size"];
    shortDescription = json["shortDescription"];
    contact = json["contact"];
    city = json["city"];
    gender = json["gender"];
    qrCodeId = json["qrCodeId"];
    qrActivationCode = json["qrActivationCode"];
    qrTagNumber = json["qrTagNumber"];
    isLost = json["isLost"];
    isQrAttached = json["isQrAttached"];
    isPetQrCount = json["isPetQrCount"];
    isPremium = json["isPremium"];
    ownerName=json['name']??"";
    profilePercantage = double.parse(json["profilePercantage"].toString());
  }
}
