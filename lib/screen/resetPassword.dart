import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/screen/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/appbarComp.dart';
import '../components/customBlueButton.dart';
import '../components/customTextFeild.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/appstrings.dart';
import '../util/color.dart';

class CreatePassword extends StatefulWidget {
  String emailsend;
  CreatePassword({Key? key, required this.emailsend}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  @override
  TextEditingController otpcode = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: customAppbar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    tr(LocaleKeys.additionText_createnewPassword),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: AppColor.newBlueGrey,
                      fontFamily: AppFont.poppinsBold,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      tr(LocaleKeys.additionText_chooseStrongPass),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textBlueBlack,
                        fontFamily: AppFont.poppinsLight,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  SizedBox(
                    height: 90.0,
                    width: 90.0,
                    child: Image.asset(AppImage.findMeLogo),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      tr(LocaleKeys.additionText_otpCode),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsRegular,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 7.0,
                  ),

                  CustomTextFeild(
                    textController: otpcode,
                    textInputType: TextInputType.number,
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      tr(LocaleKeys.additionText_password),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsRegular,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 7.0,
                  ),

                  CustomTextFieldWithLeading(textController: password, isPassword: true, onChanged: (v) {}),

                  const SizedBox(
                    height: 15.0,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      tr(LocaleKeys.additionText_repeatpass),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsRegular,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 7.0,
                  ),

                  CustomTextFieldWithLeading(textController: repeatPassword, isPassword: true, onChanged: (v) {}),
                  //CustomTextFeild(textController: repeatPassword),

                  const SizedBox(
                    height: 30.0,
                  ),

                  customBlueButton(
                      context: context,
                      onTap1: () {
                        if (password.text.isEmpty || repeatPassword.text.isEmpty || otpcode.text.isEmpty) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_entrCodeRepPass));
                        }
                        // if(repeatPassword.text.isEmpty){
                        //   print("enter password again...");
                        // }
                        else if (!password.text.isValidPassword() || !repeatPassword.text.isValidPassword()) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_passShouldContain));
                        } else if (password.text != repeatPassword.text) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_passRepPassNoMatch));
                        } else {
                          AuthProvider auth = Provider.of(context, listen: false);
                          auth.callChangePassword(
                              {"otp": otpcode.text.trim(), "password": password.text.trim(), "email": widget.emailsend},
                              context);
                        }
                        //  if(!password.text.trim().isValidPassword()){
                        //    print("enter valid pasword");
                        //  }
                      },
                      text1: tr(LocaleKeys.newPassword_continue),
                      colour: AppColor.newBlueGrey)
                ],
              ),
            ),
            bottomPic(context)
          ],
        ),
      ),
    );
  }
}
