import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/util/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/customTextFeild.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';

enum SelectColor { red, yellow, blue, green, orange }

class EnterNameForm extends StatefulWidget {
  const EnterNameForm({Key? key}) : super(key: key);

  @override
  State<EnterNameForm> createState() => _EnterNameFormState();
}

class _EnterNameFormState extends State<EnterNameForm> {
  TextEditingController nameeController = TextEditingController();

  @override
  void initState() {
    AuthProvider auth = Provider.of(context, listen: false);

    if (auth.usrName != "") {
      nameeController.text = auth.usrName ?? "";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width * .99,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: BotttomBorder(context),
            )),
        // bottomNavigationBar:
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,
        appBar: CustomCurvedAppbar(
          showBackIcon: false,
          isTitleCenter: true,

          title: "Enter Your Name",
          // isbackbutton: false,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                // height: 200,
                // color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Column(children: [

                    // Text(
                    //   tr(LocaleKeys.additionText_enterName),
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(
                    //     fontSize: 22.0,
                    //     color: AppColor.textRed,
                    //     fontFamily: AppFont.poppinsBold,),),

                    // Align(alignment: Alignment.bottomLeft,
                    //   child: Text(
                    //     tr(LocaleKeys.additionText_name),
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //       fontSize: 12.0,
                    //       color: AppColor.textLightBlueBlack,
                    //       fontFamily: AppFont.poppinsRegular,),),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),

                    Image.asset(AppImage.entrNameImg),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Tell us a bit about yourself.",
                      style: TextStyle(color: Color(0xff2A2A2A), fontSize: 18, fontFamily: AppFont.poppinsMedium),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColor.textLightBlueBlack,
                          fontFamily: AppFont.figTreeMedium,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),

                    CustomTextFeild(textController: nameeController),

                    const SizedBox(
                      height: 50,
                    ),

                    SizedBox(
                      height: 220,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomButton(
                              text: tr(LocaleKeys.newPassword_continue),
                              onPressed: () {
                                if (nameeController.text.trim().isEmpty) {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      text: tr(LocaleKeys.additionText_entrName));
                                } else {
                                  AuthProvider auth1 = Provider.of(context, listen: false);
                                  auth1.updateNameApi({"name": nameeController.text.trim()}, context);
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppScreen.dashboard);
                            },
                            child: const Text(
                              "I'll Do Later",
                              style: TextStyle(
                                  color: AppColor.buttonPink, fontSize: 14, fontFamily: AppFont.poppinSemibold),
                            ),
                          ),

                          const SizedBox(
                            height: 25.0,
                          ),
                          // BotttomBorder(context),
                        ],
                      ),
                    ),
                    // ],),

                    // Column(

                    //   children: [

                    // customBlueButton(context: context,text1: AppStrings.contenue, onTap1: (){
                    //   if(nameeController.text.isEmpty){
                    //     CoolAlert.show(context: context, type: CoolAlertType.warning,text: "Enter Name");
                    //   }else{
                    //     AuthProvider auth1 =Provider.of(context,listen: false);
                    //     auth1.updateNameApi({"name":nameeController.text},context);
                    //   }
                    // }, colour: AppColor.textLightBlueBlack),
                    // SizedBox(
                    //   height: 20.0,
                    // ),

                    // customBlueButton(context: context,text1:AppStrings.skip, onTap1: (){
                    //   Navigator.pushNamed(context, AppScreen.dashboard);
                    // }, colour: AppColor.textRed)
                    // ,
                    // SizedBox(
                    //   height: 25.0,
                    // ),

                    // DropdownButton<SelectColor>(
                    //
                    //     items: SelectColor.map((String SelectColor){
                    //       return DropdownMenuItem(child: Text(SelectColor),
                    //       );
                    //     })
                    //
                    //     , onChanged: (String SelectColor){
                    //       setState
                    // }

                    //   ],
                    // )

                    //
                    // customBlueButton(context: context,text1: AppStrings.contenue, onTap1: (){
                    //   if(nameeController.text.isEmpty){
                    //     CoolAlert.show(context: context, type: CoolAlertType.warning,text: "Enter Name");
                    //   }else{
                    //     AuthProvider auth1 =Provider.of(context,listen: false);
                    //     auth1.updateNameApi({"name":nameeController.text},context);
                    //   }
                    // }, colour: AppColor.textLightBlueBlack),
                    //   SizedBox(
                    //     height: 20.0,
                    //   ),
                    //
                    // customBlueButton(context: context,text1:AppStrings.skip, onTap1: (){
                    //   Navigator.pushNamed(context, AppScreen.dashboard);
                    // }, colour: AppColor.textRed)
                    // ,
                    // SizedBox(
                    //   height: 25.0,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
