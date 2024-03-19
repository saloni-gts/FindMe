import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/monish/models/Locationlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';



import '../../generated/locale_keys.g.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/color.dart';

Widget upcommingListContainer(
    BuildContext context, LocationListDetails locdata) {


  return Container(


    child: Padding(
      padding:
          const EdgeInsets.only(left: 5.0, top: 5, right: 7.0, bottom: 10.0),
      child: Container(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   dateConverter(locdata.createdDate ?? ""),
                //
                //   style: const TextStyle(
                //       color: AppColor.textLightBlueBlack,
                //       fontSize: 15,
                //       fontFamily: AppFont.poppinSemibold),
                //
                // ),


                Row(
                  children: [
                    Text("",
                      // dateeeeConverter(locdata.createdDate ??
                      //     ""),

                      style: const TextStyle(
                          color: AppColor.textLightBlueBlack,
                          fontSize: 15,
                          fontFamily: AppFont.poppinSemibold),
                    ),

                    Text(
                     // "${dateConverter2(DateTime.fromMillisecondsSinceEpoch(int.parse(locdata.createdDate??"0"),isUtc: true))}",

                         "${dateConverterreal(int.parse(locdata.createdDateTimestamp ?? "0"))}"
                      "${timeConverter(int.parse(locdata.createdDateTimestamp ??"0"))}",
                      // "${locdata.createdDate??"0"}",
                      // dateeeeConverter(dateConverter(DateTime.fromMillisecondsSinceEpoch(1671703684).toString())),

                      style: const TextStyle(
                          color: AppColor.textLightBlueBlack,
                          fontSize: 15,
                          fontFamily: AppFont.poppinSemibold),
                    ),

                    SizedBox(
                      width: 4,
                    ),
                     // Text(locdata.createdDate??"",
                     //  style: const TextStyle(
                     //      color: AppColor.textLightBlueBlack,
                     //      fontSize: 15,
                     //      fontFamily: AppFont.poppinSemibold),
                     // ),
                       // Text(
                    //    ectractTime(locdata.createdDate ?? ""),
                    //   style: const TextStyle(
                    //       color: AppColor.textLightBlueBlack,
                    //       fontSize: 15,
                    //       fontFamily: AppFont.poppinSemibold),
                    // ),

                    SizedBox(
                      width: 4,
                    ),

                    Text(
                      "",
                      style: const TextStyle(
                          color: AppColor.textLightBlueBlack,
                          fontSize: 15,
                          fontFamily: AppFont.poppinSemibold),
                    ),

                    Text("",
                      // dateeeegetConverter(locdata.createdDate ?? ""),
                      style: const TextStyle(
                          color: AppColor.textLightBlueBlack,
                          fontSize: 15,
                          fontFamily: AppFont.poppinSemibold),
                    ),
                  ],
                ),





                Text(

                //  'Geolocation: ${locdata.latitude.toString()}/${locdata.longitude.toString()}',
                  '${tr(LocaleKeys.additionText_geoloc)}: ${double.parse(locdata.latitude??"").toStringAsFixed(6)}/${double.parse(locdata.longitude??"").toStringAsFixed(6)}',
                  style: const TextStyle(
                      color: AppColor.textGreyColor,
                      fontSize: 10,
                      fontFamily: AppFont.poppinsRegular),

                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


String dateConverterreal(int date) {
  print("initial date d======${date}");
  var d = DateTime.fromMillisecondsSinceEpoch(date);
print("date d======${d}");
print("date d final======${Jiffy(d).format("dd MMM yyyy ")}");
  return "${Jiffy(d).format("dd MMM yyyy ")}".toUpperCase();

}


// String dateConverter(String date) {
//   print("date printing ${date}");
//   DateTime now = DateTime.now();
//   String datte = Jiffy(date).format("d MMM,yyyy HH:MM a");
// print("printing = ${datte}");
//
//   return datte;
//
// }

// String dateeeeConverter(String date) {
// print("api date==== ${date}");
//   DateTime datie=DateTime.parse(date.toString());
//  datie= datie.add(Duration(hours: 5,minutes: 30));
//   print("datie===== ${datie}");
//
//   print("date printing ${date}");
//   DateTime now = DateTime.now();
//   String datte = Jiffy(datie).format("d MMM,yyyy");
// print("printing = ${datte}");
//
//   return datte;
//
// }

// String dateeeegetConverter(String date) {
//   DateTime datie=DateTime.parse(date.toString());
//   datie= datie.add(Duration(hours: 5,minutes: 30));
//   print("datie===== ${datie}");
//
//  // print("date printing ${date}");
//   DateTime now = DateTime.now();
//   String datte = Jiffy(datie).format("a");
// print("printing = ${datte}");
//
//   return datte;
//
// }

//
// String ectractTime(String str){
//   DateTime datie=DateTime.parse(str.toString());
//   datie= datie.add(Duration(hours: 5,minutes: 30));
//   print("datie===== ${datie}");
//
//   String str2=datie.toString();
//   var v1=str2.split(" ");
//   var t1=v1[1];
//   var s5=t1.substring(0,5);
//   print("printing final time=== ${s5}");
//   return s5;
// }


String timeConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  print("again printing .. ${d}");
  print("again printing hrs.. ${d.hour}");
  print("again printing mins.. ${d.minute}");

  return "${Jiffy(d).format("HH:mm a")}".toUpperCase();
}

