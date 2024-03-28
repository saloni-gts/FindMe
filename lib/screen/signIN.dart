import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/util/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/customTextFeild.dart';
import '../components/custom_button.dart';
import '../provider/authprovider.dart';
import '../provider/petprovider.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';

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
      backgroundColor: AppColor.buttonPink,
      resizeToAvoidBottomInset: true,
      // appBar: customAppbar(isbackbutton: false),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Stack(
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.99,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.21,
                    decoration: const BoxDecoration(
                      color: AppColor.buttonPink,
                      // borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Image.asset(AppImage.topImage, fit: BoxFit.cover),
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 22, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in to FIND-ME",
                            style: TextStyle(fontFamily: AppFont.figTreeRegular, fontSize: 19, color: Colors.white70),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          _buidldBG(child: _buildBody())
        ],
      )),
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
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .45,
              child: Center(
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Or Sign With",
                        style: TextStyle(
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffDEDEDE))),
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
                color: AppColor.buttonPink,
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

  _buidldBG({required child}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Container(
        width: double.infinity,
        // height: context.height * .67,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: child,
      ),
    );
  }

  _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
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
                    fontFamily: AppFont.figTreeMedium,
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
                    fontFamily: AppFont.figTreeMedium,
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
                padding: const EdgeInsets.only(right: 0),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppScreen.forgetPass);
                    },
                    child: Text(
                      tr(LocaleKeys.loginScreen_fogetPassword),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.buttonPink,
                        fontFamily: AppFont.figTreeMedium,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomButton(
                  text: tr(LocaleKeys.loginScreen_signIn),
                  onPressed: () {
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
                  }),
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
    );
  }
}
