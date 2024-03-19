import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';


///        icon = 1 = cancel
///        icon = 2 = check

Widget GoPremList(
    {required BuildContext context,
      required String txt1,
      int icon1 = 0,
      int icon2 = 0}) {
  return   Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
    child: Container(

      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // color: Colors.tealAccent,
            width: MediaQuery.of(context).size.width*.5,
            child:

            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: txt1,
                  style: TextStyle(
                      color: AppColor.textLightBlueBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),


            // Text(
            //   txt1,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: 18.0,
            //     color: AppColor.textBlueBlack,
            //     fontFamily: AppFont.poppinsRegular,
            //   ),
            // ),





          ),

          Container(
            width: MediaQuery.of(context).size.width*.4,
            // color: Colors.teal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // width: MediaQuery.,

                  child: Icon(
                    icon1 == 2 ? Icons.cancel : Icons.check_circle,
                    color: AppColor.textLightBlueBlack,
                  ),
                ),
                Icon(
                  icon2 == 2 ? Icons.cancel : Icons.check_circle,
                  color: AppColor.textLightBlueBlack,
                ),

              ],
            ),
          ),

        ],
      ),
    ),
  );
}
