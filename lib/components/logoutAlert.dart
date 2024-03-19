import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';


import '../generated/locale_keys.g.dart';
import '../provider/authprovider.dart';
import '../util/appstrings.dart';

logoutAlert(BuildContext context) async {

  await showDialog(context: context, builder: (context)=>


      AlertDialog(

        title: Text( tr(LocaleKeys.additionText_sureWannaLogout)),
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

          SizedBox(
            width: 5.0,
          ),

          InkWell(
            child: Text(tr(LocaleKeys.additionText_yes)

              ,style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: AppFont.poppinsMedium
              ),

            ),
            onTap: ()  async{
              AuthProvider authprovider = Provider.of(context, listen: false);
               print("object......${ConnectivityResult}");
              if( !await InternetConnectionChecker().hasConnection)
              {

              }
              else {

              print("api calling");
            await authprovider.logoutApiCall(context);
              // Navigator.pop(context);
              print("api called");
              // HiveHandler.clearUser();
              // Navigator.pushNamedAndRemoveUntil(
              //     context, AppScreen.signIn, (r) => false);
              }

            },
          )

        ],
      )

  );

}