import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/previewFullImage.dart';
import '../generated/locale_keys.g.dart';
import '../models/documentdetailmodel.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'newDocument.dart';

class EditDocument extends StatefulWidget {
  String dateIssued;
  EditDocument({Key? key, required this.dateIssued}) : super(key: key);

  @override
  State<EditDocument> createState() => _EditDocumentState();
}

class _EditDocumentState extends State<EditDocument> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  final Switchcontroller = ValueNotifier<bool>(true);

  Future<File> imageConverter(String imgUrl) async {
    // storyProvider.updateLoader(true);
    http.Response responseData = await http.get(Uri.parse(imgUrl));
    Uint8List uint8list = responseData.bodyBytes;
    var dir = (await getApplicationDocumentsDirectory()).path;
    File imageFile = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    imageFile.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print("path of img file ${imageFile.path}");
    // storyProvider.updateLoader(false);
    return imageFile;
  }

  @override
  void initState() {}

  DocumentDetails? selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: const Padding(
      //   padding: EdgeInsets.only(left: 22.0),
      //   child: BotttomBorder(context),
      // ),

      // bottomNavigationBar: BotttomBorder(context),
      backgroundColor: Colors.white,
      appBar: CustomCurvedAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Consumer<PetProvider>(
          builder: (context, petProvider, child) {
            var petImage = petProvider.selectedPetDetail?.petPhoto ?? "";
            var docUrl = petProvider.selectedDocument?.docUrls ?? "";

            print("docUrldocUrl${petProvider.selectedDocument?.fileType}");
            print("docUrldocUrl${petProvider.selectedDocument?.documentCategoryId}");

            print("*******-------$docUrl");
            var fileType = docUrl.isNotEmpty ? docUrl.split(".").last : "";
            print("FILE TYPE  $fileType");
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
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColor.textFieldGrey),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              // radius: 50,
                              child: CachedNetworkImage(
                                imageUrl: petImage,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Image.asset(
                                    AppImage.placeholderIcon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Image.asset(
                                    AppImage.placeholderIcon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 65.0,
                            top: 0,
                            child: InkWell(
                              child: ClipRRect(
                                child: Image.asset(AppImage.greenCheckIcon),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5.0,
                    ),

                    Center(
                      child: Text(
                        petProvider.selectedPetDetail?.petName ?? "",
                        softWrap: false,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                      ),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Image(image: AssetImage(AppImage.goldenRetriever)),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * .75,
                    //         child: Text("",
                    //           // petProvider.selectedDocument?.title ?? "",
                    //           maxLines: 5,
                    //           //   overflow: TextOverflow.visible,
                    //           softWrap: true,
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(
                    //               fontSize: 15.0,
                    //               color: AppColor.textLightBlueBlack,
                    //               fontFamily: AppFont.poppinsMedium),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),

                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "${tr(LocaleKeys.additionText_docName)} : ",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontFamily: AppFont.poppinSemibold,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: petProvider.selectedDocument?.title ?? "",
                        style: const TextStyle(
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsMedium,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ])),

                    const SizedBox(
                      height: 5,
                    ),

                    Consumer<PetProvider>(builder: (context, petProvider, child) {
                      return RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "${tr(LocaleKeys.additionText_docCate)} : ",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontFamily: AppFont.poppinSemibold,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: " ${petProvider.docCateName}",
                          style: const TextStyle(
                              color: AppColor.textLightBlueBlack,
                              fontFamily: AppFont.poppinsMedium,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ]));
                    }),

                    // Container(
                    //   width: MediaQuery.of(context).size.width * .75,
                    //   child: Text(
                    //     "Document Name"+ " : ${ petProvider.selectedDocument?.title ?? ""}",
                    //     maxLines: 5,
                    //     softWrap: true,
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         fontSize: 14.0,
                    //         color: AppColor.textLightBlueBlack,
                    //         fontFamily: AppFont.poppinsMedium),
                    //   ),
                    // ),

                    // Text(
                    //   "Document Category"+ " : ${  petProvider.docCateName}",
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(
                    //       fontSize: 14.0,
                    //       color: AppColor.textLightBlueBlack,
                    //       fontFamily: AppFont.poppinsMedium),
                    // ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    Center(
                      child: SizedBox(
                          height: 168,
                          width: MediaQuery.of(context).size.width * .90,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: fileType == "pdf"
                                    ? Container(
                                        color: AppColor.textFieldGrey,
                                        height: 168,
                                        width: MediaQuery.of(context).size.width * .90,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                              "assets/images/upload-file.png",
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(docUrl.split('/').last)
                                          ],
                                        ))

                                    //   PDF(
                                    //   swipeHorizontal: true,
                                    // ).cachedFromUrl(docUrl),

                                    : CachedNetworkImage(
                                        imageUrl: petProvider.selectedDocument?.docUrls ?? "",
                                        fit: BoxFit.cover,
                                        height: 168,
                                        width: MediaQuery.of(context).size.width * .90,
                                        placeholder: (context, url) => Image.asset(
                                          AppImage.doctorImg,
                                          fit: BoxFit.fill,
                                          height: 168,
                                          width: MediaQuery.of(context).size.width * .90,
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          AppImage.doctorImg,
                                          fit: BoxFit.fill,
                                          height: 168,
                                          width: MediaQuery.of(context).size.width * .90,
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  print("*************++++++++++++");
                                  print("//${petProvider.selectedDocument?.docUrls ?? ""}");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PreviewFullImage2(
                                                docUrl: petProvider.selectedDocument?.docUrls ?? "",
                                                isImage: fileType != "pdf",
                                              )));
                                  print("*************++++++++++++");
                                },
                                child: SizedBox(
                                  height: 167,
                                  width: MediaQuery.of(context).size.width * .84,
                                ),
                              )
                            ],
                          )),
                    ),
                    // Center(
                    //   child: Image(image: AssetImage(AppImage.doctorImg)),
                    // ),
                    const SizedBox(height: 15.0),

                    Text(
                      "${tr(LocaleKeys.additionText_issued)} :${dateConverter(int.parse(petProvider.selectedDocument?.issuedDate ?? ""))}",
                      //"Issued :${dateConverter(int.parse(widget.dateIssued))}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 10.0, color: AppColor.textGreyColor, fontFamily: AppFont.poppinsRegular),
                    ),

                    Text(
                      "${tr(LocaleKeys.additionText_downloded)} :${dateConverter(int.parse(petProvider.selectedDocument?.createdDate ?? ""))}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 10.0, color: AppColor.textGreyColor, fontFamily: AppFont.poppinsRegular),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    Consumer<PetProvider>(builder: (context, petProvider, child) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 265,
                            child: Text(
                              tr(LocaleKeys.additionText_displayPetPublic),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinSemibold),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                          ),
                          const Spacer(),

                          // petProvider.selectedDocument?.fileType==1 ?
                          Consumer<PetProvider>(builder: (context, petProvider, child) {
                            return Container(
                              child: petProvider.selectedDocument?.fileType == 1
                                  ? Image.asset(AppImage.buttonOn)
                                  : Image.asset(AppImage.buttonOff),
                            );
                          })
                          // Image.asset(AppImage.buttonOn)
                          // :
                          // Image.asset(AppImage.buttonOff)
                        ],
                      );
                    }),

                    // Row(
                    //   children: [
                    //     Text(
                    //       AppStrings.disOnPetPubPro,
                    //       textAlign: TextAlign.left,
                    //       style: TextStyle(
                    //           fontSize: 14.0,
                    //           color: AppColor.textLightBlueBlack,
                    //           fontFamily: AppFont.poppinSemibold),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(),
                    //     ),
                    //         new Spacer(),
                    //
                    //
                    //
                    //     //   AdvancedSwitch(
                    //     //   controller: Switchcontroller,
                    //     //   activeColor: AppColor.textRed,
                    //     //   inactiveColor: Colors.black12,
                    //     //   borderRadius: BorderRadius.all(const Radius.circular(4)),
                    //     //   width: 38.0,
                    //     //   height: 16.0,
                    //     //   enabled: true,
                    //     //   disabledOpacity: 0.5,
                    //     //
                    //     //
                    //     // ),
                    //
                    //
                    //     Image.asset(AppImage.buttonOn),
                    //     SizedBox(width: 5),
                    //     Image.asset(AppImage.buttonOff)
                    //
                    //
                    //
                    //   ],
                    // ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    Text(
                      tr(LocaleKeys.additionText_docUserView),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: AppFont.poppinsRegular),
                    ),

                    const SizedBox(
                      height: 50.0,
                    ),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              petProvider.loaderUpdate(true);
                              if (docUrl.split(".").last == "pdf") {
                                petProvider.loaderUpdate(false);
                                Share.share(docUrl);
                              } else {
                                File file = await imageConverter(docUrl.toString());
                                petProvider.loaderUpdate(false);
                                // Share.shareFiles(['${file.path}'], text: 'Image');

                                Share.shareFiles([file.path]);
                                //  Share.shareXFiles([XFile(file.path)]);

                                //   Share.shareWithResult(file.path);
                                //    Share.share(file.toString());
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(image: AssetImage(AppImage.shareIcon)),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  tr(LocaleKeys.additionText_share),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.black, fontFamily: AppFont.poppinsRegular),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewDocument(
                                            isNewDoc: false,
                                          )));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(image: AssetImage(AppImage.doc_edit)),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  tr(LocaleKeys.additionText_edit),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.black, fontFamily: AppFont.poppinsRegular),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context1) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        title: Text(tr(LocaleKeys.additionText_sureDelete)),
                                        actions: <Widget>[
                                          InkWell(
                                            child: Text(
                                              tr(LocaleKeys.additionText_cancel),
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: AppFont.poppinsMedium,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context1);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          InkWell(
                                            child: Text(
                                              tr(LocaleKeys.additionText_yes),
                                              style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                            ),
                                            onTap: () async {
                                              PetProvider pet = Provider.of(context1, listen: false);
                                              await pet.deleteDocument(context1);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(image: AssetImage(AppImage.delete_doc)),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  tr(LocaleKeys.additionText_Delete),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.black, fontFamily: AppFont.poppinsRegular),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return Jiffy(d).format("dd MMM yyyy ").toUpperCase();
  // +
  //    "${Jiffy(d).jm}";
}
