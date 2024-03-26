import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/customTextFeild.dart';
import '../components/custom_button.dart';
import '../components/custom_curved_appbar.dart';
import '../provider/authprovider.dart';
import '../util/app_images.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emaillController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BotttomBorder(context),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomCurvedAppbar(
          title: "Forget Password",
          isTitleCenter: true,
        ),
        // customAppbar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  // Text(
                  //   tr(LocaleKeys.additionText_forgotPassword),
                  //   textAlign: TextAlign.left,
                  //   style: const TextStyle(
                  //     fontSize: 22.0,
                  //     color: AppColor.textRed,
                  //     fontFamily: AppFont.poppinsBold,
                  //   ),
                  // ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    // height: 90.0,
                    // width: 90.0,
                    child: Image.asset(
                      AppImage.pinkLock,
                      // fit: BoxFit.fitHeight,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      tr(LocaleKeys.additionText_enterEmailReset),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: AppColor.textBlueBlack,
                        fontFamily: AppFont.figTreeMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tr(LocaleKeys.additionText_email),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsRegular,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CustomTextFeild(textController: emaillController, textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 35,
                  ),

                  CustomButton(
                    onPressed: () {
                      if (emaillController.text.isEmpty) {
                        CoolAlert.show(
                            context: context, type: CoolAlertType.warning, text: tr(LocaleKeys.additionText_entrEmail));
                        print("enter email....");
                      } else if (!emaillController.text.trim().isValidEmail()) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_invalidEmain));
                      } else {
                        AuthProvider authProvider = Provider.of(context, listen: false);
                        authProvider.updateForgotPassword(
                            {"email": emaillController.text.trim()}, context, emaillController.text.trim());
                      }
                    },
                    text: tr(LocaleKeys.forgotPassword_submit),
                  ),
                  // customBlueButton(
                  //     context: context,
                  //     onTap1: () {
                  //       if (emaillController.text.isEmpty) {
                  //         CoolAlert.show(
                  //             context: context,
                  //             type: CoolAlertType.warning,
                  //             text: tr(LocaleKeys.additionText_entrEmail));
                  //         print("enter email....");
                  //       } else if (!emaillController.text.trim().isValidEmail()) {
                  //         CoolAlert.show(
                  //             context: context,
                  //             type: CoolAlertType.warning,
                  //             text: tr(LocaleKeys.additionText_invalidEmain));
                  //       } else {
                  //         AuthProvider authProvider = Provider.of(context, listen: false);
                  //         authProvider.updateForgotPassword(
                  //             {"email": emaillController.text.trim()}, context, emaillController.text.trim());
                  //       }
                  //     },
                  //     text1: tr(LocaleKeys.forgotPassword_submit),
                  //     colour: AppColor.newBlueGrey)
                ],
              ),
            ),
          ),
        ));
  }
}
