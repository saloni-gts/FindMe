import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


import '../generated/locale_keys.g.dart';
import '../models/documentdetailmodel.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'dateTimeStamp.dart';

Widget DocumentCategoryContainer(
    BuildContext context, DocumentDetails docdata) {
  return //
      Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.textFieldGrey,
          borderRadius: BorderRadius.circular(36),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width * .88,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColor.textFieldGrey),
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child:
                    CachedNetworkImage(
                      imageUrl: docdata.petPhoto??"",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          AppImage.placeholderIcon,
                          fit: BoxFit.cover,
                        ),
                      ),
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          AppImage.placeholderIcon,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),



              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width * .60,
                    child: Text(
                      docdata.title ?? "",
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

                  // Text("${DateTime.fromMillisecondsSinceEpoch(int.parse(docdata?.issuedDate??""),isUtc: true)}",
                  //   // "Issued : ${getDate(docdata?.issuedDate??"")}",
                  //   textAlign: TextAlign.left,
                  //   style: TextStyle(
                  //       fontSize: 10.0,
                  //       color:AppColor.textLightBlueBlack,
                  //       fontFamily: AppFont.poppinsRegular
                  //   ),
                  // ),

                  Text(
                    "${tr(LocaleKeys.additionText_issued)} :${dateConverter(int.parse(docdata?.issuedDate?? ""))}",

                    //"${(DateTime.fromMillisecondsSinceEpoch(int.parse(docdata?.issuedDate??" ")))}",
                    // "Issued : ${getDate(docdata?.issuedDate??"")}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 10.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsRegular,
                    ),
                  ),

                  Text(
                    "${tr(LocaleKeys.additionText_downloded)}: ${dateConverter(int.parse(docdata.createdDate??""))}",
                    //${DateTime.fromMillisecondsSinceEpoch(int.parse(docdata?.issuedDate??""))}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 10.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsRegular),
                  ),

                ],
              )
            ],
          ),
        ),
      ),


    ),
  );
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return "${Jiffy(d).format("dd MMM yyyy ")}".toUpperCase();

}
