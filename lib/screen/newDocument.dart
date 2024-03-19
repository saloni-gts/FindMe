import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customdropdown.dart';
import 'package:find_me/components/previewFullImage.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/customTextFeild.dart';
import '../components/shortpage.dart';
import '../models/documentdetailmodel.dart';
import '../util/app_font.dart';
import '../util/color.dart';

class NewDocument extends StatefulWidget {
  bool isNewDoc;

  NewDocument({
    Key? key,
    this.isNewDoc = true,
  }) : super(key: key);

  @override
  State<NewDocument> createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {
  DocumentDetails? editDocData;

  TextEditingController chooseCategory = TextEditingController();
  TextEditingController documentTitle = TextEditingController();
  TextEditingController issueDate = TextEditingController();
  late var Switchcontroller = ValueNotifier<bool>(false);
  bool _checked = false;

  var v1 = 1;

  String timestampGmt = "";
  String docUrll = "";
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  @override
  void initState() {
    // Switchcontroller.addListener(() {
    //   setState(() {
    //     if (Switchcontroller.value) {
    //       _checked = true;
    //     } else {
    //       _checked = false;
    //     }
    //   });
    // });

    PetProvider pet = Provider.of(context, listen: false);
    print("cate id of doc==>> ${pet.cateId}");

    if (!widget.isNewDoc) {
      DocumentDetails? editDocData = pet.selectedDocument;
      print("value from model= ${editDocData?.fileType}");
      editDocData!.fileType == 1
          ? Switchcontroller = ValueNotifier<bool>(true)
          : Switchcontroller = ValueNotifier<bool>(false);

      if (editDocData.fileType == 2) {
        Switchcontroller.value = false;
      }

      setDataForedit(editDocData);

      documentTitle.text = editDocData.title ?? "";
      issueDate.text = dateConverter(int.parse(editDocData.issuedDate ?? "")).toString();
      //DateTime.fromMillisecondsSinceEpoch(int.parse(editDocData!.issuedDate!!??"")).toString();
      docUrll = pet.selectedDocument?.docUrls ?? "";

      // setDataForedit();
    }

    pet.docFile = null;
    super.initState();
  }

  List<PetTypeModl> docCateList = [
    PetTypeModl(title: tr(LocaleKeys.additionText_vetVisits), typeId: "2"),
    PetTypeModl(title: tr(LocaleKeys.additionText_invoices), typeId: "3"),
    PetTypeModl(title: tr(LocaleKeys.additionText_vaccinations), typeId: "4"),
    PetTypeModl(title: tr(LocaleKeys.additionText_labTests), typeId: "5"),
    PetTypeModl(title: tr(LocaleKeys.additionText_businessCards), typeId: "6"),
    PetTypeModl(title: tr(LocaleKeys.additionText_agreements), typeId: "7"),
    PetTypeModl(title: tr(LocaleKeys.additionText_certificates), typeId: "8"),
    PetTypeModl(title: tr(LocaleKeys.additionText_passport), typeId: "9"),
    PetTypeModl(title: "Pedigree", typeId: "10"),
    PetTypeModl(title: tr(LocaleKeys.additionText_others), typeId: "1"),
  ];

  setDataForedit(DocumentDetails docDetail) {
    PetProvider pet = Provider.of(context, listen: false);
    int docType;
    docType = docDetail.documentCategoryId ?? 0;

    if (docType.toString().isNotEmpty) {
      pet.selectedDocType =
          docCateList.firstWhere((element) => element.typeId == docDetail.documentCategoryId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppbar(
          isbackbutton: true,
          titlename: widget.isNewDoc ? tr(LocaleKeys.additionText_newDoc) : tr(LocaleKeys.additionText_editDoc)),
      backgroundColor: Colors.white,
      // bottomNavigationBar: BotttomBorder(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15.0),
            child: Consumer<PetProvider>(builder: (context, petProvider, child) {
              String docCate = petProvider.selectedDocType?.title ?? "";
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  ///****
//additionText_choseCate  tr(LocaleKeys.additionText_choseCate)
                  Text(
                    tr(LocaleKeys.additionText_choseCate),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //
                  //
                  //
                  widget.isNewDoc
                      ?
                      //
                      CustomDropDown<PetTypeModl>(
                          isGrey: docCate.isEmpty,
                          selectText: petProvider.selectedDocType?.title ?? tr(LocaleKeys.additionText_select),
                          itemList: docCateList,
                          isEnable: true,
                          onChange: (val) {
                            petProvider.onselectDocCate(val);
                            print("selected doc cate=== ${petProvider.selectedDocType?.typeId ?? ""}");
                          },
                          title: "",
                          value: null,
                        )
                      :
                      // SizedBox(),

                      CustomDropDown<PetTypeModl>(
                          isGrey: docCate.isEmpty,
                          selectText: petProvider.selectedDocType?.title ?? tr(LocaleKeys.additionText_select),
                          itemList: docCateList,
                          isEnable: true,
                          onChange: (val) {
                            petProvider.onselectDocCate(val);
                            print("selected doc cate=== ${petProvider.selectedDocType?.typeId ?? ""}");
                            print("doc cate==>>${petProvider.docCateName}");
                            print("doc cate==>>${petProvider.docCateName}");
                          },
                          title: "",
                          value: null,
                        ),

                  ///*****

                  SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    tr(LocaleKeys.additionText_newDocumentTitle),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  CustomTextFeild(
                    textController: documentTitle,
                    textInputType: TextInputType.text,
                    hintText: tr(LocaleKeys.additionText_ntrDocTitle),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    tr(LocaleKeys.additionText_addDocs),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Consumer<PetProvider>(
                    builder: (context, petProvider, child) {
                      return GestureDetector(
                        onTap: () async {
                          if (widget.isNewDoc) {
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

                                if (Platform.isIOS) {
                                  fil = await getFile().then((value) {
                                    if (value != null) {
                                      return File(value.files.single.path ?? "");
                                    } else {
                                      return null;
                                    }
                                  });

                                  val = 3;
                                }

                                if (Platform.isAndroid) {
                                  var status = await Permission.manageExternalStorage.request();
                                  print("storage statur====${status}");
                                  if (status.isDenied) {
                                    Permission.manageExternalStorage.request();
                                  } else if (status.isPermanentlyDenied || status.isRestricted) {
                                    Permission.manageExternalStorage.request();
                                    //  openAppSettings();
                                  } else if (status.isGranted) {
                                    fil = await getFile().then((value) {
                                      if (value != null) {
                                        return File(value.files.single.path ?? "");
                                      } else {
                                        return null;
                                      }
                                    });
                                  }
                                  val = 3;
                                }
                              }
                              if (fil != null) {
                                print("value==${fil}");
                                if (fil.toString() == "File: ''") {
                                  print("value like this===");
                                  fil = null;
                                }
                              }

                              if (fil != null) {
                                PetProvider petProvide = Provider.of(context, listen: false);
                                petProvider.addDocFile(fil!, val);
                              }
                            }));
                          } else {
                            // {
                            String url = petProvider.selectedDocument?.docUrls ?? "";
                            if (url.isNotEmpty) {
                              if (url.split(".").last == "pdf") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PreviewFullImage2(
                                              isImage: false,
                                              docUrl: url,
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PreviewFullImage2(
                                              isImage: true,
                                              docUrl: url,
                                            )));
                              }
                            }
                            // },
                          }
                        },

                        // async {
                        //     File? file= await getFile().then((value) {
                        //       print("OKOKOKOKTEST!! $value");
                        //       if(value!=null)
                        //       {return File(value.files.single.path??"");}
                        //           else{
                        //             return null;
                        //           }
                        //     });
                        //     if(file!= null){
                        //       PetProvider petProvider = Provider.of(context,listen: false);
                        //       petProvider.addDocFile(file);
                        //       // print("FILEEEPDFF $file");
                        //       // String extension= file.path.split(".").last;
                        //       // if(extension=="pdf" || extension=="doc" || extension=="docx"){
                        //       //   print("CORRECT FILE TYPE");
                        //       // }else{
                        //       //   print("INCORRECT FILE TYPE");
                        //       // }
                        //     }
                        // },

                        child: Container(
                          height: 112,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration:
                              BoxDecoration(color: AppColor.textFieldGrey, borderRadius: BorderRadius.circular(15.0)),
                          child:
                              // {
                              // String url = petProvider.selectedDocument?.docUrls??"";
                              // if(url.isNotEmpty && !widget.isNewDoc){
                              // if(url.split(".").last == "pdf"){
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>    PreviewFullImage2(isImage: false,docUrl: url,)));
                              // }else{
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>    PreviewFullImage2(isImage: true,docUrl: url,)));
                              // }
                              // }
                              // },

                              Container(
                            height: 112,
                            width: MediaQuery.of(context).size.width * .9,
                            child: DottedBorder(
                                color: AppColor.textLightBlueBlack,
                                strokeWidth: 1,
                                dashPattern: [10, 4],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(15.0),
                                child: !widget.isNewDoc
                                    ? docUrll.split(".").last == "pdf"
                                        ? Container(
                                            height: 112,
                                            width: MediaQuery.of(context).size.width * .9,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Image.asset(
                                                  "assets/images/upload-file.png",
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("${docUrll.split('/').last}")
                                              ],
                                            ))

                                        // IgnorePointer(ignoring: true,
                                        //   child: PDF(
                                        //               swipeHorizontal: false,
                                        //             ).cachedFromUrl(
                                        //               petProvider.selectedDocument?.docUrls ??
                                        //                   "",),
                                        // ),

                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl: petProvider.selectedDocument?.docUrls ?? "",
                                              fit: BoxFit.cover,
                                              height: 168,
                                              width: MediaQuery.of(context).size.width * .9,
                                              placeholder: (context, url) => Image.asset(
                                                AppImage.doctorImg,
                                                fit: BoxFit.cover,
                                                height: 168,
                                                width: MediaQuery.of(context).size.width * .9,
                                              ),
                                              errorWidget: (context, url, error) => Image.asset(
                                                AppImage.doctorImg,
                                                fit: BoxFit.cover,
                                                height: 168,
                                                width: MediaQuery.of(context).size.width * .9,
                                              ),
                                            ),
                                          )
                                    : Stack(
                                        children: [
                                          Center(
                                            child: InkWell(
                                              //  onTap: () async {},
                                              child: petProvider.docFile != null
                                                  ? petProvider.docFileType == 3
                                                      ? Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/upload-file.png",
                                                              height: 60,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text("${petProvider.docFile?.path.split('/').last}")
                                                          ],
                                                        )
                                                      : ClipRRect(
                                                          borderRadius: BorderRadius.circular(15),
                                                          child: Container(
                                                            height: 112,
                                                            width: MediaQuery.of(context).size.width * .9,
                                                            child: Image.file(petProvider.docFile!, fit: BoxFit.cover),
                                                          ),
                                                        )
                                                  : Image.asset(AppImage.uploadIcon),
                                            ),
                                          ),
                                          petProvider.docFile != null
                                              ? Positioned(
                                                  right: 5,
                                                  top: 5,
                                                  child: InkWell(
                                                      onTap: () {
                                                        petProvider.removedocFile();
                                                      },
                                                      child: Icon(Icons.close)))
                                              : SizedBox()
                                        ],
                                      )),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),

                  Text(
                    tr(LocaleKeys.additionText_issued),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now())
                            .then((value) {
                          print("******------${value}-----******");
                          //issueDate.text =dateConverter(int.parse(value.toString()));
                          var date = DateTime.parse(value.toString());

                          date = date.add(Duration(hours: 5, minutes: 30));
                          timestampGmt = date.millisecondsSinceEpoch.toString();
                          print("TIMESTAMPP ${timestampGmt}");
                          print("GMTGMT ${DateTime.now().millisecondsSinceEpoch}");
                          issueDate.text = dateConverter(int.parse(timestampGmt));
                          //Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); /
                        });
                      },
                      child: CustomTextFeild(
                        isEnabled: false,
                        textInputType: TextInputType.none,
                        textController: issueDate,
                        hintText: tr(LocaleKeys.additionText_selDocIssueDate),
                      )),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    children: [
                      Container(
                        width: 265,
                        // color: Colors.blue,
                        child: Text(
                          tr(LocaleKeys.additionText_displayPetPublic),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                      ),
                      new Spacer(),
                      AdvancedSwitch(
                        controller: Switchcontroller,
                        activeColor: AppColor.textRed,
                        inactiveColor: Colors.black12,
                        borderRadius: BorderRadius.all(const Radius.circular(4)),
                        width: 38.0,
                        height: 16.0,
                        enabled: true,
                        disabledOpacity: 0.5,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 100.0,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: customBlueButton(
                  context: context,
                  text1: !widget.isNewDoc ? tr(LocaleKeys.ownerProfile_update) : tr(LocaleKeys.additionText_save),
                  onTap1: () {
                    PetProvider p = Provider.of(context, listen: false);

                    print("switch output========${Switchcontroller.value}");
                    Switchcontroller.value ? print("value is 1  ") : print("value is 0");
                    Switchcontroller.value ? v1 = 1 : v1 = 2;
                    print("vale of v1========= ${v1}");
                    print("print to check");
                    if (!widget.isNewDoc) {
                      if (timestampGmt.isEmpty) {
                        timestampGmt = "";
                      }
                      if (documentTitle.text.trim().isEmpty) {
                        documentTitle.text = "";
                      }

                      p.petDocumentEdit(
                          context: context, time: timestampGmt, name: documentTitle.text.trim(), filetype: v1);
                    } else {
                      if (issueDate.text.isNotEmpty && p.docFile != null && documentTitle.text.trim().isNotEmpty) {
                        p.callAddDocumentV2
                            // p.callAddDocument
                            (
                                docDate: timestampGmt,
                                doctitle: documentTitle.text.trim(),
                                context: context,
                                filetype: v1);
                      } else {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_entrAllFeilds));
                      }
                    }
                  },
                  colour: AppColor.newBlueGrey),
            ),
            BotttomBorder(context)
          ],
        ),
      ),
    );
  }
}

Future bottomSheetFile(
  BuildContext context, {
  required Function(int val) callBack,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
          height: 250,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                tr(LocaleKeys.additionText_chooseDocumentFile),
                textAlign: TextAlign.left,
                style:
                    TextStyle(fontSize: 20.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsRegular),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  callBack(1);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 42,
                        child: Image.asset(AppImage.cameraImg),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        tr(LocaleKeys.additionText_camera),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsRegular),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  callBack(2);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        child: Image.asset(AppImage.galleryImg),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        tr(LocaleKeys.additionText_gellery),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsRegular),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  callBack(3);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 42,
                        child: Image.asset(AppImage.fileicon),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        tr(LocaleKeys.additionText_file),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsRegular),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ));
    },
  );
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return "${Jiffy(d).format("dd MMM yyyy ")}".toUpperCase();
  // +
  //    "${Jiffy(d).jm}";
}
