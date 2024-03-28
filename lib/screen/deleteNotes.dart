import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/customSmallBlueButton.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/editNotes.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../components/previewFullImage.dart';
import '../generated/locale_keys.g.dart';
import '../util/app_images.dart';

class DeleteNotes extends StatefulWidget {
  const DeleteNotes({Key? key}) : super(key: key);

  @override
  State<DeleteNotes> createState() => _DeleteNotesState();
}

class _DeleteNotesState extends State<DeleteNotes> {
  @override
  var reac;
  String str = "";

  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);

    var v1 = petProvider.selectedNotes?.createdDateTimeStamp ?? "0";

    print("=======${petProvider.selectedNotes!.image.length}");
    print("=======${petProvider.selectedNotes?.petId}");

    print("*******************");
    print("***** drug****** ${petProvider.selectedNotes?.drug ?? ""}");

    str = petProvider.selectedNotes?.drug ?? "";
    petProvider.NotesImgEdit();

    // print("======img=== ${petProvider.selectedNotes?.image.length}");
    // print("======img=== ${petProvider.selectedNotes?.image[0].url}");
    // print("======img=== ${ petProvider.selectedNotes?.image[0].url?.split(".").last}");

    print("values of reaction==== > ${petProvider.selectedNotes?.reaction ?? 0}");
    switch (petProvider.selectedNotes?.reaction ?? 0) {
      case 1:
        reac = tr(LocaleKeys.additionText_positive);
        break;
      case 2:
        reac = tr(LocaleKeys.additionText_negative);
        break;
      case 3:
        reac = tr(LocaleKeys.additionText_unknown);
        break;
      default:
        reac = tr(LocaleKeys.additionText_unknown);
        break;
    }
    print("value of reac==== > $reac");
  }

  @override
  Widget build(BuildContext context) {
    PetProvider petProvider = Provider.of(context, listen: false);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
            Expanded(
                flex: 40,
                child: customSmallBlueButton(
                    colour: AppColor.newGrey,
                    context: context,
                    onTap1: () {
                      showDialog(
                          context: context,
                          builder: (context1) {
                            return AlertDialog(
                              title: Text(tr(LocaleKeys.additionText_uSureUwannaDelNote)),
                              actions: <Widget>[
                                InkWell(
                                  child: Text(
                                    tr(LocaleKeys.additionText_cancel),
                                    style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context1);
                                  },
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  child: Text(
                                    tr(LocaleKeys.additionText_yes),
                                    style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context1);
                                    petProvider.deleteNotesApiCall(
                                        context: context, idddd: petProvider.selectedNotes?.id ?? 0);
                                  },
                                )
                              ],
                            );
                          });
                    },
                    text1: tr(LocaleKeys.additionText_Delete))),
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
            Expanded(
                flex: 40,
                child: customSmallBlueButton(
                    colour: AppColor.newBlueGrey,
                    context: context,
                    onTap1: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditNotes()));
                    },
                    text1: tr(LocaleKeys.additionText_Edit)
                    // "EDIT"
                    ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: BotttomBorder(context),
      appBar: CustomCurvedAppbar(
        title: "",
        // isbackbutton: true,
      ),
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.87,
          minChildSize: 0.79,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Consumer<PetProvider>(builder: (context, petProvider, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              // radius: 50,
                              child: CachedNetworkImage(
                                imageUrl: petProvider.selectedNotes?.petPhoto ?? "",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    AppImage.placeholderIcon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    AppImage.placeholderIcon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   left: 65.0,
                          //   top: 0,
                          //   child: InkWell(
                          //     child: ClipRRect(
                          //       child: Image.asset(AppImage.greenCheckIcon),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Center(
                      child: Text(
                        petProvider.selectedNotes?.petName ?? "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColor.textLightBlueBlack,
                                  radius: 6.26,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(tr(LocaleKeys.additionText_notesTitle),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinSemibold)),
                                Text(petProvider.selectedNotes?.title ?? "",
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinSemibold)),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColor.textLightBlueBlack,
                                radius: 6.26,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                tr(LocaleKeys.additionText_notesCate),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                              Text(
                                petProvider.selectedNotes?.notesCatagoriesName ?? "",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8.0,
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColor.textLightBlueBlack,
                                  radius: 6.26,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  tr(LocaleKeys.additionText_notesType),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinSemibold),
                                ),
                                Text(
                                  petProvider.selectedNotes?.notesCatagoriesTypesName ?? "",

                                  // maxLines: 5,
                                  // softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinSemibold),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 12.0,
                          ),

                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColor.textLightBlueBlack,
                                radius: 6.26,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                dayConverter(int.parse(petProvider.selectedNotes?.createdDateTimeStamp ?? "0")),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                              Text(
                                dateConverter(int.parse(petProvider.selectedNotes?.createdDateTimeStamp ?? "0")),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                              Text(
                                timeConverter(int.parse(petProvider.selectedNotes?.createdDateTimeStamp ?? "0")),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 12.0,
                          ),

                          str.isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: AppColor.textLightBlueBlack,
                                        radius: 6.26,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${tr(LocaleKeys.additionText_aDrug)} : ",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinSemibold),
                                      ),
                                      Text(
                                        " ${petProvider.selectedNotes?.drug ?? ""}",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinSemibold),
                                      ),
                                    ],
                                  ),
                                ),

                          // Text(
                          //   tr(LocaleKeys.additionText_aDrug)+ " : ${petProvider.selectedNotes?.drug ?? ""}",
                          //   textAlign: TextAlign.left,
                          //   style: TextStyle(
                          //       fontSize: 12.0,
                          //       color: AppColor.textLightBlueBlack,
                          //       fontFamily: AppFont.poppinsMedium),
                          // ),

                          str.isEmpty
                              ? const SizedBox()
                              : const SizedBox(
                                  height: 10.0,
                                ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColor.textLightBlueBlack,
                                  radius: 6.26,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${tr(LocaleKeys.additionText_reaction)} : ",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinSemibold),
                                ),
                                Text(
                                  "$reac",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinSemibold),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            tr(LocaleKeys.additionText_atachFile),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),

                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(6),
                          //   child: fileType == "pdf"
                          //       ? Container(
                          //       color: AppColor.textFieldGrey,
                          //       height: 168,
                          //       width: MediaQuery.of(context).size.width *
                          //           .90,
                          //       child: Column(
                          //         children: [
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           Image.asset(
                          //             "assets/images/upload-file.png",
                          //             height: 70,
                          //           ),
                          //           SizedBox(
                          //             height: 10,
                          //           ),
                          //           Text("${docUrl.split('/').last}")
                          //         ],
                          //       )
                          //     //   PDF(
                          //     //   swipeHorizontal: true,
                          //     // ).cachedFromUrl(docUrl),
                          //   )
                          //       :

                          Consumer<PetProvider>(builder: (context, petProvider, child) {
                            List noteImg = petProvider.selectedNotes?.image ?? [];

                            return noteImg.isNotEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    height: 150,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: noteImg.length,
                                        itemBuilder: (context, index) {
                                          if (noteImg[index].halfUrl.split("/")[0] == "Others") {
                                            print("inside this");
                                            var newUrl;
                                            newUrl = noteImg[index].halfUrl;
                                            print("inside newUrl=====$newUrl");
                                            noteImg[index].halfUrl = noteImg[index].url;
                                            noteImg[index].url = newUrl;
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 12.0),
                                            child: InkWell(
                                              onTap: () {
                                                print("*************++++++++++++");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PreviewFullImage2(
                                                              // docUrl: noteImg[index].url,
                                                              docUrl: noteImg[index].halfUrl,
                                                              isImage: noteImg[index].url?.split(".").last == "pdf"
                                                                  ? false
                                                                  : true,
                                                            )));
                                                print("*************++++++++++++");
                                                print("***print half url*+++++++${noteImg[index].halfUrl}");
                                                print("***print  url*+++++++${noteImg[index].url}");
                                                // print("***print  url*+++++++${noteImg[index].url}");
                                                print("resultlength  ${noteImg[index].halfUrl.split("/")[0]}");
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius: BorderRadius.circular(15.0),
                                                  ),
                                                  height: 130,
                                                  width: 100,
                                                  child: noteImg[index].url?.split(".").last == "pdf"
                                                      ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Container(
                                                              color: AppColor.textFieldGrey,
                                                              height: 125,
                                                              width: 115,
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
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
                                                                    Text("${noteImg[index].url.split('/').last}")
                                                                  ],
                                                                ),
                                                              )),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: CachedNetworkImage(
                                                            // imageUrl: noteImg[index].url,
                                                            imageUrl: noteImg[index].halfUrl,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context, url) => Padding(
                                                              padding: const EdgeInsets.all(0.0),
                                                              child: Image.asset(
                                                                AppImage.doctorImg,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                            errorWidget: (context, url, error) => Padding(
                                                              padding: const EdgeInsets.all(0.0),
                                                              child: Image.asset(
                                                                AppImage.doctorImg,
                                                                // noteImg[index].halfUrl,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                            ),
                                          );
                                        }),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 88.0),
                                    child: Center(
                                        child: Text(
                                      tr(LocaleKeys.additionText_noFileFound),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinSemibold),
                                    )),
                                  );
                          }),

                          const SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 120.0,
                    )
                  ],
                ),
              );
            });
          }),
    );
  }
}

String dateConverter(
  int date,
) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return Jiffy(d).format("dd-MMM-yyyy ").toUpperCase();
}

String dateConverter2(
  DateTime date,
) {
  return Jiffy(date).format("d-MMM-yyyy ").toUpperCase();
}

String timeConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return Jiffy(d).format("HH:mm a").toUpperCase();
}

String dayConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return Jiffy(d).format("EEEE, ").toUpperCase();
}
