import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customBlueButton.dart';
import '../components/customSmallBlueButton.dart';
import '../components/customTextFeild.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'blur_background.dart';

void cngPasswordDialog({required BuildContext context}) {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) => blurView(
              child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: double.infinity,
                //  width: MediaQuery.of(context).size.width*.95,
                decoration: const BoxDecoration(color: AppColor.newGrey),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      // width: MediaQuery.of(context).size.width*.95,
                      decoration: BoxDecoration(
                        color: AppColor.newGrey,
                        borderRadius: BorderRadius.circular(8),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     //     offset: Offset(0, 3),
                        //   ),
                        // ]
                      ),

                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                      AppImage.closeIcon,
                                      //height: 152,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // SizedBox(
                            //   height: 5.0,
                            // ),

                            SizedBox(
                              height: 125,
                              child: Image.asset(
                                AppImage.lockIcon,
                                color: AppColor.newBlueGrey,
                              ),
                            ),

                            Text(
                              tr(LocaleKeys.additionText_chanePassword),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: AppColor.newBlueGrey,
                                fontFamily: AppFont.poppinsBold,
                              ),
                            ),

                            // Text(
                            //   AppStrings.lovToHearFeedbk,
                            //   textAlign: TextAlign.left,
                            //   style: TextStyle(
                            //     fontSize: 14.0,
                            //     color: Colors.black,
                            //     fontFamily: AppFont.poppinsMedium,
                            //   ),
                            // ),

                            const SizedBox(
                              height: 10.0,
                            ),

                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      tr(LocaleKeys.additionText_oldPass),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomTextFieldWithLeading(
                                  textController: oldPassController, isPassword: true, onChanged: (v) {}),
                            ),

                            const SizedBox(
                              height: 10.0,
                            ),

                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      tr(LocaleKeys.additionText_newPass),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomTextFieldWithLeading(
                                  textController: newPassController, isPassword: true, onChanged: (v) {}),
                            ),

                            // customBlueButton(context: context,colour: AppColor.textLightBlueBlack,text1: "SUBMIT",onTap1: (){})

                            const SizedBox(
                              height: 20.0,
                            ),

                            customSmallBlueButton(
                                context: context,
                                onTap1: () {
                                  if (oldPassController.text.isEmpty || newPassController.text.isEmpty) {
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        text: tr(LocaleKeys.additionText_entrBothPass));
                                  } else if (!newPassController.text.isValidPassword()) {
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        text: tr(LocaleKeys.additionText_passShouldContain));
                                  } else {
                                    AuthProvider auth = Provider.of(context, listen: false);
                                    auth.resetPasswordApi(
                                        {"oldPassword": oldPassController.text, "newPassword": newPassController.text},
                                        context);
                                  }
                                },
                                text1: tr(LocaleKeys.additionText_confirm),
                                colour: AppColor.newBlueGrey),

                            const SizedBox(
                              height: 20.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )));
}
