import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/screen/dashboard.dart';
import 'package:find_me/screen/join_managment.dart';
import 'package:find_me/screen/langPikr.dart';
import 'package:find_me/screen/showallpet.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:find_me/util/app_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';




import '../api/call_api.dart';
import '../components/globalnavigatorkey.dart';
import '../monish/screen/Map.dart';
import '../provider/petprovider.dart';

int flagForNoti = 0;
int flag = 0;

final Connectivity _connectivity = Connectivity();

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppApi api = AppApi();

  @override
  void initState() {
    print("call spleash screen");
    print("call spleash screen ${Permission.camera.status}");

// PurChaseProvider purChaseProvider =Provider.of(context,listen: false);
// PetProvider petProvider =Provider.of(context,listen: false);
//   purChaseProvider.getSubScriptionDetails();
//  Future.delayed(Duration(milliseconds: 200), () {
//       if(purChaseProvider.plan.isNotEmpty){
//         petProvider.setUserPremium();
//         print("isUserPremium==${petProvider.isUserPremium}");
//       }else{
//          petProvider.isUserPremium=0;
//       }
//     });

    callApi();
    getDeviceToke();
    super.initState();
  }

  Future getDeviceToke() async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      HiveHandler.setDeviceToken(value!);
      String token = await HiveHandler.getDeviceToken();
      print("get device token after set ${token}");
    });
  }

  Future callApi() async {
    // await askPermission();
    // await checkAppVersion();
    checkLocalUser();
    fireNotificationAgain();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fireNotificationAgain() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    LocalNotifications().init();
    print(">>>>>>>>>>>?????????????<<<<<<<<<<<<<<< firebase Notification");

    // FirebaseMessaging.instance.getInitialMessage().then;{
    //   print("check getInitialMessage printing....");
    //  }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        flagForNoti = 1;

        switch (message.data["notificationType"].toString()) {
          case "1":
            int petidnoti = int.parse(message.data['referenceId'].toString());
            print("printing ref id push?==== ${petidnoti}");
            Navigator.push(
                GlobalVariable.navState.currentContext!,
                MaterialPageRoute(
                    builder: (context) => DashBoard(
                          type: 1,
                        )));
            break;
          case "2":
            int petidnoti = int.parse(message.data['referenceId'].toString());
            print("printing ref id push close==== ${petidnoti}");
            PetProvider petProv = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
            petProv.setNotificatedPetDetail(petidnoti);
            //  Navigator.push(GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context)=>Googlemap()));
            Navigator.push(
                GlobalVariable.navState.currentContext!,
                MaterialPageRoute(
                    builder: (context) => DashBoard(
                          type: 2,
                        )));
            break;
          case "3":
            Navigator.push(
                GlobalVariable.navState.currentContext!,
                MaterialPageRoute(
                  builder: (context) => JoinManagement(
                      // navigateToSecondPage: true,
                      ),
                ));
            break;
          case "4":
            Navigator.push(
              GlobalVariable.navState.currentContext!,
              MaterialPageRoute(builder: (context) => ShowAllPet()),
            );
            break;

          case "5":
            print("case1 url===>${message.data["url"].toString}");
            Navigator.push(GlobalVariable.navState.currentContext!,
                MaterialPageRoute(builder: (context) => DashBoard(type: 0, webUrl: message.data['url'].toString())));
            // MaterialPageRoute(builder: (context) => Home(webUrl: message.data["url"].toString())));
            break;
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("Listen in appppp   ${event.data}");

      var urlweb = event.data["url"];

      LocalNotifications().showNotification(
        title: event.data["title"],
        body: event.data["message"],
        payload: jsonEncode(event.data),
        // event.data["notificationType"] == "1" ? "one" : "two",
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print("Listen in appppp   ${event.data}");
      switch (event.data["notificationType"].toString()) {
        case "1":

          /// call constructor
          /// val val=COns
          /// EventDetails evntModel=EventDetails();
          //
          //   PetProvider petProvider =Provider.of(GlobalVariable.navState.currentContext!, listen: false);
          //        petProvider.setSelectedEvents(val);
          //  petProvider.setSelectedEvents(evtList[index]);
          int petidnoti = int.parse(event.data['referenceId'].toString());
          print("printing ref id pushhh==== ${petidnoti}");

          Navigator.push(
              GlobalVariable.navState.currentContext!,
              MaterialPageRoute(
                  builder: (context) => DashBoard(
                        type: 1,
                      )));
          break;
        case "2":
          int petidnoti = int.parse(event.data['referenceId'].toString());
          PetProvider petProv = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
          print("printing ref id case 2 bg push==== ${petidnoti}");
          petProv.setNotificatedPetDetail(petidnoti);
          Navigator.push(GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context) => Googlemap()));
          break;
        case "3":
          Navigator.push(
              GlobalVariable.navState.currentContext!,
              MaterialPageRoute(
                builder: (context) => JoinManagement(
                    // navigateToSecondPage: true,
                    ),
              ));
          break;
        case "4":
          Navigator.push(
            GlobalVariable.navState.currentContext!,
            MaterialPageRoute(builder: (context) => ShowAllPet()),
          );
          break;
        case "5":
          print("case2 url===>${event.data["url"].toString}");
          Navigator.push(GlobalVariable.navState.currentContext!,
              MaterialPageRoute(builder: (context) => DashBoard(type: 0, webUrl: event.data['url'].toString())));
          // MaterialPageRoute(builder: (context) => Home(webUrl: event.data['url'].toString())));

          break;
      }
    });
    Future handleNotificationSelect(Map json) async {}

    // Future handleNotificationSelect(Map json) async {
    //
    // }

    // FirebaseMessaging.onMessageOpenedApp.listen(backgroundhandleNotificationSelect);
    // FirebaseMessaging.onBackgroundMessage(backgroundhandleNotificationSelect);
  }

  // Future<bool> checkAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   AuthProvider provider = Provider.of(context, listen: false);
  //   bool isUpdated = true;
  //   Map body = {"osType": Platform.isAndroid ? 1 : 2};
  //   await api.forceUpdateApi(body).then((value) async {
  //     print("packageInfo.version ${packageInfo.version}");
  //     String name = await packageInfo.version;
  //     int appVersion = int.parse(name.replaceAll(".", ''));
  //     int versionName = int.parse(
  //         value.data['appVersion'].toString().replaceAll(".", '') ?? "0");
  //     if (appVersion < versionName) {
  //       provider.updateDispose(value.data['isForced'] != 1);
  //       isUpdated = false;
  //     } else {
  //       isUpdated = true;
  //     }
  //   });
  //   return true;
  // }
  //
  // Future<bool> initConnectivity() async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   print("result while call fun ${result}");
  //   if (result == false) {
  //     Future.delayed(Duration(seconds: 1), () {
  //
  //       print("Looks like you are not connected to the internet");
  //       showToast("Internet Not Connected!!!");
  //       // EasyLoading.showToast(tr(LocaleKeys.showToast_netNotConn
  //       //   showToast("Looks like you are not connected to the internet");
  //
  //     });
  //   }
  //   else{
  //     print("INTERNET CONNECTED!!!!!");
  //   }
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar:BotttomBorder(context),
      backgroundColor: Colors.white,
      // appBar: customAppbar(
      //   isbackbutton: false,
      // ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: Image.asset(
             "assets/images/splash.png",
            // "assets/images/image_splash.png",
            // "assets/images/imagesplash1.5.png",
          ))),
    );
  }

  Future<void> checkLocalUser() async {
    print(" 1 ");
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (flagForNoti == 1) {
      } else {
        var usrData = HiveHandler.getUser();
        bool isSelected = await HiveHandler.isLanguageSelected();

        print("GET USER DATA");

        if (usrData != null) {
          print("USER NAME ${usrData.name}");
          print("USER EMAIL ${usrData.email}");
          print("USER PASSWORD ${usrData.password}");

          // PurChaseProvider purChaseProvider =Provider.of(context,listen: false);
          // PetProvider petProvider =Provider.of(context,listen: false);
          // purChaseProvider.getSubScriptionDetails();
          // Future.delayed(Duration(milliseconds: 200), () {
          //   if(purChaseProvider.plan.isNotEmpty){
          //     petProvider.setUserPremium();
          //     print("isUserPremium==${petProvider.isUserPremium}");
          //   }else{
          //     petProvider.isUserPremium=0;
          //   }
          // });

          Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
        } else {
          print("is Language selected ${isSelected}");
          if (!isSelected) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LangPicker(
                    isFromStart: true,
                  ),
                ),
                (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
          }
        }
      }
    });
  }

  Future<void> askPermission() async {
    try {
      var Status1 = await Permission.camera.status;
      var Status2 = await Permission.photos.status;
      print("Status1${Status1}");

      if (!Status1.isGranted) {
        print("Status1${Status1}");
        await Permission.camera.request();
      }

      if (!Status2.isGranted) {
        print("Status2${Status2}");
        await Permission.photos.request();
      }
    } on PlatformException catch (e) {
      print("erroer===>>> ${e}");
    }
  }

  // Future<void> initConnectivity() async{
  //   print("call initConnectivity ");
  //   try {
  //     _connectivity.onConnectivityChanged.listen((event) {
  //
  //      if(event==ConnectivityResult.mobile) {
  //        print("Internet  Connected  ethernet!!!");
  //      }
  //
  //         else if(event==ConnectivityResult.wifi) {
  //         print("Internet  Connected  wifi!!!");
  //       }
  //      else if (event == ConnectivityResult.none) {
  //        print("Internet Not Connected!!!");
  //     //  showToast('Internet Not Connected!!!');
  //        // await CoolAlert.show(context: context, type: CoolAlertType.warning, text: 'Internet Not Connected!!!!',
  //        //    autoCloseDuration: Duration(seconds: 2),);
  //      }
  //
  //
  //      else {
  //         // print("Internet  Connected!!!");
  //       }
  //     });
  //   } on PlatformException catch (e) {
  //     return;
  //   }
  // }

  // showToast(String message) {
  //   if (message.isNotEmpty) {
  //     EasyLoading.showToast(message);
  //   }
  // }
}

class LocalNotifications {
  static final _notification = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('playstore');
  final IOSInitializationSettings initializationSettingsIOS = const IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  late InitializationSettings initializationSettings;
  Future init() async {
    initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);
    _notification.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(id, title, body, await _notificationDetails(), payload: payload);
  }

  Future<void> selectNotification(var pay) async {
    print("Notificationsssssss>>>>>>");
    print("NOTIFICATION json$pay");
    var json = jsonDecode(pay);

    print("NOTIFICATION======$json");
    print("${['notificationType']}");

    var Weburl = json["url"];

    switch (json["notificationType"].toString()) {
      case "1":

        /// call constructor
        /// val val=COns
        /// EventDetails evntModel=EventDetails();
        //
        //   PetProvider petProvider =Provider.of(GlobalVariable.navState.currentContext!, listen: false);
        //        petProvider.setSelectedEvents(val);
        //  petProvider.setSelectedEvents(evtList[index]);
        int petidnoti = int.parse(json['referenceId'].toString());
        print("printing ref id ==== ${petidnoti}");

        //Navigator.pushNamed(GlobalVariable.navState.currentContext!, AppScreen.newevent);
        Navigator.push(
            GlobalVariable.navState.currentContext!,
            MaterialPageRoute(
                builder: (context) => DashBoard(
                      type: 1,
                    )));
        // Navigator.push(GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context)=>DeleteEvent(idEvent: petidnoti,petIdEvent: petidnoti)));
        break;
      case "2":
        int petidnoti = int.parse(json['referenceId'].toString());
        print("printing ref id kill ==== ${petidnoti}");
        PetProvider petProv = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
        petProv.setNotificatedPetDetail(petidnoti);
        Navigator.push(GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context) => Googlemap()));
        break;
      case "3":
        Navigator.push(
            GlobalVariable.navState.currentContext!,
            MaterialPageRoute(
              builder: (context) => JoinManagement(
                  // navigateToSecondPage: true,
                  ),
            ));
        break;
      case "4":
        Navigator.push(
          GlobalVariable.navState.currentContext!,
          MaterialPageRoute(builder: (context) => ShowAllPet()),
        );
        break;

      case "5":
        print("case 3 url===>${json["url"].toString}");
        Navigator.push(
            GlobalVariable.navState.currentContext!,
            // MaterialPageRoute(builder: (context) => Home(webUrl: json["url"].toString(),)),
            MaterialPageRoute(builder: (context) => DashBoard(type: 0, webUrl: json["url"].toString())));
        break;

      //  Navigator.pushNamed(GlobalVariable.navState.currentContext!, AppScreen.googlemap);
    }
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          channelShowBadge: true,
          // icon: "assets/images/app_icons.png",
        ),
        iOS: IOSNotificationDetails(presentBadge: true, presentSound: true, presentAlert: true));
  }

  // void openWeb(String weburl) async{
  //
  //   if (Platform.isIOS) {
  //     print("/---------/");
  //
  //
  //     if (await canLaunchUrlString(weburl)) {
  //   await launchUrlString(weburl,
  //   mode: LaunchMode.externalApplication);
  //   }
  //   } else if (Platform.isAndroid) {
  //
  //   if (await canLaunch(weburl)) {
  //   await launch(
  //     weburl,
  //   );
  //   }
  //   }
  //
  //
  // }
}

Future<void> initConnectivity() async {
  print("call initConnectivity ");
  Future.delayed(Duration(seconds: 6), () {
    try {
      _connectivity.onConnectivityChanged.listen((event) {
        print("CHECK STATUS ${event}");
        if (event == ConnectivityResult.none) {
          // ConnectivityResult.
          print("Internet Not Connected!!!!");
          if (flag == 0) {
            flag = 1;
          } else {
            EasyLoading.showToast(tr(LocaleKeys.additionText_internetError),
                toastPosition: EasyLoadingToastPosition.bottom);
            // Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
          }

          // AlertHandler.showWarning(Glo, "Internet Not Connected!!");
        } else {
          // print("Internet  Connected!!!");
          // EasyLoading.showToast("Internet Connected.");
        }
      });
    } on PlatformException {
      return;
    }
  });
}

// try {
//   _connectivity.onConnectivityChanged.listen((event) {
//     if (event == ConnectivityResult.mobile) {
//       print("Internet  Connected  mobile !!!");
//     } else if (event == ConnectivityResult.wifi) {
//       print("Internet  Connected  wifi!!!");
//     }
//     // else
//     else if (event == ConnectivityResult.ethernet) {
//       print("Internet  Connected!!!");
//       //  showToast('Internet Not Connected!!!');
//       // await CoolAlert.show(context: context, type: CoolAlertType.warning, text: 'Internet Not Connected!!!!',
//       //    autoCloseDuration: Duration(seconds: 2),);
//     } else if(event == ConnectivityResult.none){
//
//     }
//
//     else {
//       print("Internet  not Connected!!!");
//     }
//   });
// } on PlatformException catch (e) {
//   return;
// }
