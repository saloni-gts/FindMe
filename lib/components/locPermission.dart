
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../generated/locale_keys.g.dart';
import '../provider/petprovider.dart';
import '../util/app_font.dart';
import 'globalnavigatorkey.dart';

Future<void> locPermissionDialog(BuildContext context) async {
  await showDialog(
      barrierDismissible: false,
      context: context, builder: (context)=>AlertDialog(

    title: Text( tr(LocaleKeys.additionText_locPopup)
       ,style: TextStyle(
        fontFamily: AppFont.poppinsRegular,
        fontSize: 18
    )),
    actions: <Widget>[
      // InkWell(
      //   child: Text("Cancel"
      //
      //     ,style: TextStyle(
      //         fontSize: 17.0,
      //         fontFamily: AppFont.poppinsMedium
      //     ),
      //   ),
      //   onTap: () {
      //     Navigator.pop(context);
      //   },
      // ),
      // SizedBox(width: 5,),

      Consumer<PetProvider>(
        builder: (context,petProvider,child) {
          return InkWell(
            child: Text(tr(LocaleKeys.additionText_ok)
              ,style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: AppFont.poppinsMedium
              ),
            ),
            onTap: () async {
              Navigator.pop(context);




              //   Position? posti = await _determineCurPosition();
              // }

              petProvider.updateLoader(true);
              if(petProvider.locControler==0){

              await Permission.location.request();
              petProvider.incrementLocControler();
              }else{
                AppSettings.openAppSettings();
              }
              var status3 = await Permission.location.status;
              petProvider.updateLoader(false);
              print("location status===>>${status3}");
              // if(status3.isGranted) {
              //   petProvider.updateLoader(true);
              //   Position? posti = await _determineCurPosition();
              //   petProvider.updateLoader(false);
              //
              //   petProvider.lati = posti.latitude;
              //   petProvider.longi = posti.longitude;
              //
              //   if (petProvider
              //       .selectedPetDetail
              //       ?.isLost == 1) {
              //     petProvider.petMarkAsLostP2(
              //         context: context);
              //   } else {
              //     showDialog(
              //         context: context,
              //         builder: (context) =>
              //             AlertDialog(
              //               title: Text(tr(
              //                   LocaleKeys
              //                       .additionText_uSurePetLost)),
              //               actions: <
              //                   Widget>[
              //                 InkWell(
              //                   child: Text(
              //                     tr(
              //                         LocaleKeys
              //                             .additionText_cancel),
              //                     style: TextStyle(
              //                         fontSize: 17.0,
              //                         fontFamily: AppFont
              //                             .poppinsMedium),
              //                   ),
              //                   onTap: () {
              //                     Navigator
              //                         .pop(
              //                         context);
              //                   },
              //                 ),
              //
              //                 SizedBox(width: 5),
              //
              //                 InkWell(
              //                   child: Text(
              //                     tr(LocaleKeys.additionText_yes),
              //                     style: TextStyle(
              //                         fontSize: 17.0,
              //                         fontFamily: AppFont
              //                             .poppinsMedium),
              //                   ),
              //                   onTap: () async {
              //                     Navigator
              //                         .pop(
              //                         context);
              //                     await petProvider
              //                         .petMarkAsLostP2(
              //                         context: GlobalVariable
              //                             .navState
              //                             .currentContext!);
              //
              //                     petProvider.calleditProfileP2Api(context: context);
              //
              //
              //                   },
              //                 )
              //               ],
              //             ));
              //   }
              //
              // }else{
              //
              // }
              // AppSettings.openAppSettings();
              // Navigator.pop(context);

              },

          );
        }
      ),
    ],
  )
  );

}


Future<Position> _determineCurPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {

    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }


  return await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.low ,forceAndroidLocationManager: false,
      // timeLimit: Duration(seconds: 7)
  );
}