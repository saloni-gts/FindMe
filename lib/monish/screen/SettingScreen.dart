import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/screen/langPikr.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/deleteAlert.dart';
import '../../components/globalnavigatorkey.dart';
import '../../components/homeLocPrem.dart';
import '../../generated/locale_keys.g.dart';
import '../../provider/petprovider.dart';
import '../../screen/changePassword.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';

import '../provider/myProvider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late var Switchcontroller = ValueNotifier<bool>(true);

  @override
  void initState() {
    Myprovider myprovider = Provider.of(context, listen: false);
    PetProvider petProvider = Provider.of(context, listen: false);
    // petProvider.updateLoader(true);
    print("setButtonOn${myprovider.setButtonOn}");
    myprovider.setButtonOn = HiveHandler.isChekLostNoti();
    // chkButtonStaus();
    super.initState();

    // petProvider.updateLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(
        titlename: tr(LocaleKeys.additionText_settings),
      ),

      // bottomNavigationBar: BotttomBorder(context),
      body: Consumer<Myprovider>(builder: (context, myprovider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 13
              // , left: 22, right: 21
              ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  // height: 280,
                  color: AppColor.newGrey,
                  child: Column(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     width: 332,
                      //     // height: 376,
                      //     height: 300,
                      //     decoration: BoxDecoration(
                      //       color: AppColor.textFieldGrey,
                      //     ),
                      //     child: ListView.builder(
                      //       itemCount: myprovider.SettingPage.length,
                      //       itemBuilder: (context, index) {
                      //         final item = myprovider.SettingPage[index];
                      //         return InkWell(
                      //           onTap: () async {
                      //             print("type is ${item.type}");
                      //             if (item.type == 0) {
                      //               return cngPasswordDialog(context: context);
                      //             }
                      //             if (item.type == 3) {
                      //               return deleteUserDialog(context: context);
                      //             }
                      //
                      //             if (item.type == 4) {
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => LangPicker(),
                      //                   ));
                      //             }
                      //             if (item.type == 5) {
                      //
                      //
                      //             }
                      //           },
                      //           child: ListTile(
                      //             horizontalTitleGap: -5,
                      //             leading: Container(
                      //                 height: 18,
                      //                 width: 18,
                      //                 child: Image(
                      //                   image: item.image,
                      //                 )),
                      //             title: Padding(
                      //               padding: const EdgeInsets.only(bottom: 5.0),
                      //               child: Text(item.title.toString(),
                      //                   style: TextStyle(
                      //                       fontSize: 12,
                      //                       fontFamily: AppFont.poppinsRegular,
                      //                       color: AppColor.textLightBlueBlack)),
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            return cngPasswordDialog(context: context);
                          },
                          child: Row(
                            children: [
                              Image.asset(AppImage.change_icon),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                tr(LocaleKeys.additionText_chngPass),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 27,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            return deleteUserDialog(context: context);
                          },
                          child: Row(
                            children: [
                              SizedBox(height: 20, child: Image.asset(AppImage.deleteblue)),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                tr(LocaleKeys.additionText_deleteOwnrProfile),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LangPicker(),
                                ));
                          },
                          child: Row(
                            children: [
                              SizedBox(height: 20, child: Image.asset(AppImage.languageIcon)
                                  // Icon(Icons.c)
                                  ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                tr(LocaleKeys.additionText_changeLanguage),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Image.asset(AppImage.notificIcon),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 240,
                              child: Text(
                                tr(LocaleKeys.additionText_notiOther),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                            ),
                            const Spacer(),
                            Consumer<Myprovider>(builder: (context, myprovider, child) {
                              return Radio(
                                  activeColor: AppColor.textLightBlueBlack,
                                  toggleable: true,
                                  value: true,
                                  groupValue: myprovider.radioVal,
                                  onChanged: (value) {
                                    // myprovider.onRadioChange();
                                    print("radioValradioVal${myprovider.radioVal}");

                                    myprovider.radioVal == true
                                        ? showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context1) {
                                              return AlertDialog(
                                                title: Text(
                                                  tr(LocaleKeys.additionText_wanaStpOthrNoti),
                                                ),
                                                actions: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_cancel),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context1);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_yes),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () async {
                                                      myprovider.callsendNotificationApi(iddd: 2, status: 0);
                                                      Navigator.pop(context1);
                                                      myprovider.onRadioChange();
                                                    },
                                                  )
                                                ],
                                              );
                                            })
                                        : showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context1) {
                                              return AlertDialog(
                                                title: Text(tr(LocaleKeys.additionText_thnksFrAlowNoti)),
                                                actions: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_okay)
                                                      // tr(LocaleKeys.additionText_cancel)

                                                      ,
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context1);
                                                      myprovider.callsendNotificationApi(iddd: 1, status: 0);
                                                      myprovider.onRadioChange();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                    //selected value
                                  });
                            }),
                          ],
                        ),
                      ),

                      // SizedBox(
                      //   height: 20,
                      // ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image.asset(AppImage.notificIcon),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 240,
                                child: Text(
                                  tr(LocaleKeys.additionText_notiFrHlpLstPet),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinsRegular),
                                ),
                              ),

                              const Spacer(),

                              Consumer<Myprovider>(builder: (context, myprovider, child) {
                                return Radio(
                                  activeColor: AppColor.textLightBlueBlack,
                                  toggleable: true,
                                  value: true,
                                  groupValue: myprovider.setButtonOn,
                                  onChanged: (value) {
                                    // myprovider.onLostPetRadChange();

                                    myprovider.setButtonOn == false
                                        ? askPermission()

                                        // checkPermission()

                                        // showDialog(
                                        //     barrierDismissible: false,
                                        //     context: context,
                                        //     builder: (context1) {
                                        //       return AlertDialog(
                                        //
                                        //         title: Text(
                                        //             'Thanks! for allowing the notification of "Help lost pet"'),
                                        //         actions: <Widget>[
                                        //           InkWell(
                                        //             child: Text(
                                        //               "Okay"
                                        //               // tr(LocaleKeys.additionText_cancel)
                                        //
                                        //               ,
                                        //               style: TextStyle(
                                        //                   fontSize: 17.0,
                                        //                   fontFamily:
                                        //                   AppFont.poppinsMedium),
                                        //             ),
                                        //             onTap: () {
                                        //               myprovider.chngSetButton();
                                        //               myprovider.callsendNotificationApi(iddd: 1,status: 1);
                                        //               Navigator.pop(context1);
                                        //             },
                                        //           ),
                                        //         ],
                                        //       );
                                        //     })

                                        : showDialog(
                                            context: context,
                                            builder: (context1) {
                                              return AlertDialog(
                                                title: Text(tr(LocaleKeys.additionText_wnaStpNotiHlpLstPet)),
                                                actions: [
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_cancel),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context1);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_yes),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () async {
                                                      myprovider.chngSetButton();
                                                      myprovider.callsendNotificationApi(iddd: 2, status: 1);
                                                      HiveHandler.updateNotiButton(false);
                                                      var v1 = HiveHandler.isChekLostNoti();
                                                      print("value of v1====$v1");
                                                      Navigator.pop(context1);
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                  },
                                );
                              })

                              // Radio(value: true, groupValue: groupValue, onChanged: onChanged)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          // height: 15,
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Image.asset(AppImage.change_icon),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "Privacy Control",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinsRegular),
                            ),
                            const Spacer(),
                            Consumer<PetProvider>(builder: (context, petprovider, child) {
                              return Radio(
                                  activeColor: AppColor.textLightBlueBlack,
                                  toggleable: true,
                                  value: true,
                                  groupValue: petprovider.privacyRadioVal,
                                  onChanged: (value) {
                                    // myprovider.onRadioChange();
                                    print("radioValradioVal${petprovider.privacyRadioVal}");

                                    petprovider.privacyRadioVal == true
                                        ? showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context1) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Are you sure you want to disable the privacy status",
                                                ),
                                                actions: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_cancel),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context1);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_yes),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () async {
                                                      petprovider.callPrivacyUpdateApi(0, context1);
                                                      Navigator.pop(context1);
                                                      petprovider.onprivacyRadioValChange();
                                                    },
                                                  )
                                                ],
                                              );
                                            })
                                        : showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context1) {
                                              return AlertDialog(
                                                title: const Text("Are you sure you want to enable the privacy stauts"),
                                                actions: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_okay)
                                                      // tr(LocaleKeys.additionText_cancel)

                                                      ,
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      petprovider.callPrivacyUpdateApi(1, context1);
                                                      Navigator.pop(context1);
                                                      petprovider.onprivacyRadioValChange();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });

                                    //selected value
                                  });
                            }),
                          ],
                        ),
                      )

                      //
                      // mycustomBlueButton(
                      //     height: false,
                      //     context: context,
                      //     text1: 'LOGOUT',
                      //     onTap1: () {    HiveHandler.clearUser();
                      //     Navigator.pushNamedAndRemoveUntil(
                      //         context, AppScreen.signIn, (r) => false);
                      //
                      //     },
                      //     border1: false,
                      //     putheight: 56.0,
                      //     width: 220.0,
                      //     colour: AppColor.buttonRedColor)
                      //
                    ],
                  ),
                ),
              ),
              const Spacer(),
              BotttomBorder(context),
            ],
          ),
        );
      }),
      // bottomNavigationBar: BotttomBorder(context),
    );
  }

  Future<void> checkPermission() async {
    PermissionStatus status3;
    LocationPermission status4;

    if (Platform.isIOS) {
      status4 = await Geolocator.checkPermission();
      print("location status ios===>>$status4");
      if (status4 == LocationPermission.denied || status4 == LocationPermission.deniedForever) {
        Future.delayed(const Duration(seconds: 2), () {
          homLocPermiDialog(context, 0);
        });
      }
    }

    if (Platform.isAndroid) {
      status3 = await Permission.location.status;

      print("location status android===>>$status3");
      // if (!status3.isGranted)
      if (status3 != PermissionStatus.granted) {
        Future.delayed(const Duration(seconds: 2), () {
          homLocPermiDialog(context, 0);
        });
      }
    }
  }

  askPermission() async {
    Myprovider myProvider = Provider.of(context, listen: false);

    if (Platform.isIOS) {
      var status4 = await Geolocator.checkPermission();
      print("help pet lost noti status=>$status4");
      if (status4 == LocationPermission.whileInUse || status4 == LocationPermission.always) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context1) {
              return AlertDialog(
                title: Text(tr(LocaleKeys.additionText_thnksFrAlNotiHlpLstPt)),
                actions: <Widget>[
                  InkWell(
                    child: Text(
                      tr(LocaleKeys.additionText_okay)
                      // tr(LocaleKeys.additionText_cancel)

                      ,
                      style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                    ),
                    onTap: () {
                      myProvider.chngSetButton();
                      myProvider.callsendNotificationApi(iddd: 1, status: 1);
                      HiveHandler.updateNotiButton(true);
                      var v1 = HiveHandler.isChekLostNoti();
                      print("value of v1====$v1");
                      Navigator.pop(context1);
                    },
                  ),
                ],
              );
            });
      } else {
        homLocPermiDialog(context, 0);
      }
    }

    if (Platform.isAndroid) {
      var status3 = await Permission.location.status;
      print("help pet lost noti status=>$status3");
      if (status3 == PermissionStatus.granted) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context1) {
              return AlertDialog(
                title: Text(tr(LocaleKeys.additionText_thnksFrAlNotiHlpLstPt)),
                actions: <Widget>[
                  InkWell(
                    child: Text(
                      tr(LocaleKeys.additionText_okay)
                      // tr(LocaleKeys.additionText_cancel)

                      ,
                      style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                    ),
                    onTap: () {
                      myProvider.chngSetButton();
                      myProvider.callsendNotificationApi(iddd: 1, status: 1);
                      HiveHandler.updateNotiButton(true);
                      var v1 = HiveHandler.isChekLostNoti();
                      print("value of v1====$v1");
                      Navigator.pop(context1);
                    },
                  ),
                ],
              );
            });
      } else {
        homLocPermiDialog(context, 0);
      }
    }
  }

  Future<void> chkButtonStaus() async {
    Myprovider myProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
    PetProvider petProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);

    petProvider.updateLoader(true);

    if (Platform.isAndroid) {
      var status3 = await Permission.location.status;
      print("help pet lost noti status andr=>$status3");
      if (status3 == PermissionStatus.granted) {
        myProvider.setButtonOn = true;
        print("setButtonOn status android=>${myProvider.setButtonOn}");
      }
    }

    if (Platform.isIOS) {
      var status4 = await Geolocator.checkPermission();
      print("help pet lost noti status ios=>$status4");
      if (status4 == LocationPermission.whileInUse || status4 == LocationPermission.always) {
        myProvider.setButtonOn = true;
        print("setButtonOn status ios=>${myProvider.setButtonOn}");
      }
    }

    petProvider.updateLoader(false);
  }
}
