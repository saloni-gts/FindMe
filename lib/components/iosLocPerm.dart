
import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


import '../generated/locale_keys.g.dart';
import '../provider/petprovider.dart';
import '../util/app_font.dart';
import '../util/color.dart';


Future<void> iosLocPermiDialog(BuildContext context) async {
  await showDialog(
      barrierDismissible: false,
      context: context, builder: (context)=>AlertDialog(
    elevation: 20,
    backgroundColor: AppColor.textFieldGrey,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    title: Text(   tr(LocaleKeys.additionText_locPopup),style: TextStyle(
        fontFamily: AppFont.poppinsRegular,
        color: AppColor.textLightBlueBlack,

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
              child: Center(
                child: Text(tr(LocaleKeys.additionText_ok)
                  ,style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: AppFont.poppinsMedium
                  ),
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                var status= await Permission.location.status;
                print("statusss=>${status}");
                print("locIocPer=>${petProvider.locIocPer}");

                if(petProvider.locIocPer==0 && (status==LocationPermission.deniedForever  || status==LocationPermission.denied) ) {
                  petProvider.locIocPer=1;
                  Position? posti = await _determineCurPosition();
                  petProvider.locIocPer=1;

                  petProvider.setLocIocPer();

                }

                petProvider.locIocPer==1? AppSettings.openAppSettings():SizedBox();


               // else if( status==LocationPermission.deniedForever  || status==LocationPermission.denied){
               //    // Position? posti = await _determineCurPosition();
               //    AppSettings.openAppSettings();
               // }

                // else{
                //   Position? posti = await _determineCurPosition();
                //   print("posti ${posti.longitude}");
                // }

                // await Permission.location.request();
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


  return await Geolocator.getCurrentPosition
    (desiredAccuracy:LocationAccuracy.low,
      // forceAndroidLocationManager: false,
      // timeLimit: Duration(seconds: 7)
  );
}