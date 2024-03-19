import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';


import '../util/app_font.dart';

Widget LangContainer(BuildContext context,String weight,String text1){
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Container(
      height: 60,
      width: MediaQuery.of(context).size.width * .92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColor.textFieldGrey,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
                height:25.0,
                width: 25.0,
                child: Image.asset(weight)),
          ),

          SizedBox(
            width: 15.0,
          ),

          Text(
            text1,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 10.0,
                color: Colors.black,
                fontFamily: AppFont.poppinsMedium),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
                onTap: (){},
                child: Image.asset(AppImage.nextArrow)),
          ),

        ],
      ),
    ),
  );
}