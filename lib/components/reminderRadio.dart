import 'package:find_me/api/staus_enum.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget RemindTimeCont({required BuildContext context, required String Rname, required RemindTime remindTime}) {
  PetProvider petProvider = Provider.of(context, listen: false);
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: SizedBox(
      // color: Colors.amber,
      height: 30,
      child: Row(
        children: [
          Text(
            Rname,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 12.0,
              color: AppColor.textLightBlueBlack,
              fontFamily: AppFont.poppinsRegular,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Radio(
                activeColor: AppColor.newBlueGrey,
                toggleable: true,
                value: remindTime,
                groupValue: petProvider.reTime,
                onChanged: (value) {
                  petProvider.setReTime(remindTime);
                  petProvider.setRemindVal(value.toString());

                  print("value===$value"); //selected value
                }),
          ),
        ],
      ),
    ),
  );
}
