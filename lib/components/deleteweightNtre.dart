import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../generated/locale_keys.g.dart';
import '../provider/authprovider.dart';
import '../util/app_font.dart';
import '../util/appstrings.dart';

deleteWeightEntryAlert(BuildContext context) async {

  await showDialog(context: context, builder: (context)=>


      AlertDialog(

        title: Text(tr(LocaleKeys.additionText_sureWannaDelNtr)),
        actions: <Widget>[
          InkWell(
            child:  Text(tr(LocaleKeys.additionText_cancel)

              ,style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: AppFont.poppinsMedium
              ),

            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          InkWell(
            child:  Text(tr(LocaleKeys.additionText_yes)
  ,style: TextStyle(
  fontSize: 17.0,
  fontFamily: AppFont.poppinsMedium
            )),
            onTap: () {}

          )

        ],
      )

  );

}