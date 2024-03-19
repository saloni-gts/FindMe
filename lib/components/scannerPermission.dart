
import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';
import '../util/app_font.dart';


Future<void> scannerPermissionDialog(BuildContext context) async {
  await showDialog(
      barrierDismissible: false,
      context: context, builder: (context)=>AlertDialog(
    title: Text(tr(LocaleKeys.additionText_camPerm)
        ,style: TextStyle(
          fontFamily: AppFont.poppinsRegular,
            fontSize: 18
        )),
    actions: <Widget>[
      InkWell(
        child: Text(tr(LocaleKeys.additionText_Cancel)

          ,style: TextStyle(
              fontSize: 17.0,
              fontFamily: AppFont.poppinsMedium
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      SizedBox(
        width: 5,
      ),

      InkWell(
        child: Text(tr(LocaleKeys.additionText_allow)

          ,style: TextStyle(
              fontSize: 17.0,
              fontFamily: AppFont.poppinsMedium
          ),
        ),
        onTap: () {
          AppSettings.openAppSettings();
          Navigator.pop(context);
        },
      ),
    ],
  )
  );

}