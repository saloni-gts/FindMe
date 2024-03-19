
import 'package:flutter/material.dart';

import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';



Widget GreyContainer({required BuildContext context, required String text1, required String image1,required VoidCallback onTap1}){
  return
    GestureDetector(onTap:() {
      onTap1();

    },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.textFieldGrey,
            borderRadius: BorderRadius.circular(4)),
        height: 101,
        width: MediaQuery.of(context).size.width*.45,


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height:45 ,
                child: Image.asset(image1)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Text(
                text1,
                overflow:TextOverflow.ellipsis ,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: AppFont.poppinsMedium),
              ),
            ),
          ],
        ),

      ),
    );

}