import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/screen/petProfile.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';
import '../monish/screen/buyPremium.dart';
import '../util/color.dart';
import 'customBlueButton.dart';

Future<void> makePetPremDialog(BuildContext context,
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
                Text(tr(LocaleKeys.additionText_premFrPet),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.poppinsRegular,
                      fontSize: 18,
                      color: AppColor.textLightBlueBlack,
                    )),
              ],
            ),
            actions: <Widget>[
              CustomButton(
                // context: context,
                text: tr(LocaleKeys.additionText_ActivateNow),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const PetProfile();
                    },
                  ));
                },
                // colour: AppColor.newGrey
              ),
            ],
          ));
}
