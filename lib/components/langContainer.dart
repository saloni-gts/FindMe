import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';

import '../util/app_font.dart';

Widget LangContainer(BuildContext context, String weight, String text1) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 140,
      // width: MediaQuery.of(context).size.width * .92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffDCE0F1)),
        // color: AppColor.textFieldGrey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 45.0,
              width: 45.0,
              child: Image.asset(
                weight,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            text1,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10.0, color: Colors.black, fontFamily: AppFont.poppinsMedium),
          ),
          // const Spacer(),
          // Padding(
          //   padding: const EdgeInsets.only(right: 18.0),
          //   child: InkWell(onTap: () {}, child: Image.asset(AppImage.nextArrow)),
          // ),
        ],
      ),
    ),
  );
}
