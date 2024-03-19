import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/petprovider.dart';

Widget SheildListPetInfo({ required String txt1, required int isCheck,  required VoidCallback onTap1,}){
  return Consumer<PetProvider>(
    builder: (context,petProvider,child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
        child: Row(
            children: [

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: txt1,
                    style: TextStyle(
                        color: AppColor.textLightBlueBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ),


              // Text(
              //   txt1,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: AppColor.textLightBlueBlack,
              //     fontFamily: AppFont.poppinsMedium,
              //     fontSize: 12.0,
              //   ),
              // ),
              new Spacer(),

              InkWell(
                // splashColor: Colors.transparent,
                onTap: (){
                  isCheck==0? onTap1() :SizedBox();
                },
                child: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                        isCheck==0? AppImage.containerArrow: AppImage.greenCheckIcon)),
              )
            ]),
      );
    }
  );


}