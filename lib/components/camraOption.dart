import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';


import '../generated/locale_keys.g.dart';

Widget iconButton({required Function onPress, String? img, String? text}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(onPressed: () => onPress(), icon: Image.asset(img!),iconSize: 45,),
      Text(
        "$text",
        style: const TextStyle(color: AppColor.textLightBlueBlack),
      )
    ],
  );
}
Future<bool> _willPopCallback(BuildContext context ,BuildContext ctxx) async {
  Navigator.pop(context);
  Focus.of(ctxx).unfocus();
  return true;
  // await showDialog or Show add banners or whatever
  // then
}
showAlertForImage(
    {required BuildContext context,
    required Function(bool val) callBack,
    required String headText}) {
  showDialog(
      context: context,
      builder: (ctx) => WillPopScope(child:AlertDialog(
        title: Center(
          child: Text(
            headText,
            style:
            TextStyle(fontSize: 18, color: AppColor.textLightBlueBlack),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconButton(
                onPress: () {

                  callBack(true);

                },
                img: AppImage.cameraImg,
                text: tr(LocaleKeys.additionText_Camera) ,

                // tr(LocaleKeys.additionText_camera)
            ),
            iconButton(
              onPress: () {
                callBack(false);
              },
              img: AppImage.galleryImg,
              text: tr(LocaleKeys.additionText_photoGallery),
            ),
          ],
        ),
      ) , onWillPop: ()async{
        return
        await _willPopCallback(context,ctx);
      })
  );


}

