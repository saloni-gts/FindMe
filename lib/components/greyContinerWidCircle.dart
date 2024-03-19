
import 'package:flutter/material.dart';

import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';

Widget GreyContainerWidCircle({required BuildContext context, required String text1, required String image1,required VoidCallback onTap1}){
  return
    GestureDetector(onTap:() {
      onTap1();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.textFieldGrey,
            borderRadius: BorderRadius.circular(4)),
        height: 96,
        width: MediaQuery.of(context).size.width*.45,


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 8.0),
              child: Container(
                  height:45 ,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),
                  child: Image.asset(image1)),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Text(
               text1,
                maxLines: 2,
                overflow:TextOverflow.ellipsis ,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontFamily: AppFont.poppinsMedium),
              ),
            ),
          ],
        ),

      ),
    );

}