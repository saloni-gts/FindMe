import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customSmallBlueButton.dart';
import 'package:find_me/screen/changePassword.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';


import '../components/bottomBorderComp.dart';
import '../generated/locale_keys.g.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/app_route.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(isbackbutton: true),
       // bottomNavigationBar:BotttomBorder(context),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55,vertical: 15),
        child: customSmallBlueButton(context: context,
         text1: tr(LocaleKeys.moreFeatures_logout), onTap1: ()
            {
          HiveHandler.clearUser();
        Navigator.pushNamedAndRemoveUntil(
            context, AppScreen.signIn, (r) => false);
         }, colour: AppColor.buttonRedColor,isShowBorder: false),
      ),
      // appBar: customAppbar(titlename: "Settings"),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 20.0),
          child: Container(
            height: MediaQuery.of(context).size.height*.30,
            width:MediaQuery.of(context).size.width*.9,
            color: AppColor.textFieldGrey,
            child:
            Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(children: [
              SizedBox(height:15.0),


              InkWell(onTap: (){
                cngPasswordDialog(context: context);
              },
                child: Row(
                  children: [
                Image.asset(AppImage.change_icon),
                  SizedBox(
                    width: 15,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(tr(LocaleKeys.additionText_chngYrPass),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinsRegular,
                  ),
                  ),
                )
                  ],
                ),
              )
             ],
            ),
          )
          ,),
        )
       ],
      )
        // Stack(
        //   children: [
        //     Column(
        //       // mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //   //       Center(
        //   //         child: customSmallBlueButton(context: context,
        //   //          text1: AppStrings.logout, onTap1: (){
        //   //           HiveHandler.clearUser();
        //   //         Navigator.pushNamedAndRemoveUntil(
        //   // context, AppScreen.signIn, (r) => false);
        //   //          }, colour: AppColor.buttonRedColor,isShowBorder: false),
        //   //       ),
        //         // SizedBox(height: 50.0,),
        //       ],
        //     ),
        //     Positioned(
        //       bottom: 20.0,
        //       child: Container(
        //         child: Image.asset(AppImage.topBorder),
        //         decoration: BoxDecoration(
        //             image: DecorationImage(
        //               image: AssetImage(
        //                 AppImage.topBorder,
        //               ),
        //               fit: BoxFit.fill,
        //             )),
        //       ),
        //     ),
            
        //   ],
        // )

    );
  }
}
