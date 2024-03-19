class TagDetails{
  int? id;
  int? petId;
  int? qrCodeId;
  String? qrActivationCode;
  String? qrTagNumber;
  int? userId;
  int? isDeleted;
  String? createdAt;
  String? updateAt;
  String? updateDate;


  TagDetails({
    this.id,
    this.petId,
    this.qrCodeId,
    this.userId,
    this.isDeleted,
    this.qrActivationCode,
    this.qrTagNumber,
    this.createdAt,
    this.updateAt,
    this.updateDate,
});


  TagDetails.fromjson(Map<String, dynamic> json){
    petId = json["petId"];
    id = json["id"];
    qrCodeId = json["qrCodeId"];
    userId = json["userId"];
    isDeleted = json["isDeleted"];
    qrActivationCode = json["qrActivationCode"];
    qrTagNumber = json["qrTagNumber"];
    createdAt = json["createdAt"];
    updateAt = json["updateAt"];
    updateDate = json["updateDate"].toString();
  }




}