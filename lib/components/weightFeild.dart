

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/monish/provider/myProvider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';


import '../generated/locale_keys.g.dart';

Widget WeightFeild(BuildContext context ,var weight ,String weightdate,int indxx,int iddd) {
  return Center(
    child: Container(
      height: 56,
      width: MediaQuery.of(context).size.width * .88,
      decoration: BoxDecoration(
          // border: Border.all(color: AppColor.textLightBlueBlack,width: 2),
        borderRadius: BorderRadius.circular(36),
        color: AppColor.textFieldGrey,
      ),
      child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "         ",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 15.0,
                color: AppColor.textLightBlueBlack,
                fontFamily: AppFont.poppinsBold),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                weight.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinsBold),
              ),
              Text(
                dateConverter(int.parse(weightdate)) ,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 10.0,
                    color: AppColor.textGreyColor,
                    fontFamily: AppFont.poppinsRegular),
              ),
            ],
          ),



          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
                onTap: () {
                  Myprovider Pro = Provider.of(context, listen: false);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                            tr(LocaleKeys.additionText_sureWannaDelNtr)),
                        actions: <Widget>[
                          InkWell(
                            child:  Text(
                                tr(LocaleKeys.additionText_cancel)

                              ,style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: AppFont.poppinsMedium
                            ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                          SizedBox(width: 5,),

                          InkWell(
                            child:  Text(
                                tr(LocaleKeys.additionText_yes)

                              ,style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: AppFont.poppinsMedium
                            ),
                            ),
                            onTap: () async {
                              print("printing the iddd===== ${iddd}");


                              PetProvider petProvider=Provider.of(context,listen: false);
                              petProvider.deleteWeightApiCall(context: context, idddd: iddd);
                              Navigator.pop(context);

                            },
                          )
                        ],
                      ));


                },
                child: Image(
                    image:AssetImage(
                        AppImage.whiteDeleteIcon
                    )
                )
            ),
          )

        ],
      ),
    ),
  );
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return "${Jiffy(d).format("dd MMM, yyyy ")}";

}