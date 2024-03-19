import 'package:find_me/api/staus_enum.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget RadioContainer({required BuildContext context,required String Rname,required Repeat repeeet}){
  PetProvider petProvider=Provider.of(context,listen: false);
  return  Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Container(
      // color: Colors.amber,
      height: 30,
      child: Row(
        children: [
          Text(

            Rname,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12.0,
              color:
              AppColor.textLightBlueBlack,
              fontFamily:
              AppFont.poppinsRegular,
            ),
          ),
          new Spacer(),
          Padding(
            padding: const EdgeInsets.only(
                right: 0.0),
            child: Radio(
                activeColor:
                AppColor.textLightBlueBlack,
                toggleable: true,
                value: repeeet,
                groupValue: petProvider.repeat,
                onChanged: (value) {
                  petProvider.setRepeat(repeeet);
                  petProvider.setValue(value.toString());
                  print("======${value}"); //selected value
                }),
          ),
        ],
      ),
    ),
  );
}