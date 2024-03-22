import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/components/customdropdown.dart';
import 'package:find_me/components/shortpage.dart';
import 'package:find_me/models/masterDetailModel.dart';
import 'package:find_me/models/notesDetailModel.dart';
import 'package:find_me/monish/models/newModel.dart';
import 'package:find_me/monish/provider/myProvider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../components/bottomBorderComp.dart';
import '../generated/locale_keys.g.dart';
import '../models/editNotesModel.dart';
import '../monish/reUseClass/mydocumentfie.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({Key? key}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  var reaction;

  TextEditingController editNotesTitleController = TextEditingController();
  TextEditingController editDrugController = TextEditingController();

  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  var catId;
  var catTypId;
  var idd;
  @override
  List<newButton> reactionbutton = [
    newButton(name: tr(LocaleKeys.additionText_positive)),
    newButton(name: tr(LocaleKeys.additionText_negative)),
    newButton(name: tr(LocaleKeys.additionText_unknown)),
  ];

  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    Myprovider myProvider = Provider.of(context, listen: false);

    petProvider.displayGreenTick(petProvider.selectedNotes?.petId ?? 0);
    print("=======${petProvider.selectedNotes?.petId}");

    petProvider.cateTypeApiCall(context, isfromedit: true);

    print("############ >>>>. ${petProvider.masterDetailList.length}");
    print("selectedMasterCategory. ${petProvider.selectedMasterCategory?.name ?? ""}");

    NotesDetails? editNotesData = petProvider.selectedNotes;

    petProvider.NotesImgEdit();
    print("======= ${editNotesData?.reaction}");

    print("***********");
    print("${petProvider.selectedNotes?.id}");
    petProvider.NotesImgEdit();

    var v1 = editNotesData?.reaction ?? 0;
    //reaction-1
    myProvider.upodateSelectedbutton2(v1 - 1);

    reaction = editNotesData?.reaction;
    editNotesTitleController.text = editNotesData?.title ?? "";
    editDrugController.text = editNotesData?.drug ?? "";

    catId = editNotesData?.notesTypesCatagoriesId;
    catTypId = editNotesData?.notesCatagoriesId;
    idd = editNotesData?.id;

    petProvider.selectedSubCategory?.categoriesId = petProvider.selectedSubCategory?.categoriesId;
    petProvider.selectedNotes?.id = editNotesData?.id;
    petProvider.selectedNotes?.id = editNotesData?.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        // bottomNavigationBar: BotttomBorder(context),
        appBar: customAppbar(
          titlename: tr(LocaleKeys.additionText_editNote),
          isbackbutton: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: customBlueButton(
                    context: context,
                    text1: tr(LocaleKeys.additionText_capUpdte),
                    // tr(LocaleKeys.addPet_save),
                    onTap1: () {
                      PetProvider petProvider = Provider.of(context, listen: false);
                      if (editNotesTitleController.text.isEmpty) {
                        print("feild is empty......");
                      } else {
                        print("pet id after change===>> ${petProvider.selectedPetIdForNotes ?? 0}");
                        petProvider.callEditNotes(
                            context: context,
                            cateId: petProvider.selectedSubCategory?.categoriesId ?? 0,
                            cateTypeId: petProvider.selectedSubCategory?.id ?? 0,
                            drug: editDrugController.text,
                            idd: petProvider.selectedNotes?.id ?? 0,
                            pettidd: petProvider.selectedPetIdForNotes ?? 0,
                            reaction: reaction,
                            title: editNotesTitleController.text);
                      }
                    },
                    colour: editNotesTitleController.text.isEmpty ? const Color(0xffAEB4C6) : AppColor.newBlueGrey),
              ),
              BotttomBorder(context)
            ],
          ),
        ),
        body: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.85,
            minChildSize: 0.79,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Consumer2<PetProvider, Myprovider>(builder: (context, petProvider, myprovider, child) {
                  return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),

                                ///*******************************

                                Consumer<PetProvider>(
                                  builder: (context, petProvider, child) {
                                    var petList = petProvider.petDetailList;
                                    return SizedBox(
                                      height: 110.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: petList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                PetProvider provider = Provider.of(context, listen: false);

                                                petProvider.displayGreenTick(petProvider.petDetailList[index].id ?? 0);
                                                print(
                                                    "finally selected pet id::::::::::${petProvider.petDetailList[index].id}");
                                                // print("comming pet  selected pet id::::::::::${widget.petIdEvent}");
                                                // var cngPetId = petProvider.petDetailList[index].id;
                                                // provider.setPetIdFroEditEvent(cngPetId!);
                                                print("pet id from provider${provider.petIdForEdit}");
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(40),
                                                              color: AppColor.textFieldGrey),
                                                          height: 80,
                                                          width: 80,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(40),
                                                            child: CachedNetworkImage(
                                                              imageUrl: petList[index].petPhoto ?? "",
                                                              fit: BoxFit.cover,
                                                              placeholder: (context, url) => Padding(
                                                                padding: const EdgeInsets.all(15.0),
                                                                child: Image.asset(
                                                                  AppImage.placeholderIcon,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              errorWidget: (context, url, error) => Padding(
                                                                padding: const EdgeInsets.all(15.0),
                                                                child: Image.asset(
                                                                  AppImage.placeholderIcon,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // petProvider.petDetailList[index].id == petProvider.selectedPetIdForEvent
                                                        petProvider.petDetailList[index].id ==
                                                                petProvider.selectedPetIdForNotes
                                                            ? Positioned(
                                                                left: 55.0,
                                                                top: 0,
                                                                child: InkWell(
                                                                  child: ClipRRect(
                                                                    child: Image.asset(AppImage.greenCheckIcon),
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print("IMAGE PET  ${petList[index].petPhoto}");
                                                    },
                                                    child: Text(
                                                      petList[index].petName ?? "",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                          fontFamily: AppFont.poppinSemibold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    );
                                  },
                                ),

                                ///*******************************

                                // SizedBox(
                                //   height: 5.0,
                                // ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        return Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            for (int i = 0; i < petProvider.masterDetailList.length; i++)
                                              Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: SizedBox(
                                                  height: 34,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4),
                                                        )),
                                                        backgroundColor: MaterialStateProperty.all<Color>(
                                                            petProvider.masterDetailList[i].id ==
                                                                    petProvider.selectedMasterCategory?.id
                                                                ? const Color(0xff2A3C6A)
                                                                : AppColor.textFieldGrey)),
                                                    onPressed: () {
                                                      petProvider
                                                          .updateSelectedCategory(petProvider.masterDetailList[i]);
                                                      petProvider.selectedSubCategory?.name =
                                                          tr(LocaleKeys.additionText_select);
                                                    },
                                                    child:
                                                        // Text(
                                                        //   petProvider.masterDetailList[i].name??"",
                                                        //   style: TextStyle(
                                                        //       color: petProvider.masterDetailList[i].id==petProvider.selectedMasterCategory?.id
                                                        //           ? Colors.white
                                                        //           : Colors.black,
                                                        //       fontFamily: AppFont.poppinsMedium,
                                                        //       fontSize: 10),
                                                        // ),

                                                        RichText(
                                                      textAlign: TextAlign.center,
                                                      text: TextSpan(children: <TextSpan>[
                                                        TextSpan(
                                                          text: petProvider.masterDetailList[i].name ?? "",
                                                          style: TextStyle(
                                                              color: petProvider.masterDetailList[i].id ==
                                                                      petProvider.selectedMasterCategory?.id
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                              fontSize: 10.0,
                                                              fontWeight: FontWeight.w800),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        // return
                                        var handle = petProvider.selectedMasterCategory?.catagoryList ?? [];
                                        return handle.isEmpty
                                            ? const SizedBox()
                                            : Text(
                                                tr(LocaleKeys.additionText_type),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: AppColor.textLightBlueBlack,
                                                    fontFamily: AppFont.poppinsBold),
                                              );
                                      }),
                                      Consumer<PetProvider>(
                                        builder: (context, value, child) {
                                          var handle = petProvider.selectedMasterCategory?.catagoryList ?? [];
                                          return handle.isEmpty
                                              ? const SizedBox()
                                              : CustomDropDown<CatagoryList>(
                                                  // isGrey: pettypebool.isEmpty,
                                                  selectText: petProvider.selectedSubCategory?.name ??
                                                      tr(LocaleKeys.additionText_select),
                                                  itemList: petProvider.selectedMasterCategory?.catagoryList ?? [],
                                                  isEnable: true,
                                                  onChange: (val) {
                                                    petProvider.onselectCataType(val);
                                                  },
                                                  title: "",
                                                  value: null,
                                                );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 19,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            tr(LocaleKeys.additionText_noteTitle),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: AppColor.textLightBlueBlack,
                                                fontFamily: AppFont.poppinsBold),
                                          ),
                                          Text("(${tr(LocaleKeys.newEvent_required)})",
                                              style: const TextStyle(
                                                  fontFamily: AppFont.poppinsRegular,
                                                  fontSize: 12,
                                                  color: Color(0xffFF0000)))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      CustomTextFeild(
                                        textController: editNotesTitleController,
                                        textInputType: TextInputType.text,
                                        hintText: tr(LocaleKeys.additionText_descComnt),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Text(
                                        tr(LocaleKeys.additionText_Drug),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinsBold),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      CustomTextFeild(
                                        textController: editDrugController,
                                        textInputType: TextInputType.text,
                                        hintText: tr(LocaleKeys.additionText_entrDName),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Text(
                                        tr(LocaleKeys.additionText_reaction),
                                        style: const TextStyle(
                                            fontFamily: AppFont.poppinsBold,
                                            fontSize: 16,
                                            color: AppColor.textLightBlueBlack),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        runSpacing: 12,
                                        spacing: 1,
                                        children: [
                                          for (int i = 0; i < myprovider.reactionbutton.length; i++)
                                            SizedBox(
                                              width: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 3.0),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      )),
                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                          myprovider.reactionbutton[i].buttonisSelected
                                                              ? const Color(0xff941C1B)
                                                              : AppColor.textFieldGrey)),
                                                  onPressed: () {
                                                    print("printing the value of i >>>>> $i");

                                                    myprovider.upodateSelectedbutton2(i);
                                                    reaction = i + 1;
                                                    print("reaction value=== $reaction");
                                                  },
                                                  child: Text(
                                                    reactionbutton[i].name,
                                                    style: TextStyle(
                                                        color: myprovider.reactionbutton[i].buttonisSelected
                                                            ? Colors.white
                                                            : const Color(0xff2A3C6A),
                                                        fontFamily: AppFont.poppinsMedium,
                                                        fontSize: 9),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 23,
                                      ),
                                      Text(
                                        tr(LocaleKeys.additionText_uploadDocPic),
                                        style: const TextStyle(
                                            fontFamily: AppFont.poppinsBold,
                                            fontSize: 16,
                                            color: AppColor.textLightBlueBlack),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        List<NotesImgEditModel> editImgList = petProvider.editNoteList;

                                        return SizedBox(
                                          height: 160,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: editImgList.length + 1,
                                              // petProvider.notesFile.length +1,
                                              itemBuilder: (context, int index) {
                                                String filePath = "";
                                                String imgurll = "";
                                                if (index != editImgList.length) {
                                                  filePath = editImgList[index].file1?.path ?? "";
                                                  imgurll = editImgList[index].Imgurl ?? "";
                                                }
                                                return index == editImgList.length
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(top: 6.0, bottom: 7.0, left: 8),
                                                        child: SizedBox(
                                                          height: 100,
                                                          // color: Colors.green,
                                                          width: MediaQuery.of(context).size.width * .30,
                                                          child: DottedBorder(
                                                              color: AppColor.textLightBlueBlack,
                                                              strokeWidth: 1,
                                                              dashPattern: const [10, 4],
                                                              borderType: BorderType.RRect,
                                                              radius: const Radius.circular(15.0),
                                                              child: Center(
                                                                child: InkWell(
                                                                    child: const CircleAvatar(
                                                                        backgroundColor: AppColor.textFieldGrey,
                                                                        child: Icon(
                                                                          Icons.add,
                                                                        )),
                                                                    onTap: () async {
                                                                      int val = 0;
                                                                      File? fil;
                                                                      await bottomSheetFile(context,
                                                                          callBack: ((val) async {
                                                                        print("valllll$val");
                                                                        if (val == 1) {
                                                                          Navigator.pop(context);
                                                                          fil = await getImage(ImageSource.camera,
                                                                              circleCropStyle: false);
                                                                          val = 1;
                                                                        } else if (val == 2) {
                                                                          Navigator.pop(context);
                                                                          fil = await getImage(ImageSource.gallery,
                                                                              circleCropStyle: false);
                                                                          val = 2;
                                                                        } else if (val == 3) {
                                                                          if (Platform.isAndroid) {
                                                                            var status = await Permission
                                                                                .manageExternalStorage
                                                                                .request();
                                                                            print("storage statur====$status");
                                                                            // if (status.isDenied) {
                                                                            //   Permission.manageExternalStorage.request();
                                                                            // } else if (status.isPermanentlyDenied ||
                                                                            //     status.isRestricted) {
                                                                            //   // Permission.manageExternalStorage.request();
                                                                            //   // openAppSettings();
                                                                            //     AppSettings.openAppSettings();

                                                                            // } else if (status.isGranted)
                                                                            {
                                                                              Navigator.pop(context);
                                                                              fil = await getFile().then((value) {
                                                                                if (value != null) {
                                                                                  return File(
                                                                                      value.files.single.path ?? "");
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              });
                                                                              val = 3;
                                                                            }
                                                                          }
                                                                          if (Platform.isIOS) {
                                                                            Navigator.pop(context);
                                                                            fil = await getFile().then((value) {
                                                                              if (value != null) {
                                                                                return File(
                                                                                    value.files.single.path ?? "");
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            });
                                                                            val = 3;
                                                                          }
                                                                        }

                                                                        if (fil != null) {
                                                                          print("value==$fil");
                                                                          if (fil.toString() == "File: ''") {
                                                                            print("value like this===");
                                                                            fil = null;
                                                                          }
                                                                        }

                                                                        if (fil != null) {
                                                                          PetProvider petProvide =
                                                                              Provider.of(context, listen: false);
                                                                          petProvide.editNotesFile(fil!, val);
                                                                        }
                                                                      }));
                                                                    }),
                                                              )),
                                                        ),
                                                      )
                                                    : Stack(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {},
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 8.0, vertical: 5),
                                                              child: Container(
                                                                height: 180,
                                                                width: MediaQuery.of(context).size.width * .30,
                                                                decoration: BoxDecoration(
                                                                    color: AppColor.textFieldGrey,
                                                                    borderRadius: BorderRadius.circular(15.0)),
                                                                child:

                                                                    //index==petProvider.notesFile.length ? () :
                                                                    Container(
                                                                  height: 180,
                                                                  width: MediaQuery.of(context).size.width * .9,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15.0),
                                                                  ),
                                                                  child: DottedBorder(
                                                                    color: AppColor.textLightBlueBlack,
                                                                    strokeWidth: 1,
                                                                    dashPattern: const [10, 4],
                                                                    borderType: BorderType.RRect,
                                                                    radius: const Radius.circular(15.0),
                                                                    child: Center(
                                                                      child: InkWell(
                                                                          onTap: () async {
                                                                            print("*******${editImgList.length}");
                                                                          },
                                                                          child:

                                                                              // petProvider.selectedNotes?.image != null ?
                                                                              (imgurll
                                                                                          .split(".")
                                                                                          .last
                                                                                          .contains("pdf") ||
                                                                                      filePath
                                                                                          .split(".")
                                                                                          .last
                                                                                          .contains("pdf"))
                                                                                  ? Column(
                                                                                      children: [
                                                                                        const SizedBox(
                                                                                          height: 5,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding:
                                                                                              const EdgeInsets.only(
                                                                                                  top: 25.0),
                                                                                          child: Image.asset(
                                                                                            "assets/images/upload-file.png",
                                                                                            height: 60,
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 5,
                                                                                        ),
                                                                                        const Center(
                                                                                          child: Text("file"),
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  : Center(
                                                                                      child: Container(
                                                                                        height: 180,
                                                                                        width: 120,
                                                                                        decoration: BoxDecoration(
                                                                                          // color:Colors.red,
                                                                                          borderRadius:
                                                                                              BorderRadius.circular(
                                                                                                  20.0),
                                                                                        ),
                                                                                        child: petProvider
                                                                                                    .editNoteList[index]
                                                                                                    .type ==
                                                                                                1
                                                                                            ? ClipRRect(
                                                                                                borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(15),
                                                                                                child:
                                                                                                    CachedNetworkImage(
                                                                                                  imageUrl:
                                                                                                      editImgList[index]
                                                                                                              .Imgurl ??
                                                                                                          "",
                                                                                                  fit: BoxFit.fill,
                                                                                                  placeholder:
                                                                                                      (context, url) =>
                                                                                                          Padding(
                                                                                                    padding:
                                                                                                        const EdgeInsets
                                                                                                            .all(0.0),
                                                                                                    child: Image.asset(
                                                                                                      AppImage
                                                                                                          .doctorImg,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                  errorWidget: (context,
                                                                                                          url, error) =>
                                                                                                      Padding(
                                                                                                    padding:
                                                                                                        const EdgeInsets
                                                                                                            .all(0.0),
                                                                                                    child: Image.asset(
                                                                                                      AppImage
                                                                                                          .doctorImg,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : editImgList[index]
                                                                                                        .file1 !=
                                                                                                    null
                                                                                                ? Image.file(
                                                                                                    editImgList[index]
                                                                                                        .file1!)
                                                                                                : const SizedBox(),
                                                                                      ),
                                                                                    )),
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
                                                                  petProvider.deleteEditNotes(index);
                                                                },
                                                                child: const Icon(
                                                                  Icons.cancel_outlined,
                                                                  color: AppColor.textLightBlueBlack,
                                                                ),
                                                              ))
                                                        ],
                                                      );
                                              }),
                                        );
                                      }),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 30.0,
                                )
                              ])));
                }),
              );
            }));
  }
}
