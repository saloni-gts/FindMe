import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/globalnavigatorkey.dart';
import 'package:find_me/monish/screen/familyPlan.dart';
import 'package:find_me/screen/signUpScreen.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_route.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_app_review/in_app_review.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';





import '../../common/change_lang.dart';
import '../../components/customBlueButton.dart';
import '../../components/deleteAlert.dart';
import '../../components/logoutAlert.dart';
import '../../components/newPreview.dart';
import '../../generated/locale_keys.g.dart';
import '../../models/usermodel.dart';
import '../../provider/authprovider.dart';
import '../../provider/petprovider.dart';
import '../../provider/purchase_provider.dart';
import '../../screen/LogoutPage.dart';
import '../../screen/add_managment.dart';
import '../../screen/changePassword.dart';
import '../../screen/dashboard.dart';

import '../../screen/join_managment.dart';
import '../../screen/viewPremium.dart';
import '../../services/hive_handler.dart';
import '../../util/appstrings.dart';
import '../models/newModel.dart';
import '../provider/myProvider.dart';
import '../reUseClass/custombluebutton.dart';
import '../reUseClass/myappbar.dart';
import 'SettingScreen.dart';

class MoreFeature extends StatefulWidget {
  const MoreFeature({Key? key}) : super(key: key);

  @override
  State<MoreFeature> createState() => _MoreFeatureState();
}

class _MoreFeatureState extends State<MoreFeature> {
  List<Choice> choices = [];
  List<Choice> choices1 = [];
  List<Choice> choices2 = [];
  int a = 0;

  Timer? debouncer;
  late Timer time;

  void start() {
    time;
  }

  bool b = true;

  // var isChoice;
  @override

  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;
  void initState() {

    PurChaseProvider purchaseProvider=Provider.of(context,listen: false);
    PetProvider petProvider=Provider.of(context,listen: false);
    purchaseProvider.loadPurchase();
    choices= purchaseProvider.isChoice==2? choices1:choices2;


    petProvider.callContactApi=0;
    petProvider.contactUsApiCall(context);
    print("CheckPurchased========>${purchaseProvider.CheckPurchased}");
     print("");


    // purchaseProvider.userIsPremium?
    PurChaseProvider purChaseProvider = Provider.of(context, listen: false);

    // petProvider.isUserPremium==1?choices1:choices2;
    // print("purChaseProvider.plan[0]====${purChaseProvider.plan[0]}");
    if(purChaseProvider.plan.isNotEmpty) {

      purchaseProvider.isChoice = purChaseProvider.plan[0];
      print("(purChaseProvider.isUsrJoint) ${purChaseProvider.isUsrJoint}");
     if(purChaseProvider.isUsrJoint==1){
       purchaseProvider.isChoice =1;
     }
    }
        // choices= user.isPremium==1 && isChoice==2? choices1:choices2;
    choices= purchaseProvider.isChoice==2? choices1:choices2;


        // choices= purchaseProvider.CheckPurchased==3? choices1:choices2;


        super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    PetProvider provider = Provider.of(context, listen: false);
    AuthProvider authprovider = Provider.of(context, listen: false);
    var petDetail = provider.selectedPetDetail;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            mycustomBlueButton(
                height: false,
                context: context,
                text1:
                    // "LOGOUT",
                    tr(LocaleKeys.additionText_logout),
                onTap1: () {
                  logoutAlert(context);
                  //  print("object......${ConnectivityResult}");
                  // if( !await InternetConnectionChecker().hasConnection)
                  // {
                  //
                  // }
                  // else {
                  //
                  //   print("api calling");
                  //   authprovider.logoutApiCall(context);
                  //   print("api called");
                  //   // HiveHandler.clearUser();
                  //   // Navigator.pushNamedAndRemoveUntil(
                  //   //     context, AppScreen.signIn, (r) => false);
                  // }
                },
                border1: false,
                putheight: 56.0,
                width: 220.0,
                colour: AppColor.buttonRedColor),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      appBar: customAppbar(
        titlename: tr(LocaleKeys.additionText_morFechrs),
        isbackbutton: false,
      ),

      // MycustomAppbar(
      //   titlename: AppStrings.moreFeatures,
      //   isbackbutton: false,
      //   icon: false,
      // ),
      //

      // bottomNavigationBar: BotttomBorder(context),
      body: Consumer3<PetProvider, Myprovider,PurChaseProvider>(
          builder: (context, petProvider, myprovider,purc ,child) {
        print("choices choices.length ${choices.length}");
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.62,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                  ),
                  child: ListView.builder(
                    itemCount: purc.choices.length,
                    itemBuilder: (context, index) {
                      final item = purc.choices[index];
                      return Center(
                        child: InkWell(
                          onTap: () async {
                            print("type is ${item.type}");

                            if (item.type == 13) {
                              PurChaseProvider purChaseProvider=Provider.of(context,  listen: false);
                              purChaseProvider.getSubScriptionDetails();


                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) {
                              //     return BuyPremium();
                              //   },
                              // ));

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ViewPremium();
                                },
                              ));





                              // showPurchasePlanBottomSheet(context);
                            }

                            if (item.type == 1) {
                               print("family member ====");  

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                builder: (context) => FamilyPlan()));
                            }

                            //else
                            if (item.type == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UrlViewer(
                                            webViewType: 3,
                                          )));
                              // final InAppReview inAppReview = InAppReview.instance;
                              // inAppReview.openStoreListing(appStoreId: )
                            }

                            if (item.type == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UrlViewer(
                                            webViewType: 4,
                                          )));

                              //   final InAppReview inAppReview = InAppReview.instance;
                              //
                              // if (await inAppReview.isAvailable()) {
                              //   inAppReview.requestReview();
                              // }
                            }

                            if (item.type == 4) {
                              if(petProvider.petDetailList2.isEmpty){
                                showDialog(context: context, builder:(context1){
                                  return AlertDialog(
                                    title: Text(tr(LocaleKeys.home_noPetFound)),
                                    actions: [

                                      InkWell(
                                        child:  Text(tr(LocaleKeys.additionText_dismiss)
                                          ,style: TextStyle(
                                              fontSize: 17.0,
                                              fontFamily: AppFont.poppinsMedium
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                              }  else{
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AddJoinManagement();
                                  },
                                ));
                              }
                            }
                            if (item.type == 20) {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JoinManagement()));
                            }

                            if (item.type == 5) {
                              print("petProvider.callContactApi=${petProvider.callContactApi}");
                              if (petProvider.callContactApi == 0) {
                                petProvider.callContactApi = 1;
                                print("petProvider.callContactApi=${petProvider.callContactApi}");
                                petProvider.contactUsApiCall(context);
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pushNamed(
                                      context, AppScreen.customercare);
                                });


                              }
                            }
                            if (item.type == 6) {
                              final InAppReview inAppReview =
                                  InAppReview.instance;

                              ///android

                              inAppReview.openStoreListing(
                                  appStoreId: "6444847271");

                              ///ios
                              // Platform.isIOS ? inAppReview.requestReview():  inAppReview.openStoreListing(
                              //     appStoreId: "com.app.uniquetags");
                              //
                              // if (await inAppReview.isAvailable()) {
                              //   inAppReview.requestReview();
                              // }
                            }

                            if (item.type == 7) {
                              petProvider.updateLoader(true);
                              debounce(() {
                                petProvider.updateLoader(false);
                                if (Platform.isIOS) {
                                  Share.share(
                                      " ${AppStrings.uTgOnAppStr} \n https://apps.apple.com/us/app/unique-tags/id6444847271");
                                } else {
                                  Share.share(
                                      " ${AppStrings.uTgOnAppStr} \n https://play.google.com/store/apps/details?id=com.app.uniquetags");
                                }
                              });
                            }

                            if (item.type == 8) {
                              Myprovider myProvider =Provider.of(context,listen: false);

                              myProvider.setButtonOn = HiveHandler.isChekLostNoti();
                              print("======${myProvider.setButtonOn}");
                              // chkButtonStaus();

                              Future.delayed(const Duration(microseconds: 800),
                                  () {
                                Navigator.pushNamed(context, AppScreen.setting);
                              });
                              // Navigator.pushNamed(context, AppScreen.setting);
                            }

                            if (item.type == 9) {
                              var loginUser = HiveHandler.getUserHiveRefresher().value.values.first;

                              print("loginUser==${loginUser.phoneCode}");

                              if(loginUser.phoneCode!.isNotEmpty){
                               print("not empty=====");
                              }else{
                                print(" empty=====");
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UrlViewer(
                                            webViewType: 5,
                                          )));
                            }
                            // if (item.type == 10) {
                            //   // changeLanguage(AppLanguage);
                            //   setState(() {
                            //
                            //   });
                            //   // Navigator.push(
                            //   //     context,
                            //   //     MaterialPageRoute(
                            //   //         builder: (context) => UrlViewer(
                            //   //           webViewType: 5,
                            //   //         )));
                            // }
                          },
                          child: ListTile(
                            horizontalTitleGap: -5,
                            leading: Container(
                                height: 18,
                                width: 18,
                                child: Image(
                                  image: item.image,
                                  height: 18,
                                  width: 18,
                                )),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(item.title.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFont.poppinsRegular,
                                      color: AppColor.textLightBlueBlack)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      }),
    );
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 800),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future showPurchasePlanBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customBlueButton(
                    context: context,
                    text1: "Premimum SubScciption",
                    onTap1: () {
                      Navigator.pop(context);
                      // manageSubScripion(context, planTypeEnum.premiumPlan);
                      showPlanAccoringToProduct(context);
                    },
                    colour: Color(0xff2A3C6A)),
                SizedBox(
                  height: 20,
                ),
                customBlueButton(
                    context: context,
                    text1: "Family Plan",
                    onTap1: () {
                      manageSubScripion(context, planTypeEnum.family);
                    },
                    colour: Color(0xff2A3C6A)),
              ],
            ),
          );
        },
        context: context);
  }

  Future showPlanAccoringToProduct(BuildContext context) async {
    return showModalBottomSheet(
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customBlueButton(
                    context: context,
                    text1: "Monthly subsciption",
                    onTap1: () {
                      manageSubScripion(context, planTypeEnum.month);
                    },
                    colour: Color(0xff2A3C6A)),
                SizedBox(
                  height: 20,
                ),
                customBlueButton(
                    context: context,
                    text1: "year subcription",
                    onTap1: () {
                      manageSubScripion(context, planTypeEnum.year);
                    },
                    colour: Color(0xff2A3C6A)),
              ],
            ),
          );
        },
        context: context);
  }

  
  Future<void> chkButtonStaus() async {
    Myprovider myProvider = Provider.of(context, listen: false);
    // Provider.of(GlobalVariable.navState.currentContext!, listen: false);
    PetProvider petProvider = Provider.of(context, listen: false);

    petProvider.updateLoader(true);

    if (Platform.isAndroid) {
      var status3 = await Permission.location.status;
      print("help pet lost noti status andr=>${status3}");
      if (status3 == PermissionStatus.granted) {
        myProvider.setButtonOn = true;
        print("setButtonOn status android=>${myProvider.setButtonOn}");
      }
    }

    if (Platform.isIOS) {
      var status4 = await Geolocator.checkPermission();
      print("help pet lost noti status ios=>${status4}");
      if (status4 == LocationPermission.whileInUse ||
          status4 == LocationPermission.always) {
        myProvider.setButtonOn = true;
        print("setButtonOn status ios=>${myProvider.setButtonOn}");
      }
    }

    petProvider.updateLoader(false);
  }
}

manageSubScripion(BuildContext context, planTypeEnum type) async {
    PurChaseProvider purchaseProvider = Provider.of(context, listen: false);
    EasyLoading.show();
    await purchaseProvider.initPurchaseData().onError((error, stackTrace) {
      //  EasyLoading.dismiss();
    });
    
    if (purchaseProvider.products.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    print("type is $type");
    switch (type) {
      case planTypeEnum.month:
        for (var item in purchaseProvider.products) {
          print("my id ${monthySubscriptionAndroid} list id ${item.id} ");
          if (item.id == monthySubscriptionAndroid) {
            purchaseProvider.buy(item).onError((error, stackTrace) {
              EasyLoading.dismiss();
            }).whenComplete(() {
                // EasyLoading.dismiss();
            });
          }
        }
        break;
      case planTypeEnum.year:
     
        for (var item in purchaseProvider.products) {
           print("var item in purchaseProvider.products ${item.id}");
           print("var item in purchaseProvider.products ${yearlySubscriptionAndroid}");
           
          if (item.id == yearlySubscriptionAndroid || item.id=="popular_yearly") {
            purchaseProvider.buy(item).onError((error, stackTrace) {
              EasyLoading.dismiss();
            }).whenComplete(() {
                // EasyLoading.dismiss();
            });
          }
        }
        break;
      case planTypeEnum.family:
        for (var item in purchaseProvider.products) {
          // print("item is is ${item.id} and ${familyPlan}");
          // print("cindtion value ${item.id ==familyPlan}");
          if (item.id == familyPlan || item.id=="family_premium") {
            purchaseProvider.buy(item).onError((error, stackTrace) {
              EasyLoading.dismiss();
            }).whenComplete(() {
                // EasyLoading.dismiss();
            });
          }
        }

        break;
        case planTypeEnum.restore:
        
        default:
        // EasyLoading.dismiss();
    }
}

  // Future<void> chkButtonStaus() async {
  //   Myprovider myProvider =Provider.of(context,listen: false);
  //   // Provider.of(GlobalVariable.navState.currentContext!, listen: false);
  //   PetProvider petProvider = Provider.of(context,listen: false);
  //
  //   petProvider.updateLoader(true);
  //
  //   if (Platform.isAndroid) {
  //     var status3 = await Permission.location.status;
  //     print("help pet lost noti status andr=>${status3}");
  //     if (status3 == PermissionStatus.granted) {
  //       myProvider.setButtonOn = true;
  //       print("setButtonOn status android=>${myProvider.setButtonOn}");
  //     }
  //   }
  //
  //   if (Platform.isIOS) {
  //     var status4 = await Geolocator.checkPermission();
  //     print("help pet lost noti status ios=>${status4}");
  //     if (status4 == LocationPermission.whileInUse ||
  //         status4 == LocationPermission.always) {
  //       myProvider.setButtonOn = true;
  //       print("setButtonOn status ios=>${myProvider.setButtonOn}");
  //     }
  //   }
  //
  //   petProvider.updateLoader(false);
  // }
  // }

  Future<void> chkButtonStaus() async {
    Myprovider myProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
    // Provider.of(GlobalVariable.navState.currentContext!, listen: false);
    PetProvider petProvider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);

    petProvider.updateLoader(true);

    if (Platform.isAndroid) {
      var status3 = await Permission.location.status;
      print("help pet lost noti status andr=>${status3}");
      if (status3 == PermissionStatus.granted) {
        myProvider.setButtonOn = true;
        print("setButtonOn status android=>${myProvider.setButtonOn}");
      }
    }

    if (Platform.isIOS) {
      var status4 = await Geolocator.checkPermission();
      print("help pet lost noti status ios=>${status4}");
      if (status4 == LocationPermission.whileInUse ||
          status4 == LocationPermission.always) {
        myProvider.setButtonOn = true;
        print("setButtonOn status ios=>${myProvider.setButtonOn}");
      }
    }


  }
  

