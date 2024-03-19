import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:find_me/api/staus_enum.dart';
import 'package:find_me/components/globalnavigatorkey.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/screen/achievements.dart';
import 'package:find_me/screen/dashboard.dart';
import 'package:find_me/screen/showallpet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../api/call_api.dart';
import '../api/network_calls.dart';
import '../models/achievement_model.dart';
import '../models/family_member_model.dart';
import '../models/verified_list_api_model.dart';
import '../screen/join_managment.dart';

class AchievementProvider extends ChangeNotifier {
  AppApi api = AppApi();
  File? achievementImage;
  VerifiedListApiModel? verifiedListApiModel;
  List<Verified> finalList = [];
  bool isAsFamilyMember = false;
  bool isAsJoinManagment = false;
  String imgUrls = "";
  List<AchievementModel> list = [];
  bool listLoader = false;
  List<Premium> premiumUser = [];
  List<Verified> peopleList = [];
  updateAchievementImage(File? fil) {
    achievementImage = fil;
    Future.delayed(Duration(seconds: 1), () {
      notifyListeners();
    });
  }

  updateAsFamilyMember(bool family, bool managment) {
    print("$family  $managment");
    isAsFamilyMember = family;
    isAsJoinManagment = managment;
    Future.delayed(Duration(seconds: 0), () {
      notifyListeners();
    });
  }

  updateLoader(bool val) {
    listLoader = val;
    Future.delayed(Duration(seconds: 1), () {
      notifyListeners();
    });
  }

  updateFiles(String val) {
    imgUrls = val;
    Future.delayed(Duration(milliseconds: 1000), () {
      notifyListeners();
    });
  }

  Future callAddAchieve(
      int id, String title, String description, BuildContext ctx,
      {bool isForEdit = false}) async {
    String urlOfImg = "";

    List images = [
      {"key": "image", "image": achievementImage}
    ];

    await api.callUploadPetImage(true, images).then((value) async {
      if (value?.status == Status.success) {
        urlOfImg = value?.data["fileName"];
      }
    }).onError((error, stackTrace) {
      // updateLoader(false);
    });

    Map body = {
      "${isForEdit ? "id" : "petId"}": id,
      "title": title.trim(),
      "description": description.trim(),
      "${isForEdit ? "image" : "images"}": urlOfImg
    };
    await api.addAchievement(body, isForEdit: isForEdit).then((value) async {
      print("img uploaded ${value.status}");
      if (value.status == Status.success) {
        await CoolAlert.show(
            context: ctx, type: CoolAlertType.success, text: value.message);
        Navigator.pushReplacement(ctx, MaterialPageRoute(
          builder: (ctx) {
            return Achievement(
              isNavigate: true,
            );
          },
        ));
      } else {
        CoolAlert.show(
            context: GlobalVariable.navState.currentState!.context,
            type: CoolAlertType.error,
            text: value.message);
      }
    }).onError((error, stackTrace) {
      CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: "Something went wrong");
    });
    notifyListeners();
  }

  Future updateAchieveMent(int id, String title, String description,
      String ingUrl, BuildContext ctx) async {
    String urlOfImg = ingUrl;
    print("call function of update");
    if (title.isEmpty) {
      CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: "Please enter Achievement Title");
    } else if (description.isEmpty) {
      CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: "Please enter Achievement Description");
    } else if (urlOfImg.isEmpty) {
      CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: "Please enter Achievement Image");
    } else {
      if (achievementImage != null) {
        List images = [
          {"key": "image", "image": achievementImage}
        ];
        await api.callUploadPetImage(true, images).then((value) async {
          if (value.status == Status.success) {
            urlOfImg = value.data["fileName"];
          }
        }).onError((error, stackTrace) {
          // updateLoader(false);
        });
      }
      Map body = {
        "id": id,
        "title": title.trim(),
        "description": description.trim(),
        "image": urlOfImg
      };
      await api.addAchievement(body, isForEdit: true).then((value) async {
        print("values updated  is >>>>>>  ${value?.status}");
        if (value.status == Status.success) {
          await CoolAlert.show(
              context: GlobalVariable.navState.currentState!.context,
              type: CoolAlertType.success,
              text: value.message);
          Navigator.pushReplacement(ctx, MaterialPageRoute(
            builder: (ctx) {
              return Achievement(
                isNavigate: true,
              );
            },
          )

              // CoolAlert.show(
              //     context: GlobalVariable.navState.currentState!.context,
              //     type: CoolAlertType.success,
              //     text: value.message);

              );
        } else {
          CoolAlert.show(
              context: GlobalVariable.navState.currentState!.context,
              type: CoolAlertType.error,
              text: value.message);
        }
      });
    }
  }

  Future getAllAchievement(int id) async {
    Map body = {"petId": id};
    print("call function for get all achievement");
    updateLoader(true);
    return api.allAchievement(body).then((value) {
      if (value.status == Status.success) {
        AchievementApiModel model = AchievementApiModel.fromJson(value.data);
        list = model.achievement ?? [];
        updateLoader(false);
        notifyListeners();
      } else {
        return AchievementApiModel.fromJson({});
      }
    }).whenComplete(() {
      notifyListeners();
      updateLoader(false);
    });
    // .onError((error, stackTrace) {
    //   updateLoader(false);
    // });
  }

  Future<AchievementModel> callGetAchievement(int id) {
    Map body = {"id": id};
    return api.getAchievementById(body).then((value) {
      if (value.status == Status.success) {
        return AchievementModel.fromJson(value.data);
      } else {
        return AchievementModel.fromJson(value.data);
      }
    });
  }

  Future callDeleteAchievement(int id, BuildContext ctx) async {
    Map body = {"id": id};
    await api.deleteAchieve(body).then((value) async {
      if (value.status == Status.success) {
        await CoolAlert.show(
            context: ctx, type: CoolAlertType.success, text: value.message);
        Navigator.pushReplacement(ctx, MaterialPageRoute(
          builder: (ctx) {
            return Achievement(
              isNavigate: true,
            );
          },
        ));
      } else {
        CoolAlert.show(
            context: ctx, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) {
      CoolAlert.show(
          context: ctx, type: CoolAlertType.error, text: error.toString());
    });
  }

  Future callVerifiedList() async {
    EasyLoading.show();
    await api.verifiedList().then((value) {
      if (value.status == Status.success) {
        verifiedListApiModel = VerifiedListApiModel.fromJson(value.data);
        List<Verified> first = verifiedListApiModel?.notVerified ?? [];
        List<Verified> second = verifiedListApiModel?.pendingUser ?? [];

        List<Verified> firstOne = verifiedListApiModel?.verifiedList ?? [];
        List<Verified> secondOne = verifiedListApiModel?.approvedUser ?? [];


               print("finalList ${first}");

               print("finalList ${first}");
        finalList = first + second;
        peopleList = firstOne + secondOne;

         print("finalList ${finalList.length}");

         print("peopleList ${peopleList.length}");

        // print("finalList ${finalList[0]}");

        print(  "verifiedListApiModel ${verifiedListApiModel?.verifiedList.length}");

        print("pending user  ${verifiedListApiModel?.pendingUser.length}");
        print("not verified user  ${verifiedListApiModel?.notVerified.length}");
        print(
            "approvedUser user  ${verifiedListApiModel?.approvedUser.length}");
        EasyLoading.dismiss();
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });

    notifyListeners();
  }

  Future callSendRequest(
      String phoneCode, String mobileNumber, BuildContext ctx) async {
    EasyLoading.show();
    print("call send request ");

    if (isAsFamilyMember && premiumUser.length >= 4) {
      CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: "You can not add more than 4 user ");
      EasyLoading.dismiss();
      return;
    }
    await api
        .requestManagement(phoneCode, mobileNumber, isAsFamilyMember ? 1 : 0,
            isAsJoinManagment ? 1 : 0)
        .then((value) async {
      print("values is ${value}");
      if (value.status == Status.success) {
        AuthProvider authProvider=Provider.of(ctx,listen: false);
        authProvider.jntMgtphncod="44";
        print("jntMgtphncod===${authProvider.jntMgtphncod}");
        EasyLoading.dismiss();
        await CoolAlert.show(
            context: ctx, type: CoolAlertType.success, text: value.message);

            Navigator.push(ctx,MaterialPageRoute(builder: (ctx)=>JoinManagement(
              // navigateToSecondPage: true,
                isNavigate: true,)));
        // Navigator.pushReplacement(
        //   ctx,
        //   MaterialPageRoute(
        //     builder: (ctx) {
        //       return JoinManagement(
        //         navigateToSecondPage: true,
        //         isNavigate: true,
        //       );},),);
      } else {
        // AuthProvider authProvider=Provider.of(ctx,listen: false);
        // authProvider.jntMgtphncod="44";
        CoolAlert.show(
            context: GlobalVariable.navState.currentState!.context,
            type: CoolAlertType.error,
            text: value.message);
        EasyLoading.dismiss();
      }
    }).onError((error, stackTrace) {
      // AuthProvider authProvider=Provider.of(ctx,listen: false);
      // authProvider.jntMgtphncod="44";
      CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: error.toString());
      EasyLoading.dismiss();
    });
  }

  Future callRequestFunction(int id, int status, int index,
 
      {bool isFromPremiumUser = false, bool isNavigateToPet=true}) async {
        print("isNavigateToPet $isNavigateToPet");
    print("status id ${status}");
    EasyLoading.show();
    int statusId = 0;


    if (status == 1 || status == 2) {
      statusId = finalList[index].userSenderId ?? 0;
    } else if (status == 3) {
      statusId = peopleList[index].userReciverId ?? 0;
    } else if(status == 5){
       statusId = peopleList[index].userSenderId ?? 0;
    }  else if (status == 4 ) {
      if (!isFromPremiumUser) {
        statusId = finalList[index].userReciverId ?? 0;
      } else {
        statusId = premiumUser[index].userSenderId ?? 0;
        Navigator.pop(GlobalVariable.navState.currentState!.context);
      }
    }

    /// 1 for accept
    /// 2 for declined
    await api.verifiedRequest(id, status, statusId).then((value) async {
      if (value.status == Status.success) {
        EasyLoading.dismiss();
        await CoolAlert.show(
            context: GlobalVariable.navState.currentState!.context,
            type: CoolAlertType.success,
            text: value.message);


        if(status==2||status==4||status==1){
          finalList.removeAt(index);
        }else if(status==5||status==3){
          peopleList.removeAt(index);
        }

        // if (status != 4 && status != 5) {
        //   finalList.removeAt(index);
        // } else {
        //   if (isFromPremiumUser) {
        //     premiumUser.removeAt(index);
        //   } else {
        //     peopleList.removeAt(index);
        //   }
        // }
        print("status is >>>> ${status}");
        if (status == 1) {
          Navigator.pushReplacement(
              GlobalVariable.navState.currentState!.context, MaterialPageRoute(
            builder: (context) {
              return !isNavigateToPet ? ShowAllPet():DashBoard(type: 0,);
            },
          ), result: false);
        }
        notifyListeners();
        EasyLoading.dismiss();
        callVerifiedList();
      } else {
        CoolAlert.show(
            context: GlobalVariable.navState.currentState!.context,
            type: CoolAlertType.error,
            text: value.message);
        EasyLoading.dismiss();
      }
    }).onError((error, stackTrace) async {
      await CoolAlert.show(
          context: GlobalVariable.navState.currentState!.context,
          type: CoolAlertType.error,
          text: error.toString());

      EasyLoading.dismiss();
    });
  }

  Future respondpremiumUser(
      int id, int status, BuildContext context, int index) async {
    EasyLoading.show();
    await api
        .verifiedPremiumRequest(
            id, status, premiumUser[index].userReciverId ?? 0)
        .then((value) async {
      if (value.status == Status.success) {
       
        premiumUser.removeAt(index);
        Navigator.pop(context);
        getPremiumUser();
        EasyLoading.dismiss();
        
      await  CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

      } else {
         Navigator.pop(context);
        EasyLoading.dismiss();
       await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) async {
       Navigator.pop(context);
      EasyLoading.dismiss();
     await CoolAlert.show(
          context: context, type: CoolAlertType.error, text: error.toString());
    });
  }

  Future getPremiumUser() async {
    premiumUser = [];
    updateLoader(true);
    await api.callPremiusUserApi().then((value) {
      if (value.data['premium'] != null &&
          (value.data['premium'] as List).isNotEmpty) {
        premiumUser = List<Premium>.from(
            value.data['premium'].map((x) => Premium.fromJson(x)));
      } else {
        EasyLoading.dismiss();
      }
      updateLoader(false);
      notifyListeners();
    }).onError((error, stackTrace) =>updateLoader(false));

    // .onError((error, stackTrace) {
    //   updateLoader(false);
    // });
  }




  late TabController tabController;
  setTabContAch(cont) {
    tabController = cont;
    Future.delayed(Duration.zero, () {

      notifyListeners();
    });
  }



}
