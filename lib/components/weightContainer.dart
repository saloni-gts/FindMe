import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';

import '../util/app_font.dart';

Widget WeightContainer(BuildContext context, String weight, String text1) {
  return Container(
    height: 90,
    width: MediaQuery.of(context).size.width * .43,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: const Color(0xffF8EBED),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          weight,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 22.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
        ),
        Text(
          text1,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 10.0, color: Colors.black, fontFamily: AppFont.poppinsMedium),
        ),
      ],
    ),
  );
}
