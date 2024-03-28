import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../api/call_api.dart';
import '../components/cntryyPikrrComp.dart';
import '../components/customTextFeild.dart';
import '../generated/locale_keys.g.dart';
import '../provider/authprovider.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/app_route.dart';
import '../util/color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late AuthProvider authProvider;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        // appBar: customAppbar(
        //   isbackbutton: false,
        // ),
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
                      Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr(LocaleKeys.signUp_createAccount),
                                style:
                                    const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 22, color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr(LocaleKeys.additionText_entrYrRegData),
                                style: const TextStyle(
                                    fontFamily: AppFont.figTreeRegular, fontSize: 19, color: Colors.white70),
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
          ),
        ));
  }

  _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 15.0),

                const SizedBox(
                  height: 27.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tr(LocaleKeys.additionText_email),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.figTreeMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextFeild(
                  textController: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tr(LocaleKeys.signUp_mobileNumber),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.figTreeMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CntrePikr(phoneNumController: phoneController),
                const SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      tr(LocaleKeys.signUp_password),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.figTreeMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextFieldWithLeading(
                  textController: passwordController,
                  onChanged: (v) {},
                  isPassword: true,
                ),
                const SizedBox(
                  height: 30.0,
                ),

                CustomButton(
                  text: tr(LocaleKeys.signUp_createAccount),
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      if (emailController.text.isEmpty) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_enterEmail));
                      } else if (phoneController.text.isEmpty) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_enterMobile));
                      } else if (passwordController.text.isEmpty) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_passwordError));
                      } else if (emailController.text.isEmpty &&
                          phoneController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_entrAllFeilds));
                      }

                      // else if(){
                      //
                      // }
                    } else if (!emailController.text.trim().isValidEmail()) {
                      CoolAlert.show(context: context, type: CoolAlertType.warning, text: "Invalid Email Address");
                    } else if (!phoneController.text.ismobile(phoneController.text)) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_entrValidMobNum));
                    } else if (!passwordController.text.isValidPassword()) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_passShouldContain));
                    } else {
                      authProvider.normalLogin({
                        "phoneCode": authProvider.phncode1,
                        "mobileNumber": phoneController.text.trim(),
                        "email": emailController.text,
                        "password": passwordController.text,
                        "countryCode": authProvider.cntrycode1
                      }, context);
                      emailController.clear();
                      phoneController.clear();
                      passwordController.clear();
                    }
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                _linktoWebsiteText(context),
                const SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr(LocaleKeys.signUp_alreadyHaveAcc),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColor.newBlueGrey,
                            fontSize: 14,
                            fontFamily: AppFont.poppinsRegular,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppScreen.signIn);
                          },
                          child: Text(
                            " ${tr(LocaleKeys.signUp_signIn)}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColor.buttonPink,
                              fontSize: 14,
                              fontFamily: AppFont.poppinsRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: tr(LocaleKeys.signUp_termsHint),
                            style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        TextSpan(
                            text: tr(LocaleKeys.signUp_privacyPolicy),
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColor.buttonPink,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UrlViewer(
                                              webViewType: 1,
                                            )));
                              }),
                        TextSpan(
                            text: tr(LocaleKeys.signUp_terms),
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColor.buttonPink,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UrlViewer(
                                              webViewType: 2,
                                            )));
                              }),
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
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
        margin: const EdgeInsets.only(top: 10),
        // height: context.height * .67,
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
}

bottomPic(BuildContext context) {
  return Positioned(
    bottom: 2.0,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 40),
      child: Container(
        // width: MediaQuery.of(context).size.width * .9,
        // color: const Color(0xffCBC4A9),
        // height: 15,
        child: Image.asset(AppImage.dogsGroup),
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage(
        //     AppImage.topBorder,
        //   ),
        //   fit: BoxFit.fill,
        // )),
        // child: Image.asset(
        //   AppImage.topBorder,
        //   fit: BoxFit.cover,
        // ),
      ),
    ),
  );
}

_linktoWebsiteText(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: SizedBox(
      // width: MediaQuery.of(context).size.width * .90,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.black,
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .60,
                    child: Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: tr(LocaleKeys.signUp_socialAccount),
                              style: const TextStyle(
                                color: AppColor.textBlueBlack,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFont.poppinsRegular,
                              ),
                            ),
                          ])),
                    ),
                  )

                  // Text(
                  //   tr(LocaleKeys.signUp_socialAccount),
                  //   maxLines: 2,
                  //   overflow:TextOverflow.ellipsis ,
                  //   // maxLines: 2,
                  //   style:
                  //   TextStyle(fontFamily: AppFont.poppinsRegular, fontSize: 14),
                  // ),

                  ),
              Expanded(
                  child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.black,
              ))
            ],
          ),
        ],
      ),
    ),
  );
}

_socialIcon(String icon, VoidCallback onTap) {
  return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xffDEDEDE)),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 56,
            width: 92,
            child: Image.asset(icon)),
      ));
}

final Uri privacypolicy = Uri.parse('http://3.92.109.164/unique-tags/privacy-policy.html');
Future<void> _launchUrl(url) async {
  if (!await launch("http://3.92.109.164/unique-tags/privacy-policy.html")) {
    throw 'Could not launch $privacypolicy';
  }
}

class UrlViewer extends StatefulWidget {
  int webViewType;
  UrlViewer({Key? key, this.webViewType = 0}) : super(key: key);

  @override
  State<UrlViewer> createState() => _UrlViewerState();
}

class _UrlViewerState extends State<UrlViewer> {
  String url = "";
  var loadingPercentage = 0;

  // bool isLoad=false;
  @override
  void initState() {
    if (widget.webViewType == 1) {
      url = ApiUrl.privacyPloicyPAGE;
    } else if (widget.webViewType == 2) {
      url = ApiUrl.termsPAGE;
    } else if (widget.webViewType == 3) {
      url = ApiUrl.aboutUSPAGE;
    } else if (widget.webViewType == 4) {
      url = ApiUrl.faqPAGE;
    } else if (widget.webViewType == 5) {
      url = ApiUrl.howItWorks;
    } else if (widget.webViewType == 6) {
      url = ApiUrl.visitWbsite;
    }
    super.initState();
  }
// setLoader(bool isval){
//
//      setState(() {
//         isLoad=isval;
//      });
//
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomCurvedAppbar(),
        body:
            // isLoad?Center(child: CircularProgressIndicator(),):
            Stack(
          children: [
            WebView(
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  loadingPercentage = 100;
                });
              },

              backgroundColor: Colors.white,

              initialUrl: url,
//         onWebViewCreated: (v){
//   try{
//             setLoader(true);
//            print("DATA2 $isLoad");
//            }catch(e){
// //  setLoader(false);
//            print("DATA2 $isLoad");
//            }finally{
//              setLoader(false);
//   print("DATA2 $isLoad");
//            }
//         },
//         onPageFinished: (v){
//            try{
//             setLoader(false);
//            print("DATA2 $isLoad");
//            }
//            catch(e){
//  setLoader(false);
//            print("DATA2 $isLoad");
//            }
//            finally{
//              setLoader(false);
//   print("DATA2 $isLoad");
//            }
//         },
              javascriptMode: JavascriptMode.unrestricted,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ));
  }
}
