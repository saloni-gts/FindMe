import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';
import '../monish/screen/buyPremium.dart';
import '../screen/viewPremium.dart';
import '../util/color.dart';
import 'customBlueButton.dart';

Future<void> commingSoonDialog(BuildContext context,
    {bool dismissable = true, String appString = "", int isFullAccess = 0}) async {
  await showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (context) => AlertDialog(
            elevation: 20,
            backgroundColor: AppColor.textFieldGrey,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                    isFullAccess == 0
                        ? tr(LocaleKeys.additionText_byPremGetAcc)
                        : tr(LocaleKeys.additionText_byPremGetFullAcc),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.poppinsRegular,
                      fontSize: 18,
                      color: AppColor.textLightBlueBlack,
                    )),
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomButton(
                  // context: context,
                  text: tr(LocaleKeys.additionText_viewPln),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ViewPremium();
                      },
                    ));
                  },
                  // colour: AppColor.newGrey
                ),
              ),
            ],
          ));
}
