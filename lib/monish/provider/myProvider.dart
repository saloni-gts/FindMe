import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/api/call_api.dart';
import 'package:find_me/api/staus_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../../generated/locale_keys.g.dart';
import '../../util/app_images.dart';
import '../models/newModel.dart';

class Myprovider with ChangeNotifier {
  late bool _isOnline;

  bool get isOnline => _isOnline;

  late var notiSwitchcontroller = ValueNotifier<bool>(true);
  bool radioVal = true;

  onRadioChange() {
    radioVal = !radioVal;


    // if(radioVal==true){
    //   callsendNotificationApi(iddd: 1,status:0);
    // }

    notifyListeners();
  }


  bool setButtonOn=false;

  chngSetButton(){
    setButtonOn=!setButtonOn;
    print("setButtonOnsetButtonOn${setButtonOn}");
    notifyListeners();
  }


  // bool lostPetRadVal=true;
  // onLostPetRadChange() {
  //   lostPetRadVal = !lostPetRadVal;
  //
  //
  //   if(lostPetRadVal==true){
  //
  //   }
  //
  //   notifyListeners();
  // }

  bool loader = false;
  updateLoader(bool status) async {
    loaderUpdate(status);

    return loader;
  }

  loaderUpdate(bool status) {
    if (status) {
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.clear);
    } else {
      print("dismiss loader");
      EasyLoading.dismiss();
    }
  }




  AppApi api = AppApi();

  callsendNotificationApi({
    required int iddd,
    required int status
  }) async {

    print("int idd==>> ${iddd}");
    await api.sendNotificationApi({"isSend": iddd,"status":status}).then((value) async {
      if (value?.status == Status.success) {
        updateLoader(false);
      } else {
        updateLoader(false);
      }
      notifyListeners();
    }).onError((error, stackTrace){
      updateLoader(false);
    });
  }

  List<PetWeightData> weightOfPet = [];
  late String myPetWeight;
  late String myPetWeightDate;
  late String weightRemark;
  String seletedItem = "";
  int tapIndex = 0;
  int preIndex = 0;

  updateTapIndex(int val) {
    tapIndex = val;
    Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    }).onError((error, stackTrace) {
      print("eroorroror===>>> ${error}");
    });
  }

  updateItem(String val) {
    seletedItem = val;
    print("seletedItem seletedItem ${seletedItem}");
    Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  int? showGraph;

  displayGraph(int val) {
    showGraph = val;
    notifyListeners();
  }

  // displayList(){
  //   showGraph=0;
  // }

  ConnectivityProvider() {
    Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
  }

  File? imageFile;

  updateSelectedData(int index) {
    Future.delayed(Duration.zero, () {
      for (var item in buttonname) {
        item.isSelected = false;
      }
      buttonname[index].isSelected = true;
      notifyListeners();
    });
  }

  List<newButton> reactionbutton = [
    newButton(name: tr(LocaleKeys.additionText_positive)),
    newButton(name: tr(LocaleKeys.additionText_negative)),

    newButton(name:tr(LocaleKeys.additionText_unknown)),
  ];

  upodateSelectedbutton2(int index) {
    print("index= ${index + 1}");
    for (var item in reactionbutton) {
      item.buttonisSelected = false;
    }
    reactionbutton[index].buttonisSelected = true;

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

// //chat app name
//   List<ChatMessage> messages = [
//     ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
//     ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
//     ChatMessage(
//         messageContent: "Hey Kriss, I am doing fine dude. wbu?",
//         messageType: "sender"),
//     ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
//     ChatMessage(
//         messageContent: "Is there any thing wrong?", messageType: "sender"),
//   ];

  // List<PetWeightData> weightOfPet=[
  //
  //   PetWeightData(petWeight: ,weightDate: )
  // ];

  //more feature list



 List choices1 = [
  Choice(
  title: tr(LocaleKeys.additionText_premiumSubscription),
  image: AssetImage(AppImage.premiumIcon),
  type: 13),

  Choice(
  title:tr(LocaleKeys.additionText_AddFamMember),
  image: AssetImage(AppImage.familyplanIcon),
  type: 1),


  Choice(
  title: tr(LocaleKeys.additionText_AddJointOnr),
  image: AssetImage(AppImage.addjoint),
  type: 4),


  Choice(
  title: tr(LocaleKeys.additionText_PndingReq),
  image: AssetImage(AppImage.pendinReq),
  type: 20),

  Choice(
  title: tr(LocaleKeys.moreFeatures_aboutUs),
  image: AssetImage(AppImage.aboutus),
  type: 2),
  Choice(
  title:tr(LocaleKeys.additionText_howitWrks),
  image: AssetImage(AppImage.howItWoks),
  type: 9),
  Choice(
  title: tr(LocaleKeys.moreFeatures_faq),
  image: AssetImage(AppImage.faqicon),
  type: 3),

  Choice(
  title: tr(LocaleKeys.moreFeatures_customerCare),
  image: AssetImage(AppImage.customer),
  type: 5),
  Choice(
  title: tr(LocaleKeys.additionText_RateUss),
  image: AssetImage(AppImage.rateus),
  type: 6),
  Choice(
  title: tr(LocaleKeys.additionText_ShareDApp),
  image: AssetImage(AppImage.shareicon1),
  type: 7,
  ),
  Choice(
  title: tr(LocaleKeys.moreFeatures_settings),
  image: AssetImage(AppImage.setting1),
  type: 8),
  ];



  List choices2 = [
    Choice(
        title: tr(LocaleKeys.additionText_premiumSubscription),
        image: AssetImage(AppImage.premiumIcon),
        type: 13),

    Choice(
        title: tr(LocaleKeys.additionText_PndingReq),
        image: AssetImage(AppImage.pendinReq),
        type: 20),

    Choice(
        title: tr(LocaleKeys.moreFeatures_aboutUs),
        image: AssetImage(AppImage.aboutus),
        type: 2),
    Choice(
        title: tr(LocaleKeys.additionText_howitWrks),
        image: AssetImage(AppImage.howItWoks),
        type: 9),
    Choice(
        title: tr(LocaleKeys.moreFeatures_faq),
        image: AssetImage(AppImage.faqicon),
        type: 3),

    Choice(
        title: tr(LocaleKeys.moreFeatures_customerCare),
        image: AssetImage(AppImage.customer),
        type: 5),
    Choice(
        title: tr(LocaleKeys.additionText_RateUss),
        image: AssetImage(AppImage.rateus),
        type: 6),
    Choice(
      title: tr(LocaleKeys.additionText_ShareDApp),
      image: AssetImage(AppImage.shareicon1),
      type: 7,
    ),
    Choice(
        title: tr(LocaleKeys.moreFeatures_settings),
        image: AssetImage(AppImage.setting1),
        type: 8),
  ];










  List<Button> buttonname = [
    Button(name: 'Vaccination'),
    Button(name: "Hygiene"),
    Button(name: "Treatment"),
    Button(name: "Nutrition"),
    Button(name: "Other"),
  ];

  List<LogoutModel> SettingPage = [
    LogoutModel(
      title: tr(LocaleKeys.additionText_chanePassword),
      image: AssetImage(AppImage.change_icon),
      type: 0,
    ),
    // LogoutModel(
    //     title: 'Language',
    //     image: AssetImage(AppImage.language),
    //     type: 1),
    // LogoutModel(
    //     title: 'Measurement Units',
    //     image: AssetImage(AppImage.measurement),
    //     type: 2),
    LogoutModel(
        title: "Delete Owner Profile",
        // tr(LocaleKeys.additionText_delOnrPro),
        image: AssetImage(AppImage.deleteblue),
        type: 3),

    LogoutModel(
        title: tr(LocaleKeys.additionText_changeLanguage),
        image: AssetImage(AppImage.languageIcon),
        type: 4),

    LogoutModel(
        title: "Notification",
        // title: tr(LocaleKeys.additionText_changeLanguage),
        image: AssetImage(AppImage.notificIcon),
        type: 5),
  ];
}
