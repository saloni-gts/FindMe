class VerifiedListApiModel {
  List<Verified> verifiedList = [];
  List<Verified> notVerified = [];
  List<Verified> pendingUser = [];
  List<Verified> approvedUser = [];

  VerifiedListApiModel.fromJson(Map<String, dynamic> json) {
    if (json['Verfied'] != null) {
      verifiedList = List<Verified>.from(
          json['Verfied'].map((x) => Verified.fromJson(x, 2)));
    }
    
    if (json['NotVerfied'] != null) {
      notVerified = List<Verified>.from(
          json['NotVerfied'].map((x) => Verified.fromJson(x, 1)));
    }

    if (json['PendingUser'] != null) {
      pendingUser = List<Verified>.from(
          json['PendingUser'].map((x) => Verified.fromJson(x, 3)));
    }

    if (json['ApprovedUser'] != null) {
      approvedUser = List<Verified>.from(
          json['ApprovedUser'].map((x) => Verified.fromJson(x, 4)));
    }
  }
}

class Verified {
  int? typeValues;
  int? id;
  int? loginType;
  String? socialToken;
  String? phoneCode;
  int? mobileNumber;
  String? email;
  String? password;
  int? isDeleted;
  String? createdAt;
  String? updateAt;
  String? name;
  int? isVerfied;
  String? socialId;
  int? countryId;
  String? language;
  String? city;
  String? otp;
  int? isPremium;
  String? profileImage;
  String? lastName;
  String? gender;
  int? smsNotfication;
  String? emergencyContact;
  String? messengerContact;
  String? country;
  String? address;
  int? zipCode;
  int? isPrivacy;
  int? userSenderId;
  int? userReciverId;
  int? isVeriefy;
  String? isNotJoint;

  Verified.fromJson(Map<String, dynamic> json, int val) {
    typeValues = val;
    id = json['id'];
    loginType = json['loginType'];
    socialToken = json['socialToken'];
    phoneCode = json['phoneCode'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    password = json['password'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    name = json['name'];
    isVerfied = json['isVerfied'];
    socialId = json['socialId'];
    countryId = json['countryId'];
    language = json['language'];
    city = json['city'];
    otp = json['otp'];
    isPremium = json['isPremium'];
    profileImage = json['profileImage'];
    lastName = json['lastName'];
    gender = json['gender'];
    smsNotfication = json['smsNotfication'];
    emergencyContact = json['emergencyContact'];
    messengerContact = json['messengerContact'];
    country = json['country'];
    address = json['address'];
    zipCode = json['zipCode'];
    isPrivacy = json['isPrivacy'];
    userSenderId = json['userSenderId'];
    userReciverId = json['userReciverId'];
    isVeriefy = json['isVeriefy'];
    isNotJoint=json['isNotJoint'] ??"0";
  }
}
