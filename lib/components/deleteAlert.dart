import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../components/customSmallBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../screen/blur_background.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/color.dart';
import '../generated/locale_keys.g.dart';

void deleteUserDialog({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => blurView(
              child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                Container(
                  height: 500,
                  width: 296,
                  // width: MediaQuery.of(context).size.width*.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 104,
                          width: 104,
                          child: Image.asset(AppImage.largedelete),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          tr(LocaleKeys.additionText_deletealert),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsBold,
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          tr(LocaleKeys.additionText_deletesub),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontFamily: AppFont.poppinsRegular,
                          ),
                        ),
                        SizedBox(height: 21),
                        customBlueButton(
                          context: context,
                          text1:  tr(LocaleKeys.additionText_Delete),
                          onTap1: () {
                            AuthProvider authProvider=Provider.of(context,listen: false);
                           authProvider.deleteAccountApi(context);
                          },
                          colour: AppColor.newBlueGrey,
                          // height: true,
                          // putheight: 48,
                          // width:236 ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customBlueButton(
                          context: context,
                          text1: tr(LocaleKeys.additionText_cancel),
                          onTap1: () {
                            Navigator.pop(context);
                          },
                          colour: AppColor.textRed,
                          //   height: true,putheight: 48,width:236
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )));
}
