import 'dart:async';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/customBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../components/shortpage.dart';
import '../../provider/petprovider.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/color.dart';

class Mydocument extends StatefulWidget {
  const Mydocument({Key? key}) : super(key: key);

  @override
  State<Mydocument> createState() => _NewDocumentState();
}

class _NewDocumentState extends State<Mydocument> {
  TextEditingController chooseCategory = TextEditingController();
  TextEditingController documentTitle = TextEditingController();
  TextEditingController issueDate = TextEditingController();
  String timestampGmt = "";
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  @override
  void initState() {
    PetProvider pet = Provider.of(context, listen: false);
    pet.docFile = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          return Center(
            child: GestureDetector(
              onTap: () async {
                int val = 0;
                File? fil;
                await bottomSheetFile(context, callBack: ((val) async {
                  if (val == 1) {
                    Navigator.pop(context);
                    fil = await getImage(ImageSource.camera);
                    val = 1;
                  } else if (val == 2) {
                    Navigator.pop(context);
                    fil = await getImage(ImageSource.gallery);
                    val = 2;
                  } else if (val == 3) {
                    Navigator.pop(context);
                    fil = await getFile().then((value) {
                      if (value != null) {
                        return File(value.files.single.path ?? "");
                      } else {
                        return null;
                      }
                    });
                    val = 3;
                  }
                  if (fil != null) {



                    PetProvider petProvide =
                        Provider.of(context, listen: false);
                    petProvider.addDocFile(fil!, val);
                  }
                }));
              },
              child: Container(
                color: AppColor.textFieldGrey,
                height: 112,
                width: MediaQuery.of(context).size.width * .9,
                child: DottedBorder(
                  color: AppColor.textLightBlueBlack,
                  strokeWidth: 1,
                  dashPattern: [10, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15.0),
                  child: Center(
                    child: InkWell(
                      onTap: () async {},
                      child: petProvider.docFile != null
                          ? petProvider.docFileType == 3
                              ? PDFView(
                                  filePath: petProvider.docFile?.path ?? "",
                                  enableSwipe: true,
                                  swipeHorizontal: true,
                                  autoSpacing: false,
                                  pageFling: false,
                                  onRender: (_pages) {
                                    // setState(() {
                                    //   pages = _pages;
                                    //   isReady = true;
                                    // });
                                  },
                                  onError: (error) {
                                    print(error.toString());
                                  },
                                  onPageError: (page, error) {
                                    print('$page: ${error.toString()}');
                                  },
                                  onViewCreated:
                                      (PDFViewController pdfViewController) {
                                    _controller.complete(pdfViewController);
                                  },
                                )
                              : Image.file(petProvider.docFile!)
                          : Image.asset(AppImage.uploadIcon),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      Center(
          child: customBlueButton(
              context: context,
              text1:tr(LocaleKeys.additionText_save),
              onTap1: () {
                PetProvider p = Provider.of(context, listen: false);
                if (issueDate.text.isNotEmpty &&
                    p.docFile != null &&
                    documentTitle.text.isNotEmpty) {
                  // p.callAddDocument(
                  //     docDate: timestampGmt,
                  //     doctitle: documentTitle.text,
                  //     context: context);
                } else {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text: tr(LocaleKeys.additionText_entrAllFeilds));
                }
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DocumentCategory()));
              },
              colour: AppColor.newBlueGrey))
    ]));
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
                style: TextStyle(
                    fontSize: 20.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinsRegular),
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
                            fontSize: 18.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsRegular),
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
                            fontSize: 18.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsRegular),
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
                        // tr(LocaleKeys.additionText_camera),
                        "File",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsRegular),
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
