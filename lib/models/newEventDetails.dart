class EventModel{
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
  String? profilePercantage;
  String? healthWeight;
  int? isPetQrCount;
  String? latitude;
  String? longitude;
  String? categoryName;
  String? name;
  int? EventCatgoriesId;
  int? type;
  String? createdAt;
  String? updateAt;
  String? eventDate;
  String? endEventDate;
  DateTime? startDate;
  int? petId;
  int? eventCategoryId;
  String? eventType;
  String? eventName;
  int? isSend;
  int? eventCategoryTypeId;
  int? isRepeat;
  // DateTime? eventEndDate;
  String? eventEndDate;
  String? recring;
  int? EventRemendirBefore;
  DateTime? ending;




  EventModel({
    this.userId,
    this.id,
    this.createdDate,
    this.updatedDate,
    this.formType,
    this.petName,
    this.petType,
    this.microchip,
    this.petPhoto,
    this.isDeleted,
    this.birthDate,
    this.breedId,
    this.sterilization,
    this.color,
    this.size,
    this.shortDescription,
    this.contact,
    this.city,
    this.gender,
    this.qrCodeId,
    this.qrActivationCode,
    this.qrTagNumber,
    this.isLost,
    this.isQrAttached,
    this.profilePercantage,
    this.healthWeight,
    this.isPetQrCount,
    this.latitude,
    this.longitude,
    this.categoryName,
    this.name,
    this.EventCatgoriesId,
    this.type,
    this.createdAt,
    this.updateAt,
    this.eventDate,
    this.endEventDate,
    this.petId,
    this.eventCategoryId,
    this.eventType,
    this.eventName,
    this.isSend,
    this.eventCategoryTypeId,
    this.isRepeat,
    this.eventEndDate,
    this.EventRemendirBefore,
    this.recring,
    this.startDate,
    this.ending,

});



  EventModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
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
    profilePercantage = json['profilePercantage'].toString();
    healthWeight = json['healthWeight'].toString();
    isPetQrCount = json['isPetQrCount'];
    latitude = json['Latitude'].toString();
    longitude = json['Longitude'].toString();
    categoryName = json['categoryName'];
    name = json['name'];
    EventCatgoriesId = json['EventCatgoriesId'];
    type = json['type'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    eventDate = json['eventDate'].toString();
    endEventDate = json['eventEndDate'].toString();
    petId = json['petId'];
    eventCategoryId = json['eventCategoryId'];
    eventType = json['eventType'];
    eventName = json['eventName'];
    isSend = json['isSend'];
    eventCategoryTypeId = json['eventCategoryTypeId'];
    isRepeat = json['isRepeat'];
    eventEndDate = json['eventEndDate'];
    // eventEndDate = DateTime.fromMillisecondsSinceEpoch(int.parse(json["eventEndDate"].toString()));
    recring=json["eventEndDate"].toString();
    EventRemendirBefore = json['EventRemendirBefore'];
    startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(json["eventDate"].toString()));
    // ending =    DateTime.fromMillisecondsSinceEpoch(int.parse(json["eventEndDate"]));


  }



}