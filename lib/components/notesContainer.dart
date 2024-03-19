import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me/models/notesDetailModel.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

Widget NotesContainer(BuildContext context , NotesDetails notesdata) {

  return Container(
    decoration: BoxDecoration(
      color: AppColor.textFieldGrey,
      borderRadius: BorderRadius.circular(36),
    ),
    height: 80,
    width: MediaQuery.of(context).size.width * .95,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image(image: AssetImage(AppImage.goldenRetriever)),
        SizedBox(
           width: 5.0,
        ),


        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColor.textFieldGrey

            ),
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child:
              CachedNetworkImage(
                imageUrl: notesdata.petPhoto??"",
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
          width: 8.0,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notesdata.notesCatagoriesName??"",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15.0,
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsMedium),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      dateConverter(int.parse(notesdata.createdDateTimeStamp??"0")),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.0,
                          color: AppColor.dateTextGrey,
                          fontFamily: AppFont.poppinsMedium),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              notesdata.notesCatagoriesTypesName??"",

              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 10.0,
                color: AppColor.textGreyColor,
                fontFamily: AppFont.poppinsRegular,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*.7,
              child: Text(
                notesdata?.title??"",
                // "Appointment with doctor this tuesday",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 10.0,
                    color: AppColor.textGreyColor,
                    fontFamily: AppFont.poppinsRegular),
              ),
            ),
          ],
        )


      ],
    ),
  );
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return "${Jiffy(d).format("dd/MM/yy ")}".toUpperCase();

}

