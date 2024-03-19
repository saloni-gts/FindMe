class HealthyWeightDetail{
  int? userId;
  int? id;
  String? createdDate;
  String? updatedDate;
  int? formType;
  String? petName;
  String? petType;
  String? microchip;
  String? petPhoto;
  int? isDeleted;
  String? birthDate;
  int? breedId;
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
  int? profilePercantage;
  int? healthWeight;
  int? isPetQrCount;
  double? latitude;
  double? longitude;



  HealthyWeightDetail({
    this.id,
    this.userId,
    this.size,
    this.petPhoto,
    this.microchip,
    this.petName,
    this.city,
    this.contact,
    this.sterilization,
    this.birthDate,
    this.isDeleted,
    this.qrTagNumber,
    this.isPetQrCount,
    this.qrActivationCode,
    this.qrCodeId,
    this.isQrAttached,
    this.latitude,
    this.longitude,
    this.color,
    this.createdDate,
    this.breedId,
    this.formType,
    this.gender,
    this.healthWeight,
    this.isLost,
    this.petType,
    this.profilePercantage,
    this.shortDescription,
    this.updatedDate


  });


  HealthyWeightDetail.fromjson(Map<String, dynamic> json){

    userId = json['userId'];
    id = json['id'];
    createdDate = json['createdDate'].toString();
    updatedDate = json['updatedDate'].toString();
    formType = json['formType'];
    petName = json['petName'];
    petType = json['petType'];
    microchip = json['microchip'];
    petPhoto = json['petPhoto'];
    isDeleted = json['isDeleted'];
    birthDate = json['birthDate'];
    breedId = json['breedId'];
    sterilization = json['sterilization'];
    color = json['color'];
    size = json['size'];
    shortDescription = json['shortDescription'];
    contact = json['contact'];
    city = json['city'];
    gender = json['gender'];
    qrCodeId = json['qrCodeId'];
    qrActivationCode = json['qrActivationCode'];
    qrTagNumber = json['qrTagNumber'];
    isLost = json['isLost'];
    isQrAttached = json['isQrAttached'];
    profilePercantage = json['profilePercantage'];
    healthWeight = json['healthWeight'];
    isPetQrCount = json['isPetQrCount'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }




}