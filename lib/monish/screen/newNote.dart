import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/customBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../components/customdropdown.dart';
import '../../components/shortpage.dart';
import '../../generated/locale_keys.g.dart';
import '../../models/masterDetailModel.dart';
import '../../provider/petprovider.dart';
import '../../screen/newDocument.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/color.dart';

import '../models/newModel.dart';
import '../provider/myProvider.dart';

class NewNote extends StatefulWidget {
  bool isFromPet;
  NewNote({Key? key, this.isFromPet = true}) : super(key: key);
  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  late Myprovider my;
  var reaction;

  var showType = 1;

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController drugNameController = TextEditingController();

  // final Completer<PDFViewController> _controller =
  //     Completer<PDFViewController>();

  List<newButton> reactionbutton = [
    newButton(name: tr(LocaleKeys.additionText_positive)),
    newButton(name: tr(LocaleKeys.additionText_negative)),
    newButton(name: tr(LocaleKeys.additionText_unknown)),
  ];

  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    Myprovider myProvider = Provider.of(context, listen: false);

    petProvider.displayGreenTick(petProvider.petDetailList[0].id ?? 0);

    petProvider.notesFile.clear();
    myProvider.upodateSelectedbutton2(0);

    petProvider.cateTypeApiCall(context);
    reaction = 1;

    petProvider.selectedSubCategory?.name = tr(LocaleKeys.additionText_select);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: customAppbar(
          titlename: tr(LocaleKeys.additionText_newnote),
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
                    text1: tr(LocaleKeys.addPet_save),
                    onTap1: () {
                      PetProvider petProvider = Provider.of(context, listen: false);

                      // if(petProvider.selectedPetDetail?.isPremium==1 ){
                      //
                      // }

                      if (noteTitleController.text.isEmpty) {
                        print("feild is empty......");
                      } else {
                        petProvider.notesimages.clear();
                        print("printing the leng=== ${petProvider.notesimages.length}");

                        // if()
                        petProvider.callAddNotes(
                            context: context,
                            pettidd: widget.isFromPet
                                ? petProvider.selectedPetDetail?.id ?? 0
                                : petProvider.selectedPetIdForNotes ?? 0,
                            cateId: petProvider.selectedSubCategory?.categoriesId ?? 5,
                            cateTypeId: petProvider.selectedSubCategory?.id ?? 18,
                            reaction: reaction,
                            title: noteTitleController.text,
                            drug: drugNameController.text);
                      }
                    },
                    colour: noteTitleController.text.isEmpty
                        ?
                        // Color(0xff2A3C6A).withOpacity(0.5)
                        const Color(0xffAEB4C6)
                        : AppColor.newBlueGrey),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: BotttomBorder(context),
              )
            ],
          ),
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
                child: Consumer2<PetProvider, Myprovider>(builder: (context, petProvider, myprovider, child) {
                  List petList = petProvider.petDetailList;
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
                                widget.isFromPet
                                    ? Center(
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                // radius: 50,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: petProvider.selectedPetDetail?.petPhoto ?? "",
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) => Image.asset(
                                                      AppImage.placeholderIcon,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    errorWidget: (context, url, error) => Image.asset(
                                                      AppImage.placeholderIcon,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: SizedBox(
                                          height: 110.0,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: petList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    PetProvider provider = Provider.of(context, listen: false);

                                                    petProvider
                                                        .displayGreenTick(petProvider.petDetailList[index].id ?? 0);

                                                    print("pettiddd======= ${petProvider.selectedPetIdForNotes}");
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
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                widget.isFromPet
                                    ? Center(
                                        child: Text(
                                          petProvider.selectedPetDetail?.petName ?? "",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: AppColor.textLightBlueBlack,
                                              fontFamily: AppFont.poppinSemibold),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Consumer<PetProvider>(builder: (context, petProvider, child) {
                                      return Wrap(
                                        direction: Axis.horizontal,
                                        children: [
                                          for (int i = 0; i < petProvider.masterDetailList.length; i++)
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: SizedBox(
                                                height: 34,
                                                width: 105,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(4),
                                                      )),
                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                          petProvider.masterDetailList[i] ==
                                                                  petProvider.selectedMasterCategory
                                                              ? AppColor.newBlueGrey
                                                              : AppColor.textFieldGrey)),
                                                  onPressed: () {
                                                    petProvider.updateSelectedCategory(petProvider.masterDetailList[i]);
                                                    petProvider.selectedSubCategory?.name =
                                                        tr(LocaleKeys.additionText_select);
                                                  },
                                                  child:
                                                      // Text(
                                                      //   petProvider.masterDetailList[i].name ?? "",
                                                      //   style: TextStyle(
                                                      //       color: petProvider.masterDetailList[i] == petProvider.selectedMasterCategory
                                                      //           ? Colors.white
                                                      //           : Colors.black,
                                                      //       fontFamily: AppFont
                                                      //           .poppinsMedium,
                                                      //       fontSize: 10),
                                                      // ),

                                                      RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: <TextSpan>[
                                                      TextSpan(
                                                        text: petProvider.masterDetailList[i].name ?? "",
                                                        style: TextStyle(
                                                            color: petProvider.masterDetailList[i] ==
                                                                    petProvider.selectedMasterCategory
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
                                      textController: noteTitleController,
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
                                      textController: drugNameController,
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
                                    Consumer<Myprovider>(builder: (context, myprovider, child) {
                                      return Wrap(
                                        direction: Axis.horizontal,
                                        runSpacing: 12,
                                        spacing: 1,
                                        children: [
                                          for (int i = 0; i < myprovider.reactionbutton.length; i++)
                                            SizedBox(
                                              width: 105,
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
                                                              ? AppColor.newBlueGrey
                                                              : AppColor.textFieldGrey)),
                                                  onPressed: () {
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
                                      );
                                    }),
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
                                      return SizedBox(
                                        height: 160,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: petProvider.notesFile.length + 1,
                                            itemBuilder: (context, int index) {
                                              return index == petProvider.notesFile.length
                                                  ? Padding(
                                                      padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 6),
                                                      child: SizedBox(
                                                        height: 140,
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
                                                                          if (status.isDenied) {
                                                                            Permission.manageExternalStorage.request();
                                                                          } else if (status.isPermanentlyDenied ||
                                                                              status.isRestricted) {
                                                                            // Permission.manageExternalStorage.request();
                                                                            // openAppSettings();
                                                                            AppSettings.openAppSettings();
                                                                          } else if (status.isGranted) {
                                                                            Navigator.pop(context);
                                                                            fil = await getFile().then((value) {
                                                                              if (value != null) {
                                                                                return File(
                                                                                    value.files.first.path ?? "");
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
                                                                              return File(value.files.first.path ?? "");
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
                                                          onTap: () async {
                                                            print("********${petProvider.notesFile[index]}");
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 8.0, vertical: 5),
                                                            child: Container(
                                                              height: 160,
                                                              width: MediaQuery.of(context).size.width * .30,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor.textFieldGrey,
                                                                  borderRadius: BorderRadius.circular(15.0)),
                                                              child:

                                                                  //index==petProvider.notesFile.length ? () :
                                                                  SizedBox(
                                                                height: 170,
                                                                width: MediaQuery.of(context).size.width * .9,
                                                                child: DottedBorder(
                                                                  color: AppColor.textLightBlueBlack,
                                                                  strokeWidth: 1,
                                                                  dashPattern: const [10, 4],
                                                                  borderType: BorderType.RRect,
                                                                  radius: const Radius.circular(15.0),
                                                                  child: Center(
                                                                    child: InkWell(
                                                                      onTap: () async {
                                                                        print(
                                                                            "********${petProvider.notesFile[index].toString().split("/").last}");
                                                                      },
                                                                      child: petProvider.notesFile != null
                                                                          ? petProvider.notesFile[index].path
                                                                                  .split(".")
                                                                                  .last
                                                                                  .contains("pdf")
                                                                              ? Column(
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(
                                                                                          top: 25.0),
                                                                                      child: Image.asset(
                                                                                        "assets/images/upload-file.png",
                                                                                        height: 60,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Text(petProvider.notesFile[index]
                                                                                        .toString()
                                                                                        .split("/")
                                                                                        .last)
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
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(15),
                                                                                  child: SizedBox(
                                                                                      // color: Colors.blue,
                                                                                      height: 170,
                                                                                      width: MediaQuery.of(context)
                                                                                              .size
                                                                                              .width *
                                                                                          .9,
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
                                                            right: 12,
                                                            top: 8,
                                                            child: InkWell(
                                                              onTap: () {
                                                                petProvider.deleteNotesFile(index);
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
                                    const SizedBox(
                                      height: 50.0,
                                    )
                                  ],
                                ),
                              ])));
                }),
              );
            }));
  }
}
