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
    Future.delayed(const Duration(seconds: 4)).then((value) async {
      AuthProvider auth = Provider.of(context, listen: false);
      print("auth.usrName===${auth.usrName}");
      if (auth.usrName == "" || auth.usrNameEmpty == 1) {
        Navigator.pushNamedAndRemoveUntil(context, AppScreen.enterName, (r) => false);
      } else {
        String str = auth.usrName ?? "";
        var str2 = str.trim();
        HiveHandler.updateUserName(str2);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, AppScreen.enterName, (r) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BotttomBorder(context),
      backgroundColor: AppColor.buttonPink,
      resizeToAvoidBottomInset: false,
      // appBar: customAppbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150.0,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(AppImage.successLottie),
              ),
              const SizedBox(
                height: 70.0,
              ),
              const Text(
                "Account Created",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: AppFont.figTreeBold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Your account has been successfully created. You can now log in by clicking the button below.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: AppFont.poppinsRegular,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoard(
                                type: 0,
                                webUrl: "",
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Login Now",
                    style: TextStyle(fontSize: 16, color: AppColor.buttonPink, fontFamily: AppFont.figTreeBold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
