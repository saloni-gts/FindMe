// import 'package:flutter/material.dart';
// import 'package:unique_tags/screen/home.dart';
// import 'package:unique_tags/util/color.dart';
// import '../util/app_images.dart';
// import '../util/appstrings.dart';
// import 'LogoutPage.dart';
// import 'calenderPage.dart';
//
// class Newnav extends StatefulWidget {
//  const Newnav({ Key? key}) : super(key: key);
//
//
//
//   @override
//   _NewnavState createState() => _NewnavState();
// }
//
// class _NewnavState extends State<Newnav> with TickerProviderStateMixin {
//   final PageStorageBucket bucket = PageStorageBucket();
//   late TabController tabController;
//   final List<Widget> mainScreens = [
//     Home(),
//     CalenderPage(),
//     LogoutPage()
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(initialIndex: 0, length: 3, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: PageStorage(
//           child: TabBarView(
//             controller: tabController,
//             physics: NeverScrollableScrollPhysics(),
//             children: mainScreens,
//           ),
//           bucket: bucket,
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Material(
//           color: Colors.white,
//           elevation: 10,
//           child: BottomAppBar(
//             notchMargin: 8,
//             //shape: CircularNotchedRectangle(),
//             child: TabBar(
//               tabs: [
//                 Tab(
//                     icon: ImageIcon(
//                       AssetImage(
//                           AppImage.homeIcon,
//                       ),
//                     ),
//                     text: AppStrings.home),
//                 Tab(
//                   icon: ImageIcon(
//                     AssetImage(
//                       AppImage.petcareIcon,
//                     ),
//                   ),
//                   text: AppStrings.petCare,
//                 ),
//                 Tab(
//                   icon: ImageIcon(
//                     AssetImage(
//                       AppImage.moreIcon,
//                     ),
//                   ),
//                   text: AppStrings.more,
//                 ),
//
//
//
//               ],
//               labelStyle: TextStyle(fontSize: 10),
//               labelColor:AppColor.textLightBlueBlack ,
//               unselectedLabelColor: Colors.grey,
//               isScrollable: false,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicatorPadding: EdgeInsets.all(5.0),
//               indicatorColor: AppColor.textLightBlueBlack,
//               controller: tabController,
//               indicator: UnderlineTabIndicator(
//                 insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 75.0),
//                 borderSide:
//                 BorderSide(color:AppColor.textLightBlueBlack, width: 3),
//               ),
//             ),
//           ),
//         ),
//       ),
//       // floatingActionButton: Material(
//       //   elevation: 10,
//       //   color: Theme.of(context).primaryColor,
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.all(Radius.circular(36)),
//       //   ),
//       //   child: InkWell(
//       //     customBorder: RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.all(Radius.circular(36)),
//       //     ),
//       //     onTap: () => tabController.animateTo(2),
//       //     child: Container(
//       //       width: 65,
//       //       height: 65,
//       //       padding: EdgeInsets.all(8),
//       //       child: Column(
//       //         crossAxisAlignment: CrossAxisAlignment.center,
//       //         mainAxisAlignment: MainAxisAlignment.center,
//       //         children: <Widget>[
//       //           Image.asset(
//       //             'assets/bottombar/qr.png',
//       //             height: 25,
//       //             fit: BoxFit.cover,
//       //             color: Theme.of(context).accentColor,
//       //           ),
//       //         ],
//       //       ),
//       //     ),
//       //   ),
//       // ),
//       //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      // drawer: Drawer(),
//     );
//   }
// }