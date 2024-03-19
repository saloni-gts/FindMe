import 'package:flutter/material.dart';

import '../util/app_font.dart';
import '../util/color.dart';

Widget customBlueButton(
    {required BuildContext context,
    required String text1,
    required VoidCallback onTap1,
    required Color colour}) {
  return Container(
    height: 60,
    width: MediaQuery.of(context).size.width * .90,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(28), color: colour),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: colour,
          onPrimary: Colors.white,
          side: BorderSide(color: Colors.white, width: 1.0),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          minimumSize: Size(100, 50), //////// HERE
        ),
        onPressed: () {
          onTap1();
        },

        child:
        // Text(
        //   text1,
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontFamily: AppFont.poppinsMedium,
        //     fontSize: 18.0,
        //   ),
        // ),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text:
              text1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
          ]),
        ),








      ),
    ),
  );
}
