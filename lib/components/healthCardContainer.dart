import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/models/healthCardModel.dart';
import 'package:flutter/material.dart';


import '../generated/locale_keys.g.dart';
import '../util/app_font.dart';
import '../util/color.dart';

Widget HealthCardContainer(BuildContext context,HealthCard helthCardData){

  return  Container(
    decoration: BoxDecoration(
      color: AppColor.textFieldGrey,
      borderRadius: BorderRadius.circular(36),
    ),
    height: 80,
    width: MediaQuery.of(context).size.width * .95,


    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 5.0,left: 25),
          child: Text(
            helthCardData?.Vaccination??"",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 15.0,
                color: AppColor.textLightBlueBlack,
                fontFamily: AppFont.poppinsMedium),
          ),
        ),

        SizedBox(height: 2.0,)
        ,
        Padding(
          padding: const EdgeInsets.only(left: 25.0,right: 5),
          child: Text(  //additionText_treatments     additionText_allergies
            "${tr(LocaleKeys.additionText_allergies)}: ${helthCardData.Allergies}\n${tr(LocaleKeys.additionText_treatments)}: ${helthCardData.Treatments}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 10.0,
                color: AppColor.textGreyColor,
                fontFamily: AppFont.poppinsRegular),
          ),
        ),



      ],
    ),

  );

}