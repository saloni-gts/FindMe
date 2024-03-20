import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/cntryyPikrrComp.dart';
import '../components/customTextFeild.dart';
import '../provider/authprovider.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'addPet.dart';
import 'changePassword.dart';
import 'enterNameForm.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late AuthProvider authProvider;
  TextEditingController emailllController = TextEditingController();
  TextEditingController passwordddController = TextEditingController();

  @override
  void initState() {
    authProvider = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotttomBorder(context),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: customAppbar(isbackbutton: false),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    tr(LocaleKeys.loginScreen_hi),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: AppColor.newBlueGrey,
                      fontFamily: AppFont.poppinsBold,
                    ),
                  ),
                  Text(
                    "${tr(LocaleKeys.loginScreen_headline1)}FIND-ME",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: AppColor.textBlueBlack,
                      fontFamily: AppFont.poppinsLight,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 90.0,
                    width: 90.0,
                    child: Image.asset(AppImage.findMeLogo),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tr(LocaleKeys.loginScreen_email),
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
                  CustomTextFeild(
                    textController: emailllController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tr(LocaleKeys.loginScreen_password),
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
                  CustomTextFieldWithLeading(
                    textController: passwordddController,
                    onChanged: (v) {},
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppScreen.forgetPass);
                        },
                        child: Text(
                          tr(LocaleKeys.loginScreen_fogetPassword),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsRegular,
                          ),
                        ),

                        //onTap: cngPasswordDialog(context: context),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  customBlueButton(
                      context: context,
                      text1: tr(LocaleKeys.loginScreen_signIn),
                      onTap1: () {
                        PetProvider petProvider = Provider.of(context, listen: false);
                        petProvider.petDetailList.clear();

                        if (emailllController.text.isEmpty || passwordddController.text.isEmpty) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_entrEmailPass));
                        } else if (!emailllController.text.trim().isValidEmail()) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_entrValidEmail));
                        } else {
                          authProvider.callLoginApi({
                            "email": emailllController.text.trim(),
                            "password": passwordddController.text.trim(),
                          }, context);
                        }
                      },
                      colour: AppColor.newBlueGrey),
                  const SizedBox(
                    height: 20.0,
                  ),
                  signwithSocialMedia(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(AppImage.fbIcon, () {
                        authProvider.facebookLogin(context);
                      }),
                      _socialIcon(AppImage.googleIcon, () {
                        authProvider.googleLogin(context);
                      }),
                      Platform.isIOS
                          ? _socialIcon(AppImage.appleIcon, () {
                              authProvider.appleLogin(context);
                            })
                          : const SizedBox()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  newUserCreateProfileTexr(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signwithSocialMedia() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 1,
            width: double.infinity,
            color: AppColor.textLightBlueBlack,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .45,
              child: Center(
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: tr(LocaleKeys.loginScreen_socialAccountSignIn),
                        style: const TextStyle(
                          color: AppColor.textLightBlueBlack,
                          fontSize: 12,
                          fontFamily: AppFont.poppinsRegular,
                        ),
                      ),
                    ])),
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: 1,
            width: double.infinity,
            color: AppColor.textLightBlueBlack,
          ))
        ],
      ),
    );
  }

  _socialIcon(String icon, VoidCallback onTap) {
    return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Container(
              decoration: BoxDecoration(color: AppColor.textFieldGrey, borderRadius: BorderRadius.circular(28)),
              height: 56,
              width: 104,
              child: Image.asset(icon)),
        ));
  }

  // socialIconsContainers() {

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,

  //     children: [
  //       Container(
  //         height: 60,
  //         width: 100,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(28.0),
  //             color: AppColor.textFieldGrey,
  //             border: Border.all(color: Colors.transparent)
  //         ),

  //         child: GestureDetector(
  //           onTap: (){

  //           },
  //           child: Container(
  //             height: 25,
  //             width: 25,
  //             child: Image.asset(AppImage.fbIcon),
  //           ),
  //         ),
  //       ),

  //       SizedBox(
  //         width: 8.0,
  //       ),

  //       Container(
  //         height: 60,
  //         width: 100,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(28.0),
  //             color: AppColor.textFieldGrey,
  //             border: Border.all(color: Colors.transparent)
  //         ),

  //         child: GestureDetector(
  //           onTap: (){},
  //           child: Container(
  //             height: 25,
  //             width: 25,
  //             child: Image.asset(AppImage.googleIcon),
  //           ),
  //         ),
  //       ),

  //       SizedBox(
  //         width: 8.0,
  //       ),
  //       Container(
  //         height: 60,
  //         width: 100,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(28.0),
  //             color: AppColor.textFieldGrey,
  //             border: Border.all(color: Colors.transparent)
  //         ),

  //         child: GestureDetector(
  //           onTap: (){},
  //           child: Container(
  //             height: 25,
  //             width: 25,
  //             child: Image.asset(AppImage.appleIcon),
  //           ),
  //         ),
  //       ),

  //       SizedBox(
  //         width: 8.0,
  //       ),

  //     ],

  //   );

  // }

  newUserCreateProfileTexr() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: tr(LocaleKeys.loginScreen_newUsers),
              style: const TextStyle(
                color: AppColor.newBlueGrey,
                fontSize: 14,
                fontFamily: AppFont.poppinsRegular,
              ))
        ])),

        // Text(
        //   tr(LocaleKeys.loginScreen_newUsers)+" ",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 14.0,
        //     color: AppColor.textLightBlueBlack,
        //     fontFamily: AppFont.poppinsRegular,
        //   ),
        // ),

        GestureDetector(
          child: RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: " ${tr(LocaleKeys.loginScreen_createProfile).toUpperCase()}",
              style: const TextStyle(
                color: AppColor.newBlueGrey,
                fontSize: 14,
                fontFamily: AppFont.poppinsMedium,
              ),
              // recognizer: TapGestureRecognizer()
              //   ..onTap = () {
              //     Navigator.pushNamedAndRemoveUntil(
              //         context, AppScreen.signUpScreen, (r) => false);
              //   }
            )
          ])),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
          },
        ),
      ],
    );
  }
}
