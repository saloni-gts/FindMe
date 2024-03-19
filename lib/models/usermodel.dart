import 'package:find_me/api/staus_enum.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? loginType;
  @HiveField(2)
  String? socialToken;
  @HiveField(3)
  String? phoneCode;
  @HiveField(4)
  int? mobileNumber;
  @HiveField(5)
  String? email;
  @HiveField(6)
  String? password;
  @HiveField(7)
  String? name;
  @HiveField(8)
  int? isVerfied;
  @HiveField(9)
  String? socialId;
  @HiveField(10)
  int? countryId;
  @HiveField(11)
  String? language;
  @HiveField(12)
  String? city;
  @HiveField(13)
  String? shortCode;
  @HiveField(14)
  String? code;
  @HiveField(15)
  String? countryName;
  @HiveField(16)
  String? lastName;
  @HiveField(17)
  String? address;
  @HiveField(18)
  String? profileImage;
  @HiveField(19)
  String? gender;

  @HiveField(20)
  String? token;

  Status? status;
  String? message;

  @HiveField(21)
  String? country;

  @HiveField(22)
  int? isPremium;

  UserModel(
    
  );

  UserModel.fromJson(
      Map<String, dynamic> json, Status statuss, String messagess) {
    var _oldUser = HiveHandler.getUser();
    print("json >>>>> $json");
    var oldToken = _oldUser?.token ?? "";
    if (json.isNotEmpty) {
      var jsonval = json["user"];
      id = jsonval["id"] ?? 0;
      loginType = jsonval["loginType"];
      socialToken = jsonval["socialToken"];
      phoneCode = jsonval["phoneCode"];
      mobileNumber = jsonval["mobileNumber"];
      email = jsonval["email"];
      password = jsonval["password"];
      name = jsonval["name"];
      isVerfied = jsonval["isVerfied"];
      socialId = jsonval["socialId"];
      countryId = jsonval["countryId"];
      language = jsonval["language"];
      city = jsonval["city"];
      shortCode = jsonval["shortCode"];
      code = jsonval["code"];
      countryName = jsonval["countryName"];
      lastName = jsonval["lastName"];
      address = jsonval["address"];
      profileImage = jsonval["profileImage"];
      gender = jsonval["gender"];
      country = jsonval["country"];
      isPremium = jsonval["isPremium"];

      if (oldToken.isNotEmpty) {
        token = oldToken;
      } else {
        token = json['token'];
      }
    }

    status = statuss;
    message = messagess;
  }
}
