import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../components/customSmallBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../generated/locale_keys.g.dart';
import '../../screen/blur_background.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/color.dart';

void rateDialog({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => blurView(
              child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 328,
                  // width: MediaQuery.of(context).size.width*.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        SizedBox(
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

                        Container(
                          height: 128,
                          width: 110,
                          child: Image.asset(AppImage.dogImage),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr(LocaleKeys.moreFeatures_rateUs),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsBold,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          tr(LocaleKeys.additionText_feedBack),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontFamily: AppFont.poppinsMedium,
                          ),
                        ),

                        SizedBox(height: 24.03),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i <= 4; i++)
                                Container(
                                    width: 32,
                                    height: 27.97,
                                    child: Image.asset(AppImage.dogfit)),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 31,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                   tr(LocaleKeys.additionText_comment),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinsRegular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                height: 56,
                                width: 296,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        customSmallBlueButton(
                            context: context,
                            onTap1: () {},
                            text1: tr(LocaleKeys.additionText_confirm),
                            colour: AppColor.textLightBlueBlack),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )));
}
