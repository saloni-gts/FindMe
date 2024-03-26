// import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';
// import 'package:unique_tags/components/appbarComp.dart';
// import 'package:unique_tags/provider/authprovider.dart';
// import 'package:unique_tags/provider/petprovider.dart';
// import 'package:unique_tags/screen/home.dart';
// import 'package:unique_tags/util/app_font.dart';
// import 'package:unique_tags/util/app_images.dart';
// import 'package:unique_tags/util/appstrings.dart';
// import 'package:unique_tags/util/color.dart';
//
// import '../services/hive_handler.dart';
// import 'LogoutPage.dart';
// import 'addPet.dart';
// import 'calenderPage.dart';
//
// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);
//
//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     Home(),
//     CalenderPage(),
//     LogoutPage()
//   ];
//
//   var loginUser = HiveHandler.getUser();
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//
//     });
//   }
//
//   @override
//   void initState() {
//     PetProvider petProvider = Provider.of(context,listen: false);
//     petProvider.getAllPet();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset:false,
//       backgroundColor: Colors.white,
//       appBar: customAppbar(isbackbutton: false),
//
//
//
//       bottomNavigationBar: BottomNavigationBar(
//
//         unselectedIconTheme: IconThemeData(
//           color: Colors.grey
//         ),
//        // unSelectedColor:Colors.grey,
//         //selectedColor: AppColor.textLightBlueBlack,
//         selectedItemColor: AppColor.textLightBlueBlack,
//        unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//         currentIndex: _selectedIndex,
//         // Navigator.push(context, MaterialPageRoute(builder: (context)=>LogoutPage()));
//
//         items: [
//           BottomNavigationBarItem(
//
//             icon: InkWell(
//               child: Image.asset(AppImage.homeIcon,color: Colors.grey,),
//             ),
//             activeIcon: Image.asset(AppImage.homeIcon),
//             label: AppStrings.home,
//           ),
//           BottomNavigationBarItem(
//               icon: Image.asset(AppImage.petcareIcon,color: Colors.grey),
//               activeIcon: Image.asset(AppImage.petcareIcon),
//               label: AppStrings.petCare,
//               backgroundColor: AppColor.textFieldGrey),
//           BottomNavigationBarItem(
//             icon: Image.asset(AppImage.moreIcon,color: Colors.grey),
//             activeIcon: Image.asset(AppImage.moreIcon),
//             label: AppStrings.more,
//             backgroundColor: AppColor.textFieldGrey,
//           )
//         ],
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: true,
//
//         showUnselectedLabels: true,
//        // selectedItemColor: AppColor.textBlueBlack,
//         unselectedLabelStyle: TextStyle(
//           color: AppColor.textFieldGrey,
//           fontSize: 12.0,
//           fontFamily: AppFont.poppinSemibold,
//         ),
//         selectedLabelStyle: TextStyle(
//           color: AppColor.textLightBlueBlack,
//           fontSize: 12.0,
//           fontFamily: AppFont.poppinSemibold,
//         ),
//       ),
//
//       body: _widgetOptions.elementAt(_selectedIndex),
//
//
//     );
//
//   }
// }

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/screen/home.dart';
import 'package:find_me/screen/splashScreen.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../api/call_api.dart';
import '../components/globalnavigatorkey.dart';
import '../monish/screen/Map.dart';
import '../monish/screen/careDiaryNewEvent.dart';
import '../monish/screen/morrefeature39.dart';
import '../provider/authprovider.dart';
import '../provider/petprovider.dart';
import '../provider/purchase_provider.dart';
import '../util/app_images.dart';

class DashBoard extends StatefulWidget {
  int type;
  String webUrl;
  DashBoard({Key? key, this.type = 0, this.webUrl = ""}) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  final PageStorageBucket bucket = PageStorageBucket();
  late TabController tabController;
  late AuthProvider auth;
  AppApi api = AppApi();
  late PurChaseProvider purchaseProvider;
  final List<Widget> mainScreens = [
    const Home(),
    EventCalender(isShowBackIcon: false, isBottomBorder: false, isFromPet: false),
    // CalenderPage(),
    //   LogoutPage()
    const MoreFeature()
  ];

  @override
  void initState() {
    purchaseProvider = Provider.of(context, listen: false);
    purchaseProvider.getSubScriptionDetails();
    purchaseProvider.isFromInit(true);
    purchaseProvider.initPurchaseData();
    getinAppPurchaseDetails();

    print("call init state");
    if (widget.type == 2) {
      Navigator.push(
          GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context) => const Googlemap()));
    }

    PetProvider petProvider = Provider.of(context, listen: false);

    print("widget.webUrlwidget.webUrl=> ${widget.webUrl}");
    if (widget.webUrl.isNotEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        openWeb(widget.webUrl.toString());
      });
    }

    petProvider.getAllPet();
    initConnectivity();
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    auth = Provider.of(context, listen: false);
    AuthProvider.callUpdateDeviceFunction(context);
  }

  Future getinAppPurchaseDetails() async {
    await purchaseProvider.getSubScriptionDetails().then((value) async {
      print("purchaseProvider.plan.isNotEmpty ${purchaseProvider.planList.isNotEmpty}");
      if (purchaseProvider.planList.isNotEmpty) {
        bool isNenewd = false;
        bool isExpire = false;
        isExpire = purchaseProvider.planList[0].isExpire == 1;
        isNenewd = purchaseProvider.planList[0].isRenewed == 1;

        print("getting information isExpire $isExpire isNenewd $isNenewd");
        if (isExpire && isNenewd) {
          int osType = purchaseProvider.planList[0].osType ?? 1;
          await api.updateSubscription(
              planId: purchaseProvider.planList[0].planId ?? 0,
              receiptData: purchaseProvider.planList[0].receiptInfo ?? "",
              isRenewd: true,
              osType: osType);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    if (widget.type == 1) {
      tabController.animateTo(1);
    }
    print('working or not');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: UpgradeAlert(
        upgrader: Upgrader(
            shouldPopScope: () => auth.isDispose,
            showIgnore: true,
            showLater: true,
            onUpdate: () {
              print("work on not");
              // Future.delayed(D)
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  print("set state done");
                });
              });

              return true;
            },
            canDismissDialog: auth.isDispose,
            durationUntilAlertAgain: const Duration(seconds: 2),
            dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material),
        child: SafeArea(
          bottom: true,
          top: true,
          child: PageStorage(
            bucket: bucket,
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: mainScreens,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        elevation: 0,
        child: BottomAppBar(
          // height: 80,
          // notchMargin: 8,
          //shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TabBar(
              tabs: [
                Tab(
                    icon: Image.asset(
                      AppImage.homeIcon,
                      height: 40,
                    ),
                    // const ImageIcon(
                    //   AssetImage(AppImage.homeDash
                    //       // tabController.index == 1 ?
                    //       // "assets/images/t_home_icon.png",
                    //       ),
                    // ),
                    text: tr(LocaleKeys.home_homeText)),
                Tab(
                  icon: Image.asset(
                    AppImage.small_Cal,
                    height: 35,
                  ),
                  // const ImageIcon(
                  //   AssetImage(
                  //     AppImage.newCal,
                  //   ),
                  // ),
                  text: tr(LocaleKeys.home_petCare),
                ),
                Tab(
                  icon: Image.asset(
                    AppImage.setting1,
                    height: 40,
                  ),
                  //  const ImageIcon(
                  //   AssetImage(
                  //       // AppImage.moreIcon,
                  //       AppImage.moreDash),
                  // ),
                  text: tr(LocaleKeys.home_more),
                ),
              ],
              labelStyle: const TextStyle(fontSize: 10),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              labelColor: AppColor.textLightBlueBlack,

              unselectedLabelColor: Colors.grey,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.all(5.0),
              // indicatorColor: AppColor.textLightBlueBlack,
              controller: tabController,
              indicator: const UnderlineTabIndicator(
                insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 65.0),
                borderSide: BorderSide(color: AppColor.textRed, width: 3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void openWeb(String weburl) async {
  if (Platform.isIOS) {
    print("/---------/");

    if (await canLaunchUrlString(weburl)) {
      await launchUrlString(weburl, mode: LaunchMode.externalApplication);
    }
  } else if (Platform.isAndroid) {
    if (await canLaunch(weburl)) {
      await launch(
        weburl,
      );
    }
  }
}
