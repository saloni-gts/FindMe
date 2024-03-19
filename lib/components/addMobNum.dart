import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';


import '../generated/locale_keys.g.dart';
import '../monish/screen/ownerProfile.dart';
import '../util/appstrings.dart';



addPhoneNumberDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(tr(LocaleKeys.additionText_adNum2adPet)),
            actions: <Widget>[
              InkWell(
                child: Text(tr(LocaleKeys.additionText_cancel)

                  ,style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: AppFont.poppinsMedium
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(width: 5,),

              InkWell(
                child:  Text(tr(LocaleKeys.additionText_add)
                  ,style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: AppFont.poppinsMedium
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OwnerProfile()));
                },
              )
            ],
          ));
}
