import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/customBlueButton.dart';
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


void fliterPetDailog({required BuildContext context}) {


  showDialog(
      context: context,
      builder: (context) => blurView(
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              scrollable: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                      height: 300,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * .95,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width:MediaQuery.of(context).size.width * .85,
                            // color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppColor.textGreyColor,
                                      fontFamily: AppFont.poppinsRegular),
                                ),
                             Text(
                                  "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppColor.textGreyColor,
                                      fontFamily: AppFont.poppinsRegular),
                                ),Text(
                                  "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppColor.textGreyColor,
                                      fontFamily: AppFont.poppinsRegular),
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text(
                                      tr(LocaleKeys.additionText_myPos),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsBold),
                                    ),
                                  ),
                                ),

                                Text(
                                  "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppColor.textGreyColor,
                                      fontFamily: AppFont.poppinsRegular),
                                ),

                                Text(
                                  "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppColor.textGreyColor,
                                      fontFamily: AppFont.poppinsRegular),
                                ),


                                // new Spacer(),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, bottom: 3),
                                  child: InkWell(
                                    child: Image(
                                        image: AssetImage(AppImage.closeIcon)),
                                    onTap: () {
                                      PetProvider petProvider=Provider.of(context,listen: false);
                                      // petProvider.greenTickList.clear();


                                      Navigator.pop(context);
                                    },
                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),

                          Consumer<PetProvider>(
                            builder: (context, petProvider, child) {
                              var petList = petProvider.petDetailList;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10.0),
                                child: Container(
                                  height: 170,
                                  child: ListView.builder(
                                      itemCount: petList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5.0),
                                          child: InkWell(
                                            onTap: (){

                                              petProvider.showinGreenTick(petProvider.petDetailList[index].id??0);

                                              if(  petProvider.greenTickList.contains(petProvider.petDetailList[index].id??0))
                                               {
                                                 petProvider.greenTickList.remove(petProvider.petDetailList[index].id??0);
                                               }
                                              else{
                                                petProvider.greenTickList.add(petProvider.petDetailList[index].id??0);
                                              }


                                              print("green tick image = ${petProvider.greenTickList}");


                                            },

                                            child: Row(
                                              children: [

                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color:
                                                          AppColor.textFieldGrey),
                                                  height: 60,
                                                  width: 60,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(40),
                                                    child: CachedNetworkImage(
                                                      imageUrl: petList[index]
                                                              .petPhoto ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (context, url) =>
                                                              Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                15.0),
                                                        child: Image.asset(
                                                          AppImage
                                                              .placeholderIcon,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      errorWidget:
                                                          (context, url, error) =>
                                                              Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                15.0),
                                                        child: Image.asset(
                                                          AppImage
                                                              .placeholderIcon,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: 10.0,
                                                ),

                                                Text(
                                                  petList[index].petName ?? "",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          AppFont.poppinSemibold),
                                                ),


                                                new Spacer(),

                                                petProvider.greenTickList.contains(petProvider.petDetailList[index].id) ?

                                                Image( image: AssetImage(
                                                    AppImage.greenCheckIcon)) :SizedBox(),




                                                // petProvider.petDetailList[index].id == petProvider.petFilterId ? Image(
                                                //     image: AssetImage(
                                                //         AppImage.greenCheckIcon)) :SizedBox(),

                                              ],
                                            ),
                                          ),
                                        );
                                      }),


                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: customBlueButton(
                                context: context,
                                text1: tr(LocaleKeys.additionText_apply),
                                onTap1: ()
                                {
                                  PetProvider petProvider=Provider.of(context,listen: false);


                                  String IdLst=
                                  petProvider.greenTickList.toString().replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").toString();


                                  petProvider.petIdList=IdLst;


                                  print("before api call====>>> ${petProvider.petIdList}");
                                  petProvider.callGetNotes();
                                 Navigator.pop(context);
                                },
                                colour: AppColor.newBlueGrey),
                          )

                        ],
                      )),
                )
              ]),
            ),
          ));
}
