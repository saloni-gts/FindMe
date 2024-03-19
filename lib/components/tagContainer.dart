import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/models/tagDetailModel.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';


import '../generated/locale_keys.g.dart';

Widget TagContainer(BuildContext context,TagDetails tagData) {
  return Container(
    decoration: BoxDecoration(
      // color: AppColor.textLightBlueBlack,
      color: AppColor.textFieldGrey,

      borderRadius: BorderRadius.circular(36),
    ),
    height: 60,
    width: MediaQuery.of(context).size.width * .85,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image(image: AssetImage(AppImage.tagIcon)),
          ),

          SizedBox(
            width: 10.0,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              SizedBox(
                height: 10.0,
              ),

              Text(
                // "T5822",
                tagData.qrTagNumber??"",
                // tagData.qrActivationCode??"",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: AppFont.poppinsRegular),
              ),
              Text(
                "${tr(LocaleKeys.additionText_addedOn)} : ${dateConverter(int.parse(tagData?.updateDate??""))}",
                // "Added on : 26/12/22",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 10.0,
                    color: AppColor.textGreyColor,
                    fontFamily: AppFont.poppinsRegular),
              ),
            ],
          ),

          new Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image(image: AssetImage(AppImage.nextArrow)),
          ),


        ],
      ),
    ),
  );
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return "${Jiffy(d).format("dd/MM/yy ")}".toUpperCase();
}
