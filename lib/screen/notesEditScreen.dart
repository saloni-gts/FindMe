import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/components/customdropdown.dart';
import 'package:find_me/components/shortpage.dart';
import 'package:find_me/models/masterDetailModel.dart';
import 'package:find_me/monish/provider/myProvider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../generated/locale_keys.g.dart';
import '../monish/reUseClass/mydocumentfie.dart';

class NotesEditScreen extends StatefulWidget {
  const NotesEditScreen({Key? key}) : super(key: key);

  @override
  State<NotesEditScreen> createState() => _NotesEditScreenState();
}

class _NotesEditScreenState extends State<NotesEditScreen> {
  var reaction;

  TextEditingController editNotesTitleController = new TextEditingController();
  TextEditingController editDrugController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppbar(
          titlename: tr(LocaleKeys.additionText_editNote),
          isbackbutton: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: customBlueButton(
              context: context,
              text1: tr(LocaleKeys.addPet_save),
              onTap1: () {
                // PetProvider petProvider =Provider.of(context,listen: false);
                // if( editNotesTitleController.text.isEmpty){
                //   print("feild is empty......");
                // }
                // else {
                //   petProvider.callEditNotes(
                //       context: context,
                //       cateId: petProvider.selectedSubCategory?.categoriesId??0,
                //       cateTypeId: petProvider.selectedNotes?.notesTypesCatagoriesId??0,
                //       drug: editDrugController.text,
                //       idd: petProvider.selectedNotes?.id??0,
                //       pettidd: petProvider.selectedNotes?.petId??0,
                //       reaction: reaction,
                //       title: editNotesTitleController.text
                //   );
                // }
              },
              colour: editNotesTitleController.text.isEmpty
                  ? Color(0xff2A3C6A).withOpacity(0.5)
                  : AppColor.newBlueGrey),
        ),
        body: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.83,
            minChildSize: 0.79,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Consumer2<PetProvider, Myprovider>(
                    builder: (context, petProvider, myprovider, child) {
                  return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.0,
                                ),
                                Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          // radius: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: CachedNetworkImage(
                                              imageUrl: petProvider
                                                      .selectedPetDetail
                                                      ?.petPhoto ??
                                                  "",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                AppImage.placeholderIcon,
                                                fit: BoxFit.fill,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                AppImage.placeholderIcon,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Center(
                                  child: Text(
                                    petProvider.selectedPetDetail?.petName ??
                                        "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinSemibold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Consumer<PetProvider>(builder:
                                          (context, petProvider, child) {
                                        return Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    petProvider.masterDetailList
                                                        .length;
                                                i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: SizedBox(
                                                  height: 32,
                                                  width: 108,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        )),
                                                        backgroundColor:
                                                            MaterialStateProperty.all<
                                                                Color>(petProvider
                                                                            .masterDetailList[
                                                                        i] ==
                                                                    petProvider
                                                                        .selectedMasterCategory
                                                                ? Color(
                                                                    0xff2A3C6A)
                                                                : Colors
                                                                    .white)),
                                                    onPressed: () {
                                                      petProvider
                                                          .updateSelectedCategory(
                                                              petProvider
                                                                  .masterDetailList[i]);
                                                    },
                                                    child: Text(
                                                      petProvider
                                                              .masterDetailList[
                                                                  i]
                                                              .name ??
                                                          "",
                                                      style: TextStyle(
                                                          color: petProvider
                                                                          .masterDetailList[
                                                                      i] ==
                                                                  petProvider
                                                                      .selectedMasterCategory
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily: AppFont
                                                              .poppinsMedium,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        tr(LocaleKeys.additionText_type),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinsRegular),
                                      ),
                                      Consumer<PetProvider>(
                                        builder: (context, value, child) {
                                          var handle = petProvider
                                                  .selectedMasterCategory
                                                  ?.catagoryList ??
                                              [];
                                          return handle.isEmpty
                                              ? SizedBox()
                                              : CustomDropDown<CatagoryList>(
                                                  // isGrey: pettypebool.isEmpty,
                                                  selectText: petProvider
                                                          .selectedSubCategory
                                                          ?.name ??
                                                      tr(LocaleKeys
                                                          .additionText_select),
                                                  itemList: petProvider
                                                          .selectedMasterCategory
                                                          ?.catagoryList ??
                                                      [],
                                                  isEnable: true,
                                                  onChange: (val) {
                                                    petProvider
                                                        .onselectCataType(val);
                                                  },
                                                  title: "",
                                                  value: null,
                                                );
                                        },
                                      ),
                                      SizedBox(
                                        height: 19,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            tr(LocaleKeys
                                                .additionText_noteTitle),
                                            style: TextStyle(
                                                fontFamily:
                                                    AppFont.poppinsRegular,
                                                fontSize: 12,
                                                color: AppColor
                                                    .textLightBlueBlack),
                                          ),
                                          Text(tr(LocaleKeys.newEvent_required),
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFont.poppinsRegular,
                                                  fontSize: 12,
                                                  color: Color(0xffFF0000)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      CustomTextFeild(
                                        textController:
                                            editNotesTitleController,
                                        textInputType: TextInputType.text,
                                        hintText: tr(
                                            LocaleKeys.additionText_descComnt),
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      Text(
                                        tr(LocaleKeys.additionText_Drug),
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsRegular,
                                            fontSize: 12,
                                            color: AppColor.textLightBlueBlack),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      CustomTextFeild(
                                        textController: editDrugController,
                                        textInputType: TextInputType.text,
                                        hintText: tr(
                                            LocaleKeys.additionText_entrDName),
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      Text(
                                        tr(LocaleKeys.additionText_reaction),
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsBold,
                                            fontSize: 16,
                                            color: AppColor.textLightBlueBlack),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        runSpacing: 12,
                                        spacing: 1,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  myprovider
                                                      .reactionbutton.length;
                                              i++)
                                            SizedBox(
                                              width: 110,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    )),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                            Color>(myprovider
                                                                .reactionbutton[
                                                                    i]
                                                                .buttonisSelected
                                                            ? Color(0xff941C1B)
                                                            : Colors.white)),
                                                onPressed: () {
                                                  myprovider
                                                      .upodateSelectedbutton2(
                                                          i);
                                                  reaction = i + 1;
                                                  print(
                                                      "reaction value=== ${reaction}");
                                                },
                                                child: Text(
                                                  myprovider
                                                      .reactionbutton[i].name,
                                                  style: TextStyle(
                                                      color: myprovider
                                                              .reactionbutton[i]
                                                              .buttonisSelected
                                                          ? Colors.white
                                                          : Color(0xff2A3C6A),
                                                      fontFamily:
                                                          AppFont.poppinsMedium,
                                                      fontSize: 9),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 23,
                                      ),
                                      Text(
                                        tr(LocaleKeys
                                            .additionText_uploadDocPic),
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsBold,
                                            fontSize: 16,
                                            color: AppColor.textLightBlueBlack),
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      Consumer<PetProvider>(builder:
                                          (context, petProvider, child) {
                                        List editImgList =
                                            petProvider.selectedNotes!.image;

                                        return Container(
                                          height: 200,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .95,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 160,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          editImgList.length,
                                                      // petProvider.notesFile.length +1,
                                                      itemBuilder:
                                                          (context, int index) {
                                                        return

                                                            //   index == editImgList.length
                                                            //     ? Padding(
                                                            //   padding: const EdgeInsets.only(top: 6.0,bottom: 7.0,left: 8),
                                                            //   child: Container(
                                                            //     height: 100,
                                                            //     // color: Colors.green,
                                                            //     width:
                                                            //     MediaQuery.of(context)
                                                            //         .size
                                                            //         .width *
                                                            //         .30,
                                                            //     child: DottedBorder(
                                                            //
                                                            //         color: AppColor
                                                            //             .textLightBlueBlack,
                                                            //         strokeWidth: 1,
                                                            //         dashPattern: [10, 4],
                                                            //         borderType:
                                                            //         BorderType.RRect,
                                                            //         radius:
                                                            //         Radius.circular(
                                                            //             15.0),
                                                            //         child: Center(
                                                            //           child: InkWell(
                                                            //               child:
                                                            //               CircleAvatar(
                                                            //                   backgroundColor:
                                                            //                   AppColor
                                                            //                       .textFieldGrey,
                                                            //                   child:
                                                            //                   Icon(
                                                            //                     Icons
                                                            //                         .add,
                                                            //                   )),
                                                            //               onTap:
                                                            //                   () async {
                                                            //                 int val = 0;
                                                            //                 File? fil;
                                                            //                 await bottomSheetFile(
                                                            //                     context,
                                                            //                     callBack:
                                                            //                     ((val) async {
                                                            //                       if (val ==
                                                            //                           1) {
                                                            //                         Navigator.pop(
                                                            //                             context);
                                                            //                         fil = (await getImage(
                                                            //                             ImageSource
                                                            //                                 .camera,
                                                            //                             circleCropStyle:
                                                            //                             false));
                                                            //                         val = 1;
                                                            //                       } else if (val ==
                                                            //                           2) {
                                                            //                         Navigator.pop(
                                                            //                             context);
                                                            //                         fil = (await getImage(
                                                            //                             ImageSource
                                                            //                                 .gallery,
                                                            //                             circleCropStyle:
                                                            //                             false));
                                                            //                         val = 2;
                                                            //                       } else if (val ==
                                                            //                           3) {
                                                            //                         Navigator.pop(
                                                            //                             context);
                                                            //                         fil = await getFile()
                                                            //                             .then(
                                                            //                                 (value) {
                                                            //                               if (value !=
                                                            //                                   null) {
                                                            //                                 return File(value.files.single?.path ?? "");
                                                            //                               } else {
                                                            //                                 return null;
                                                            //                               }
                                                            //                             });
                                                            //                         val = 3;
                                                            //                       }
                                                            //                       if (fil !=
                                                            //                           null) {
                                                            //                         PetProvider
                                                            //                         petProvide =
                                                            //                         Provider.of(
                                                            //                             context,
                                                            //                             listen: false);
                                                            //                         petProvide.addNotesFile(
                                                            //                             fil!,
                                                            //                             val);
                                                            //                       }
                                                            //                     }));
                                                            //               }),
                                                            //         )),
                                                            //   ),
                                                            // )
                                                            //     :
                                                            //

                                                            Stack(
                                                          children: [
                                                            GestureDetector(
                                                              onTap:
                                                                  () async {},
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        5),
                                                                child:
                                                                    Container(
                                                                  height: 160,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .30,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .textFieldGrey,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0)),
                                                                  child:

                                                                      //index==petProvider.notesFile.length ? () :
                                                                      Container(
                                                                    height: 170,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .9,
                                                                    child:
                                                                        DottedBorder(
                                                                      color: AppColor
                                                                          .textLightBlueBlack,
                                                                      strokeWidth:
                                                                          1,
                                                                      dashPattern: [
                                                                        10,
                                                                        4
                                                                      ],
                                                                      borderType:
                                                                          BorderType
                                                                              .RRect,
                                                                      radius: Radius
                                                                          .circular(
                                                                              15.0),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          print(
                                                                              "*******${editImgList.length}");
                                                                        },
                                                                        child: petProvider.selectedNotes?.image !=
                                                                                null
                                                                            ? petProvider.selectedNotes!.image[index].url!.split(".").last.contains("pdf")
                                                                                ? Column(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(top: 25.0),
                                                                                        child: Image.asset(
                                                                                          "assets/images/upload-file.png",
                                                                                          height: 60,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        petProvider.selectedNotes!.image[index].url!.split("/").last,
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                : Center(
                                                                                    child: Container(
                                                                                      height: 160,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(20.0),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(1.0),
                                                                                        child: CachedNetworkImage(
                                                                                          imageUrl: editImgList[index].url,
                                                                                          fit: BoxFit.cover,
                                                                                          placeholder: (context, url) => Padding(
                                                                                            padding: const EdgeInsets.all(12.0),
                                                                                            child: Image.asset(
                                                                                              AppImage.doctorImg,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                          errorWidget: (context, url, error) => Padding(
                                                                                            padding: const EdgeInsets.all(12.0),
                                                                                            child: Image.asset(
                                                                                              AppImage.doctorImg,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                            : Image.asset(AppImage.uploadIcon),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                right: 12,
                                                                top: 8,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    // petProvider.deleteNotesFile(index);
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .cancel_outlined,
                                                                    color: AppColor
                                                                        .textLightBlueBlack,
                                                                  ),
                                                                ))
                                                          ],
                                                        );
                                                      }),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 160,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: petProvider
                                                                .notesFile
                                                                .length +
                                                            1,
                                                        itemBuilder: (context,
                                                            int index) {
                                                          return index ==
                                                                  petProvider
                                                                      .notesFile
                                                                      .length
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      top: 5,
                                                                      bottom:
                                                                          6),
                                                                  child:
                                                                      Container(
                                                                    height: 140,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .30,
                                                                    child: DottedBorder(
                                                                        color: AppColor.textLightBlueBlack,
                                                                        strokeWidth: 1,
                                                                        dashPattern: [10, 4],
                                                                        borderType: BorderType.RRect,
                                                                        radius: Radius.circular(15.0),
                                                                        child: Center(
                                                                          child: InkWell(
                                                                              child: CircleAvatar(
                                                                                  backgroundColor: AppColor.textFieldGrey,
                                                                                  child: Icon(
                                                                                    Icons.add,
                                                                                  )),
                                                                              onTap: () async {
                                                                                int val = 0;
                                                                                File? fil;
                                                                                await bottomSheetFile(context, callBack: ((val) async {
                                                                                  if (val == 1) {
                                                                                    Navigator.pop(context);
                                                                                    fil = await getImage(ImageSource.camera, circleCropStyle: false);
                                                                                    val = 1;
                                                                                  } else if (val == 2) {
                                                                                    Navigator.pop(context);
                                                                                    fil = await getImage(ImageSource.gallery, circleCropStyle: false);
                                                                                    val = 2;
                                                                                  } else if (val == 3) {
                                                                                    Navigator.pop(context);
                                                                                    fil = await getFile().then((value) {
                                                                                      if (value != null) {
                                                                                        return File(value.files.first.path ?? "");
                                                                                      } else {
                                                                                        return null;
                                                                                      }
                                                                                    });
                                                                                    val = 3;
                                                                                  }
                                                                                  if (fil != null) {
                                                                                    PetProvider petProvide = Provider.of(context, listen: false);
                                                                                    petProvide.addNotesFile(fil!, val);
                                                                                  }
                                                                                }));
                                                                              }),
                                                                        )),
                                                                  ),
                                                                )
                                                              : Stack(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        print(
                                                                            "********${petProvider.notesFile[index]}");
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                8.0,
                                                                            vertical:
                                                                                5),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              160,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .30,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.textFieldGrey,
                                                                              borderRadius: BorderRadius.circular(15.0)),
                                                                          child:

                                                                              //index==petProvider.notesFile.length ? () :
                                                                              Container(
                                                                            height:
                                                                                170,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * .9,
                                                                            child:
                                                                                DottedBorder(
                                                                              color: AppColor.textLightBlueBlack,
                                                                              strokeWidth: 1,
                                                                              dashPattern: [
                                                                                10,
                                                                                4
                                                                              ],
                                                                              borderType: BorderType.RRect,
                                                                              radius: Radius.circular(15.0),
                                                                              child: Center(
                                                                                child: InkWell(
                                                                                  onTap: () async {
                                                                                    print("********${petProvider.notesFile[index].toString().split("/").last}");
                                                                                  },
                                                                                  child: petProvider.notesFile != null
                                                                                      ? petProvider.notesFile[index].path.split(".").last.contains("pdf")
                                                                                          ? Column(
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 5,
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(top: 25.0),
                                                                                                  child: Image.asset(
                                                                                                    "assets/images/upload-file.png",
                                                                                                    height: 60,
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 5,
                                                                                                ),
                                                                                                Text(petProvider.notesFile[index].toString().split("/").last)
                                                                                                // "${petProvider.notesimages[petProvider.notesimages.length-1]?.path.split('/').last}")
                                                                                              ],
                                                                                            )

                                                                                          // PDFView(
                                                                                          //             filePath: petProvider
                                                                                          //             .notesFile[index]?.path ?? "",
                                                                                          //             enableSwipe: true,
                                                                                          //             swipeHorizontal: true,
                                                                                          //             autoSpacing: false,
                                                                                          //             pageFling: false,
                                                                                          //             onRender: (_pages) {},
                                                                                          //             onError: (error) {
                                                                                          //               print(error.toString());
                                                                                          //             },
                                                                                          //             onPageError: (page, error) {
                                                                                          //               print('$page: ${error.toString()}');
                                                                                          //             },
                                                                                          //             onViewCreated: (PDFViewController pdfViewController) {
                                                                                          //               _controller.complete(pdfViewController);
                                                                                          //             },
                                                                                          //           )
                                                                                          : ClipRRect(
                                                                                              borderRadius: BorderRadius.circular(15),
                                                                                              child: Container(
                                                                                                  color: Colors.blue,
                                                                                                  height: 170,
                                                                                                  width: MediaQuery.of(context).size.width * .9,
                                                                                                  child: Image.file(
                                                                                                    petProvider.notesFile[index],
                                                                                                    fit: BoxFit.fill,
                                                                                                  )),
                                                                                            )
                                                                                      : Image.asset(AppImage.uploadIcon),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        right:
                                                                            12,
                                                                        top: 8,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            petProvider.deleteNotesFile(index);
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.cancel_outlined,
                                                                            color:
                                                                                AppColor.textLightBlueBlack,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                );
                                                        }),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ])));
                }),
              );
            }));
  }
}
