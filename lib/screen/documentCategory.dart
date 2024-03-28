import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/editdocuments.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/docCategoryContainer.dart';
import '../generated/locale_keys.g.dart';
import '../models/documentdetailmodel.dart';
import '../util/app_font.dart';

class DocumentCategory extends StatefulWidget {
  const DocumentCategory({Key? key}) : super(key: key);

  @override
  State<DocumentCategory> createState() => _DocumentCategoryState();
}

class _DocumentCategoryState extends State<DocumentCategory> {
  late PetProvider petProvider1;
  @override
  void initState() {
    petProvider1 = Provider.of(context, listen: false);

    // petProvider1.callGetDoc();         //p1 part
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(builder: (context, petProvider, child) {
      List<DocumentDetails> docList = petProvider.documentList;
      return Scaffold(
        // bottomNavigationBar: BotttomBorder(context),
        backgroundColor: Colors.white,
        appBar: CustomCurvedAppbar(
          title:
              // AppStrings.docCategory,
              petProvider1.docCateName,
          isTitleCenter: true,
          //  isbackbutton: true,
        ),
        body: docList.isEmpty && !petProvider.loaderlisten
            ? Center(
                child: Text(
                  tr(LocaleKeys.additionText_noDocumentsFind),
                  style: const TextStyle(
                      fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount: docList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          petProvider.setSelectedDocuments(docList[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDocument(
                                        dateIssued: docList[index].issuedDate ?? "",
                                      )));
                        },
                        child: DocumentCategoryContainer(context, docList[index]));
                  },
                ),
              ),

        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: Consumer<PetProvider>(
        //   builder: (context,petProvider,child) {
        //     return Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //
        //         Padding(
        //           padding: const EdgeInsets.only(bottom: 0.0),
        //           child:
        //           petProvider.documentList.length>=2 && petProvider.isUserPremium==0? SizedBox():
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               FloatingActionButton(
        //                   child: Icon(Icons.add),
        //                   backgroundColor: AppColor.textLightBlueBlack,
        //                   onPressed: () {
        //                     Navigator.push(context, MaterialPageRoute(builder: (context) => NewDocument(isNewDoc: true,)));
        //                   }),
        //             ],
        //           )
        //
        //         ),
        //
        //         BotttomBorder(context),
        //       ],
        //     );
        //   }
        // )
      );
    });
  }
}
