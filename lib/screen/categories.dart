import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/components/greyContinerWidCircle.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/documentCategory.dart';
import 'package:find_me/screen/newDocument.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/appstrings.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/commingSoonAlert.dart';
import '../components/makePetprem.dart';
import '../generated/locale_keys.g.dart';
import 'dashboard.dart';
import 'home.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);

    petProvider.cateId = "";
    // petProvider.GetDocV2();

    print("petProvider.documentList.length===${petProvider.documentList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCurvedAppbar(
          // isbackbutton: true,
          title: tr(LocaleKeys.additionText_categories),
          isTitleCenter: true,
        ),
        backgroundColor: Colors.white,
        // bottomNavigationBar: BotttomBorder(context),
        body: Consumer<PetProvider>(builder: (context, petprovider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(2);
                            petprovider.setDocCateName(1);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_vetVisits),
                          image1: AppImage.healthCheck),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(3);
                            petprovider.setDocCateName(2);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_invoices),
                          image1: AppImage.newInvoice),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(4);
                            print("doc cate===>>> ${petprovider.cateId}");
                            petprovider.setDocCateName(3);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_vaccinations),
                          image1: AppImage.syringe),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(5);
                            petprovider.setDocCateName(4);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_labTests),
                          image1: AppImage.microscope),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(6);
                            petprovider.setDocCateName(5);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_businessCards),
                          image1: AppImage.newBusCard),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(7);
                            petprovider.setDocCateName(6);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_agreements),
                          image1: AppImage.newAgreement),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(8);
                            petprovider.setDocCateName(7);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_certificates),
                          image1: AppImage.newCertificate),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(9);
                            petprovider.setDocCateName(8);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_passport),
                          image1: AppImage.boardingPass),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(10);
                            petprovider.setDocCateName(9);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: AppStrings.pedigree,
                          image1: AppImage.newGoldDog),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GreyContainerWidCircle(
                          context: context,
                          onTap1: () {
                            petprovider.setDocCateId(1);
                            petprovider.setDocCateName(10);
                            petprovider.GetDocV2();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentCategory()));
                          },
                          text1: tr(LocaleKeys.additionText_others),
                          image1: AppImage.newMore),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 0, top: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<PetProvider>(builder: (context, petProvider, child) {
                  // return petProvider.documentList.length>=2 && petProvider.isUserPremium==0? SizedBox():
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: FloatingActionButton(
                            backgroundColor: AppColor.buttonPink,
                            onPressed: () {
                              print("*****");
                              print(petProvider.documentList.length);
                              print(petProvider.isUserPremium);
                              print("******");
                              if (petProvider.documentList.length >= 2 && petProvider.isUserPremium == 0) {
                                commingSoonDialog(context, isFullAccess: 1);
                              } else if (petProvider.isUserPremium == 1 &&
                                  petProvider.selectedPetDetail?.isPremium == 0 &&
                                  petProvider.documentList.length >= 2) {
                                makePetPremDialog(context);
                              } else if ((petProvider.isUserPremium == 1 &&
                                      petProvider.selectedPetDetail?.isPremium == 1) ||
                                  (petProvider.sharedPremIds.contains(petProvider.selectedPetDetail?.id))) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewDocument(
                                              isNewDoc: true,
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewDocument(
                                              isNewDoc: true,
                                            )));
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              size: 40,
                            )),
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 0,
                ),
                // BotttomBorder(context)
              ],
            )));
  }
}
