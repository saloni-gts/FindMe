import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/models/getPhotosModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/customSmallBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../screen/blur_background.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/color.dart';
import '../generated/locale_keys.g.dart';
import '../provider/petprovider.dart';

void petdeleteDailog({required BuildContext context, required GetPetPhotos imgData}) {
  showDialog(
      context: context,
      builder: (context) => blurView(
              child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: SizedBox(
                        height: 272,
                        width: MediaQuery.of(context).size.width * .9,
                        child: CachedNetworkImage(
                          imageUrl: imgData.photo ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(AppImage.dogPreview),
                          errorWidget: (context, url, error) => Image.asset(AppImage.dogPreview),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.white,
                            child: InkWell(
                              //  margin: EdgeInsets.all(7),
                              child: Image.asset(AppImage.delete_doc),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(tr(LocaleKeys.additionText_sureWannaDel)),
                                          actions: <Widget>[
                                            InkWell(
                                              child: Text(tr(LocaleKeys.additionText_cancel)),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            InkWell(
                                              child: Text(tr(LocaleKeys.additionText_yes)),
                                              onTap: () async {
                                                PetProvider petProvider = Provider.of(context, listen: false);
                                                Map<String, dynamic> bodyy = {"petId": imgData.petId, "id": imgData.id};
                                                await petProvider.deletePetPhotoCall(bodyy, context: context);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ));
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )));
}
