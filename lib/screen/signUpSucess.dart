import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/screen/dashboard.dart';
import 'package:find_me/util/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


import '../components/bottomBorderComp.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/app_route.dart';
import '../util/color.dart';

class SignUpSuccessPage extends StatefulWidget {
  const SignUpSuccessPage({Key? key}) : super(key: key);

  @override
  State<SignUpSuccessPage> createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  @override
  void initState() {
    callAndNavigate();
    super.initState();
  }

  Future<void> callAndNavigate() async {
    Future.delayed(Duration(seconds: 4)).then((value) async {
AuthProvider auth=Provider.of(context,listen: false);
     print("auth.usrName===${auth.usrName}");
      if(auth.usrName=="" || auth.usrNameEmpty==1){
        Navigator.pushNamedAndRemoveUntil(
            context, AppScreen.enterName, (r) => false);
      }else {
        String str=auth.usrName??"";
        var str2=str.trim();
        HiveHandler.updateUserName(str2);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, AppScreen.enterName, (r) => false);

        Navigator.push( context,MaterialPageRoute(builder: (context)=>DashBoard(type: 0,webUrl: "",)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BotttomBorder(context),

      resizeToAvoidBottomInset: false,
      appBar: customAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 200,
              width: 200,
              child: Lottie.asset(AppImage.successLottie),
            ),
            SizedBox(
              height: 70.0,
            ),
            Text(
              tr(LocaleKeys.successSignUp_success),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 36.0,
                color: AppColor.textRed,
                fontFamily: AppFont.poppinsBold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${tr(LocaleKeys.additionText_welcome)}"+AppStrings.welUTag,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: AppFont.poppinsRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
