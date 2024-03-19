import 'package:find_me/models/callLocApi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import '../models/LocationModel.dart';
import '../models/languagemodel.dart';
import '../models/petLostNotiModel.dart';
import '../models/usermodel.dart';

class HiveHandler {
  static const String userDataBox = "userData";
  static const String userDataBoxKey = "userDataKey";

  static const String selectedLanguage = "userData";
  static const String selectedLocation = "userData";
  static const String languageBox = "languageBox";
  static const String locationBox = "locationBox";

  static const String locApiBox = "locApiBox";
  static const String selectedLocApi = "locApiKey";


  static const String petLostNotiBox = "petLostNotiBox";
  static const String petLostNoti = "petLostNotiKey";


  static const String deviceTokenBox = "DeviceTokenBox";
  static const String deviceTokenKey = "deviceTokenKey";

  static Future hiveRegisterAdapter() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(LanguageHiveModelAdapter());
    Hive.registerAdapter(LocationHiveModelAdapter());
    Hive.registerAdapter(LocApiHiveModelAdapter());
    Hive.registerAdapter(petLostHiveModelAdapter());

    await Hive.openBox<UserModel>(userDataBox);
    await Hive.openBox<LanguageHiveModel>(languageBox);
    await Hive.openBox<LocationHiveModel>(locationBox);
    await Hive.openBox<LocApiHiveModel>(locApiBox);
    await Hive.openBox<petLostHiveModel>(petLostNotiBox);
    await Hive.openBox("deviceTokenBox");
  }

  static addUser(UserModel user) {
    print("************* LOCAL USER UPDATED ***********");
    var _userBox = Hive.box<UserModel>(userDataBox);
    _userBox.put(userDataBoxKey, user);
    print(">>>>>> name username  ${_userBox.get(userDataBoxKey)?.gender}");
  }

  static UserModel? getUser() {
    var _userBox = Hive.box<UserModel>(userDataBox);
    return _userBox.get(userDataBoxKey);
  }

  static ValueListenable<Box<UserModel>> getUserHiveRefresher() {
    return Hive.box<UserModel>(userDataBox).listenable();
  }

  static setDeviceToken(String val) async {
    var _userBox = Hive.box(deviceTokenBox);
    await _userBox.put(deviceTokenKey, val);
  }

  static Future<String> getDeviceToken() async {
    var _userBox = Hive.box(deviceTokenBox);
    return _userBox.get(deviceTokenKey).toString();
  }

  static updateUserName(String nameUpdatehere) {
    var _userBox = Hive.box<UserModel>(userDataBox);

    var userDatatemp = _userBox.get(userDataBoxKey);

    userDatatemp?.name = nameUpdatehere;
    if (userDatatemp != null) {
      _userBox.put(userDataBoxKey, userDatatemp);
      print("-----NAME ------ UPDATED${userDatatemp.name}");
    }
  }

  static updatePhNumber(String phNoUpdate) {

    var _userBox = Hive.box<UserModel>(userDataBox);
    var userDatatemp = _userBox.get(userDataBoxKey);
    userDatatemp?.mobileNumber = int.parse(phNoUpdate);
    if (userDatatemp != null) {
      _userBox.put(userDataBoxKey, userDatatemp);
      print("-----Phone Number ------ UPDATED${userDatatemp.mobileNumber}");
    }
  }

  static updatePhoneCode(String phNoCode) {
    var _userBox = Hive.box<UserModel>(userDataBox);
    var userDatatemp = _userBox.get(userDataBoxKey);

    userDatatemp?.phoneCode = phNoCode;
    if (userDatatemp != null) {
      _userBox.put(userDataBoxKey, userDatatemp);
      print("-----Phone Number ------ codeeeee=${userDatatemp.phoneCode}");
    }
  }

  static updateCountryCode(String cntryCodeee) {
    var _userBox = Hive.box<UserModel>(userDataBox);
    var userDatatemp = _userBox.get(userDataBoxKey);

    userDatatemp?.shortCode = cntryCodeee;
    if (userDatatemp != null) {
      _userBox.put(userDataBoxKey, userDatatemp);
      print("-----COUNTRY CODE ------ codeeeee=${userDatatemp.shortCode}");
    }
  }

  static void clearUser() {
    var _userBox = Hive.box<UserModel>(userDataBox);
    _userBox.clear();
  }

  // static ValueListenable<Box<UserModel>> getUserListen() {
  //   return Hive.box<UserModel>(userDataBox).listenable();
  // }

  static updateIsLanguageSelected(bool isSelected) {
    var _userBox = Hive.box<LanguageHiveModel>(languageBox);
    _userBox.put(selectedLanguage, LanguageHiveModel(isSelected));
  }



  static bool isLanguageSelected() {
    var _userBox = Hive.box<LanguageHiveModel>(languageBox);
    return _userBox.get(selectedLanguage)?.isLanguageSelected ?? false;
  }

  static updateLocPopup(bool isLocSelected) {
    var _userBox = Hive.box<LocationHiveModel>(locationBox);
    _userBox.put(selectedLocation, LocationHiveModel(isLocSelected));
  }

  static bool isLocSeclected() {
    var _userBox = Hive.box<LocationHiveModel>(locationBox);
    return _userBox.get(selectedLocation)?.isLocSelected ?? false;
  }


  static updateLocApiCall(bool isCallLocApi) {
    var _userBox = Hive.box<LocApiHiveModel>(locApiBox);
    _userBox.put(selectedLocApi, LocApiHiveModel(isCallLocApi));
  }

  static bool isLocApiCall() {
    var _userBox = Hive.box<LocApiHiveModel>(locApiBox);
    return _userBox.get(selectedLocApi)?.isCallLocApi??false;
  }




  static updateNotiButton(bool isbuttonOn) {
    var _userBox = Hive.box<petLostHiveModel>(petLostNotiBox);
    _userBox.put(petLostNoti, petLostHiveModel(isbuttonOn));
  }

  static bool isChekLostNoti() {
    var _userBox = Hive.box<petLostHiveModel>(petLostNotiBox);
    return _userBox.get(petLostNoti)?.isNotiOn??false;
  }





}
