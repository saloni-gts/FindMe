import 'package:flutter/material.dart';

import '../../util/app_font.dart';

Widget mycustomBlueButton({
  required BuildContext context,
  final width,
  final putheight,
  bool height = true,
  required String text1,
  required VoidCallback onTap1,
  required Color colour,
  bool border1 = true,
}) {
  return Container(
    height: height ? 60 : putheight,
    width: height ? MediaQuery.of(context).size.width * .90 : width,
    decoration:
    BoxDecoration(borderRadius: BorderRadius.circular(28), color: colour),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: colour,
          onPrimary: Colors.white,
          side: border1 ? BorderSide(color: Colors.white, width: 1.0) : null,
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          minimumSize: Size(100, 50), //////// HERE
        ),
        onPressed: () {
          onTap1();
        },
        // onPressed:onTap1,
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
}