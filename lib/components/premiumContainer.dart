import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/petprovider.dart';

Widget PremiumContainer(BuildContext context,String txt1,){
  return Consumer<PetProvider>(
    builder: (context,petProvider,child) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(

            border: Border.all(color: petProvider.isShowPremiumBorder==1?AppColor.textLightBlueBlack:Colors.transparent),

              color: AppColor.textFieldGrey,
              borderRadius: BorderRadius.circular(4)),
          height: 80,
          // width: MediaQuery.of(context).size.width*.25,
          child:  Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                txt1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontFamily: AppFont.poppinsMedium,
                ),
              ),
            ),
          ),
        ),
      );
    }
  );

}