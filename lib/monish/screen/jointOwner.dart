import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/locale_keys.g.dart';
import '../../provider/petprovider.dart';
import '../../util/app_font.dart';
import '../../util/color.dart';

class JointOwner extends StatefulWidget {
  const JointOwner({Key? key}) : super(key: key);

  @override
  State<JointOwner> createState() => _JointOwnerState();
}

class _JointOwnerState extends State<JointOwner> {
  TextEditingController joNameController = new TextEditingController();
  TextEditingController joEmailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: customBlueButton(
            context: context,
            text1: tr(LocaleKeys.additionText_sndReq),
            onTap1: () {
              PetProvider petProvider = Provider.of(context, listen: false);

              if (joNameController.text.isEmpty ||
                  joEmailController.text.isEmpty) {
                if (joEmailController.text.isEmpty) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text: tr(LocaleKeys.additionText_enterEmail));
                } else if (joNameController.text.isEmpty) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text: "Please enter name");
                } else if (joNameController.text.isEmpty &&
                    joEmailController.text.isEmpty) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text: tr(LocaleKeys.additionText_entrAllFeilds));
                }
              } else if (!joEmailController.text.trim().isValidEmail()) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    text: tr(LocaleKeys.additionText_entrValidEmail));
              } else {
                petProvider.callRequestManagement(
                  context: context,
                  email: joEmailController.text,
                  name: joNameController.text,
                );
              }
            },
            colour: AppColor.buttonRedColor),
      ),
      appBar: customAppbar(
          isbackbutton: true, titlename: tr(LocaleKeys.additionText_jntOnr)),
      backgroundColor: Colors.white,
      bottomNavigationBar: BotttomBorder(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Text(
                tr(LocaleKeys.additionText_jntOnr),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinSemibold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                tr(LocaleKeys.additionText_name),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinsRegular),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomTextFeild(
                  hintText: "Jacob Ramirez",
                  textController: joNameController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: 15.0,
              ),
              Text(
                tr(LocaleKeys.additionText_email),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinsRegular),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomTextFeild(
                  hintText: "jacobramirez@mail.com",
                  textController: joEmailController,
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
