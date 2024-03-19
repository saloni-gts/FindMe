import 'package:flutter/material.dart';

import '../util/app_font.dart';
import '../util/color.dart';

Widget customSmallBlueButton({required BuildContext context,
required String text1, required VoidCallback onTap1,required Color colour, bool isShowBorder=true}){
  return


    Container(
      height:60   ,
      width: MediaQuery.of(context).size.width*.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),

          color: colour
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colour,
            onPrimary: Colors.white,
            side:isShowBorder? BorderSide(color: Colors.white,width: 1.0):BorderSide.none,

            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0)),
            minimumSize: Size(100, 50),
          ),
          onPressed:onTap1,
          child: Text(
            text1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppFont.poppinsMedium,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );

















  //
  // Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //     child: Stack(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(28),
  //             color: colour,
  //           ),
  //           height: 60,
  //           width: MediaQuery.of(context).size.width*.50,
  //         ),
  //         Positioned(
  //           top: 5,
  //           left: 8,
  //           child: GestureDetector(
  //             child: Container(
  //               height: 50,
  //               width: MediaQuery.of(context).size.width*.45,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(28),
  //                   color: colour,
  //                   border: Border.all(
  //                     color: Colors.white,
  //                     width: 1,
  //                   )),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(top: 12.0),
  //                 child: Text(
  //                   text1,
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontFamily: AppFont.poppinsMedium,
  //                     fontSize: 18.0,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             onTap: onTap1,
  //           ),
  //         )
  //       ],
  //     ),
  //   );


}