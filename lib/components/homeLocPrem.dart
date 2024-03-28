import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/screen/blur_background.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../generated/locale_keys.g.dart';
import '../monish/provider/myProvider.dart';
import '../provider/authprovider.dart';
import '../provider/petprovider.dart';
import '../screen/tryAgain.dart';
import '../util/app_font.dart';
import '../util/color.dart';
import 'customBlueButton.dart';
import 'globalnavigatorkey.dart';
// additionText_locPopup

Future<void> homLocPermiDialog(BuildContext context, int isFromHome) async {
  print("isFromHome====$isFromHome");
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => blurView(
            child: AlertDialog(
              elevation: 20,
              backgroundColor: AppColor.textFieldGrey,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Text(
                  tr(LocaleKeys.additionText_locPopup)
                  // "Unique Tags needs your location permission to find your lost pet and helping to"
                  //     " people for finding their missing pet. We do not share your location with anyone."
                  ,
                  style: const TextStyle(
                    fontFamily: AppFont.poppinsRegular,
                    fontSize: 18,
                    color: AppColor.textLightBlueBlack,
                  )),
              actions: <Widget>[
                // InkWell(
                //   child: Text("Cancel"
                //
                //     ,style: TextStyle(
                //         fontSize: 17.0,
                //         fontFamily: AppFont.poppinsMedium
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                // SizedBox(width: 5,),

                Consumer<PetProvider>(builder: (context, petProvider, child) {
                  return
                      //   Center(
                      //   child: InkWell(
                      //     child: Center(
                      //       child: Text(
                      //         tr(LocaleKeys.additionText_ok),
                      //         style: TextStyle(
                      //           fontSize: 17.0,
                      //           fontFamily: AppFont.poppinsMedium,
                      //           color: AppColor.textLightBlueBlack,
                      //         ),
                      //       ),
                      //     ),
                      //     onTap: () async {
                      //       Navigator.pop(context);
                      //       HiveHandler.updateLocPopup(true);
                      //       AuthProvider authProvider=Provider.of(context,listen: false);
                      //       authProvider.isNewLogin=0;
                      //
                      //       var stat = await Permission.location.status;
                      //       print("status==>${stat}");
                      //
                      //       if (Platform.isIOS) {
                      //         if (isFromHome == 1) {
                      //           print("**--*--*-*-**");
                      //           try {
                      //             Position posti = await _determineCurPosition();
                      //             petProvider.updateLoader(false);
                      //             petProvider.lati = posti.latitude;
                      //             petProvider.longi = posti.longitude;
                      //           } catch (e) {
                      //             petProvider.updateLoader(false);
                      //             EasyLoading.showToast("Something went wrong! \nTry Again Later");
                      //             print("error========${e}");
                      //
                      //           }
                      //         }
                      //         if (isFromHome == 0) {
                      //           petProvider.updateLoader(false);
                      //           AppSettings.openAppSettings();
                      //           petProvider.updateLoader(false);
                      //
                      //         }
                      //       }
                      //       if (Platform.isAndroid) {
                      //         petProvider.updateLoader(false);
                      //         await Permission.location.request();
                      //         petProvider.updateLoader(false);
                      //       }
                      //
                      //       print("*******calling check final******");
                      //       await checkFinal(GlobalVariable.navState.currentContext!);
                      //     },
                      //   ),
                      // );
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 15),
                    child: CustomButton(
                        // colour: AppColor.newGrey,
                        // context: context,
                        text: tr(LocaleKeys.additionText_ok),
                        onPressed: () async {
                          Navigator.pop(context);
                          HiveHandler.updateLocPopup(true);
                          AuthProvider authProvider = Provider.of(context, listen: false);
                          authProvider.isNewLogin = 0;

                          var stat = await Permission.location.status;
                          print("status==>$stat");

                          if (Platform.isIOS) {
                            if (isFromHome == 1) {
                              print("**--*--*-*-**");
                              try {
                                Position posti = await _determineCurPosition();
                                petProvider.updateLoader(false);
                                petProvider.lati = posti.latitude;
                                petProvider.longi = posti.longitude;
                              } catch (e) {
                                petProvider.updateLoader(false);
                                EasyLoading.showToast("Something went wrong! \nTry Again Later");
                                print("error========$e");
                              }
                            }
                            if (isFromHome == 0) {
                              petProvider.updateLoader(false);
                              AppSettings.openAppSettings();
                              petProvider.updateLoader(false);
                            }
                          }
                          if (Platform.isAndroid) {
                            petProvider.updateLoader(false);
                            await Permission.location.request();
                            petProvider.updateLoader(false);
                          }

                          print("*******calling check final******");
                          await checkFinal(GlobalVariable.navState.currentContext!);
                        }),
                  );
                }),
              ],
            ),
          ));
}

Future<void> checkFinal(BuildContext context) async {
  AuthProvider authProvider = Provider.of(context, listen: false);
  if (Platform.isAndroid) {
    Myprovider myProvider = Provider.of(context, listen: false);
    var laststatus = await Permission.location.status;
    print("value of last location stat====$laststatus");

    if (laststatus == PermissionStatus.granted) {
      await onNotification();
      HiveHandler.updateNotiButton(true);
      // myProvider.setButtonOn = true;
      myProvider.setButtonOn = HiveHandler.isChekLostNoti();
    } else {
      HiveHandler.updateLocPopup(true);
      authProvider.isNewLogin = 0;
    }
  }

  if (Platform.isIOS) {
    Myprovider myProvider = Provider.of(context, listen: false);
    var lastStatIos = await Geolocator.checkPermission();
    print("lastStatIos status ios===>>$lastStatIos");

    if (lastStatIos == LocationPermission.whileInUse || lastStatIos == LocationPermission.always) {
      await onNotification();
      HiveHandler.updateNotiButton(true);
      myProvider.setButtonOn = HiveHandler.isChekLostNoti();
    } else {
      HiveHandler.updateLocPopup(true);
      authProvider.isNewLogin = 0;
    }
  }
}

Future<void> onNotification() async {
  Myprovider myProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
  PetProvider petProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
  AuthProvider authProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);

  bool isSelected = HiveHandler.isLocApiCall();
  print("Show location popup==>$isSelected");
  print("authProvider.isNewLogin==>${authProvider.isNewLogin}");
  // if (!isSelected || authProvider.isNewLogin == 1)
  {
    if (Platform.isAndroid) {
      var status3 = await Permission.location.status;
      print("help pet lost noti status andr=>$status3");
      if (status3 == PermissionStatus.granted) {
        // petProvider.updateLoader(true);

        try {
          print("inside  try block ");
          Position posti = await _determineCurPosition();

          petProvider.updateLoader(false);

          petProvider.lati = posti.latitude;
          petProvider.longi = posti.longitude;

          print("****************************************");
          petProvider.calleditProfileP2Api(context: GlobalVariable.navState.currentContext!);
        } catch (e) {
          petProvider.updateLoader(false);

          EasyLoading.showToast("Something went wrong! \nTry Again Later");
          print("error========$e");

          // petProvider.updateLoader(false);
        }

        petProvider.updateLoader(false);
        print("****************************************");
        petProvider.calleditProfileP2Api(context: GlobalVariable.navState.currentContext!);

        // myProvider.callsendNotificationApi(iddd: 1, status: 1);
        // myProvider.chngSetButton();
      }
    }

    if (Platform.isIOS) {
      var status4 = await Geolocator.checkPermission();
      print("help pet lost noti status ios=>$status4");
      if (status4 == LocationPermission.whileInUse || status4 == LocationPermission.always) {
        // petProvider.updateLoader(true);
        try {
          Position posti = await _determineCurPosition();

          petProvider.updateLoader(false);

          petProvider.lati = posti.latitude;
          petProvider.longi = posti.longitude;
        } catch (e) {
          print("error========$e");
          petProvider.updateLoader(false);
          // TryAgainAlert(GlobalVariable.navState.currentContext!);
          // ClickableToast();
        }
        print("****************************************");
        petProvider.calleditProfileP2Api(context: GlobalVariable.navState.currentContext!);

        // myProvider.callsendNotificationApi(iddd: 1, status: 1);
        // myProvider.chngSetButton();
      }
    }
  }

  HiveHandler.updateLocApiCall(true);

  bool checkFinalStatus = HiveHandler.isLocApiCall();

  print("Show location popupgdfds==>$checkFinalStatus");
}

Future<Position> _determineCurPosition() async {
  print("inside location function");
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
    // forceAndroidLocationManager: false,
    // timeLimit: Duration(seconds: 7)
  ).onError(
    (error, stackTrace) => Future.error('Location permissions are denied$error'),

    // Geolocator.getLastKnownPosition()
  );
}
