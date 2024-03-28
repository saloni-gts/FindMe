import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/monish/models/newModel.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/provider/purchase_provider.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../components/premiumList.dart';
import '../../generated/locale_keys.g.dart';
import '../../screen/signUpScreen.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import 'morrefeature39.dart';

class BuyPremium extends StatefulWidget {
  const BuyPremium({Key? key}) : super(key: key);

  @override
  State<BuyPremium> createState() => _BuyPremiumState();
}

class _BuyPremiumState extends State<BuyPremium> {
  List showList = [];
// var finPlanId;

  @override
  int isShowCurrentPlan = 0;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    PurChaseProvider purChaseProvider = Provider.of(context, listen: false);

    print("purChase show plan=======>${purChaseProvider.showPlan}");
    print("purChase plan=======>${purChaseProvider.plan}");

    PetProvider petProvider = Provider.of(context, listen: false);
    purChaseProvider.updateIsCalledApi(0);
    purChaseProvider.isFromInit(false);
    if (purChaseProvider.showPlan.isNotEmpty) {
      print("purChaseProvider.showPlan===${purChaseProvider.showPlan}");
    }

    // finPlanId= purChaseProvider.getPlanId();

    // selectedPlanList = petProvider.monthly;
    // petProvider.updateSelectedContainer(0);

    // print("plan list[0]=${purChaseProvider.plan[0]}");

    purChaseProvider.getSubScriptionDetails();

    if (purChaseProvider.planList.length == 2) {
      selectedPlanList = petProvider.yearly;
    }

    if (purChaseProvider.showPlan.isEmpty) {
      selectedPlanList = petProvider.monthly;
      petProvider.updateSelectedContainer(0);
      purChaseProvider.setPlanVal(0);
    } else {
      // if(purChaseProvider.planList.length==1 && purChaseProvider.planList[0].isPrremium==1) {
      if (purChaseProvider.showPlan[0] == 0) {
        selectedPlanList = petProvider.monthly;
      } else if (purChaseProvider.showPlan[0] == 1) {
        selectedPlanList = petProvider.yearly;
      } else if (purChaseProvider.showPlan[0] == 2) {
        selectedPlanList = petProvider.family;
      }
    }
    if (purChaseProvider.plan.isNotEmpty) {
      purChaseProvider.setPlanVal(1);
    }

    if (purChaseProvider.showYrlyList == 1) {
      selectedPlanList = petProvider.yearly;
    }

    if (purChaseProvider.plan.isEmpty) {
      print("this this condition checking");
      selectedPlanList = petProvider.monthly;
      petProvider.updateSelectedContainer(0);
    }

    // print("value of value ====${purChaseProvider.CheckPurchased}");
    super.initState();
  }

  @override
  List<int> selectedPlanList = [];

  List<premiumPlans> premiumPlanLangList = [
    premiumPlans(name: tr(LocaleKeys.additionText_premPet4), id: 1, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_PicsDocs), id: 2, isSelected: true, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_WeitTrkr), id: 3, isSelected: false, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_chkPrt), id: 4, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_freQRtgDilv), id: 5, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_jntMgt), id: 10, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_shrWitFamMem), id: 3, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_smsNotiPtLst), id: 3, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_AddiContacts), id: 4, isSelected: false, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_cutmrPriSpt), id: 15, isSelected: true, showTick: 1),
  ];

  List<premiumPlans> premiumPlanLangList1 = [
    // // premiumPlans(
    // //     name: tr(LocaleKeys.additionText_ursUP21),
    // //     id: 1,
    // //     isSelected: true,
    // //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_smsNoti),
    //     id: 2,
    //     isSelected: false,
    //     showTick: 0),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_LifePetProfile),
    //     id: 3,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_AddiContacts),
    //     id: 4,
    //     isSelected: false,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_PicsDocs),
    //     id: 5,
    //     isSelected: true,
    //     showTick: 0),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_MsngrFBWhatsapp),
    //     id: 6,
    //     isSelected: false,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_MultiplePetProfile),
    //     id: 7,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_WeitTrkr),
    //     id: 8,
    //     isSelected: false,
    //     showTick: 1),
    // premiumPlans(
    //     name: ("${tr(LocaleKeys.additionText_freQrTgEvryYr)}" + "(1)"),
    //     id: 9,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_jntMgt),
    //     id: 10,
    //     isSelected: false,
    //     showTick: 0),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_addFamMem),
    //     id: 11,
    //     isSelected: true,
    //     showTick: 1),
    // // premiumPlans(name: "Premium Pets upto 4", isSelected: true, showTick: 1),
    // // premiumPlans(
    // //     name: "Premium Pets upto 4",
    // //     id: 12,
    // //     isSelected: true,
    // //     showTick: 1),
    // premiumPlans(
    //     name: "Customer priority support",
    //     id: 13,
    //     isSelected: true,
    //     showTick: 1),
    // // premiumPlans(
    // //     name: tr(LocaleKeys.additionText_Multilingual),
    // //     id: 12,
    // //     isSelected: false,
    // //     showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_premPet4), id: 1, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_PicsDocs), id: 2, isSelected: true, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_WeitTrkr), id: 3, isSelected: false, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_chkPrt), id: 4, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_freQRtgDilv), id: 5, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_jntMgt), id: 10, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_shrWitFamMem), id: 3, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_smsNotiPtLst), id: 3, isSelected: true, showTick: 1),

    premiumPlans(name: tr(LocaleKeys.additionText_AddiContacts), id: 4, isSelected: false, showTick: 1),

    premiumPlans(name: tr(LocaleKeys.additionText_cutmrPriSpt), id: 15, isSelected: true, showTick: 1),
  ];

  List<premiumPlans> premiumPlanLangList3 = [
    premiumPlans(name: tr(LocaleKeys.additionText_premPet4), id: 1, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_PicsDocs), id: 2, isSelected: true, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_WeitTrkr), id: 3, isSelected: false, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_chkPrt), id: 4, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_freQRtgDilv), id: 5, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_jntMgt), id: 10, isSelected: false, showTick: 0),
    premiumPlans(name: tr(LocaleKeys.additionText_shrWitFamMem), id: 3, isSelected: true, showTick: 1),
    premiumPlans(name: tr(LocaleKeys.additionText_smsNotiPtLst), id: 3, isSelected: true, showTick: 1),

    premiumPlans(name: tr(LocaleKeys.additionText_AddiContacts), id: 4, isSelected: false, showTick: 1),

    premiumPlans(name: tr(LocaleKeys.additionText_cutmrPriSpt), id: 15, isSelected: true, showTick: 1),

    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_ursUP21),
    //     id: 1,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_smsNoti),
    //     id: 2,
    //     isSelected: false,
    //     showTick: 0),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_LifePetProfile),
    //     id: 3,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_AddiContacts),
    //     id: 4,
    //     isSelected: false,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_PicsDocs),
    //     id: 5,
    //     isSelected: true,
    //     showTick: 0),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_MsngrFBWhatsapp),
    //     id: 6,
    //     isSelected: false,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_MultiplePetProfile),
    //     id: 7,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_WeitTrkr),
    //     id: 8,
    //     isSelected: false,
    //     showTick: 1),
    // premiumPlans(
    //     name: ("${tr(LocaleKeys.additionText_freQrTgEvryYr)}" + "(3)"),
    //     id: 9,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_jntMgt),
    //     id: 10,
    //     isSelected: false,
    //     showTick: 0),
    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_addFamMem),
    //     id: 11,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: "Premium Pets upto 4",
    //     id: 12,
    //     isSelected: true,
    //     showTick: 1),
    // premiumPlans(
    //     name: "Customer priority support",
    //     id: 13,
    //     isSelected: true,
    //     showTick: 1),
    ////

    // premiumPlans(
    //     name: tr(LocaleKeys.additionText_Multilingual),
    //     id: 12,
    //     isSelected: false,
    //     showTick: 1),
  ];

  List<newButton> permiumbutton = [
    newButton(name: tr(LocaleKeys.additionText_monthlyplan), id: 1, amount: "£3.99 "),
    newButton(name: tr(LocaleKeys.additionText_yearlyplan), id: 2, amount: "£35.99"),
    newButton(name: tr(LocaleKeys.additionText_familyplan), id: 3, amount: "£69.99"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomCurvedAppbar(
          // isbackbutton: true,
          title: tr(LocaleKeys.additionText_preminumplans),
          isTitleCenter: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Consumer<PurChaseProvider>(builder: (context, data, child) {
            bool isBtnDisable = false;
            try {
              isBtnDisable = data.planList[0].isBtnDisable == 1;
            } catch (e) {}
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  data.showPlan.isNotEmpty && isBtnDisable
                      ? const SizedBox()
                      : CustomButton(
                          // context: context,
                          text: data.ShowCurrentPlan == 1
                              ? tr(LocaleKeys.additionText_yrCurrentPln)
                              : tr(LocaleKeys.additionText_buypremium),
                          onPressed: () {
                            int selectedValue = data.selectedPlan;
                            print("selectedValue $selectedValue");
                            if (selectedValue == 0) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text: tr(LocaleKeys.additionText_plsChosePlan));
                              return;
                            }
                            data.updateIsRestor(false);
                            print("selected value $selectedValue");
                            switch (selectedValue) {
                              case 1:
                                manageSubScripion(context, planTypeEnum.month);
                                break;
                              case 2:
                                manageSubScripion(context, planTypeEnum.year);
                                break;
                              case 3:
                                manageSubScripion(context, planTypeEnum.family);
                                break;
                            }
                          },
                          // colour: AppColor.newBlueGrey
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer2<PurChaseProvider, PetProvider>(builder: (context, data, data2, child) {
                    return CustomButton(
                      // context: context,
                      text: tr(LocaleKeys.additionText_restorePrem),
                      onPressed: () async {
                        EasyLoading.show();
                        await data.getSubScriptionDetails().then((value) {
                          EasyLoading.dismiss();
                          if (data2.isUserPremium == 1) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: tr(LocaleKeys.additionText_planRestored),
                            );
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_noPlanByPlan),
                            );
                          }
                        });
                      },
                      // colour: AppColor.newBlueGrey
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.blue,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: tr(LocaleKeys.signUp_privacyPolicy),
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UrlViewer(
                                                webViewType: 1,
                                              )));
                                }),
                          TextSpan(
                              text: tr(LocaleKeys.signUp_terms),
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UrlViewer(
                                                webViewType: 2,
                                              )));
                                }),
                        ])),
                  ),

                  //   SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            );
          }),
        ),
        // bottomNavigationBar: BotttomBorder(context),
        body: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.87,
            minChildSize: 0.78,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer2<PetProvider, PurChaseProvider>(builder: (context, petProvider, purchase, child) {
                        return Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(permiumbutton.length, (i) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: InkWell(
                                      onTap: () {
                                        print("value of i======$i");
                                        petProvider.updateSelectedContainer(i);
                                        if (i == 0) {
                                          selectedPlanList = petProvider.monthly;
                                          print("seklecered plan  list$selectedPlanList");

                                          purchase.setPlanVal(purchase.plan.contains(i) ? 1 : 0);
                                        }
                                        if (i == 1) {
                                          selectedPlanList = petProvider.yearly;
                                          purchase.setPlanVal(purchase.plan.contains(i) ? 1 : 0);
                                        }
                                        if (i == 2) {
                                          selectedPlanList = petProvider.family;
                                          purchase.setPlanVal(purchase.plan.contains(i) ? 1 : 0);
                                        }
                                        print("selectedPlanList:::: $selectedPlanList");

                                        petProvider.showPlan(i);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:

                                                      // purchase.plan.contains(i) ?
                                                      purchase.showPlan.contains(i)
                                                          ?
                                                          // finPlanId==i?
                                                          AppColor.textLightBlueBlack
                                                          : AppColor.textFieldGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: petProvider.premiumbutton[i].buttonisSelected
                                                          ? AppColor.textLightBlueBlack
                                                          : Colors.transparent,
                                                      width: 2)),
                                              height: 100,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      // Text(permiumbutton[i].name,
                                                      // textAlign: TextAlign.center,
                                                      //     style: TextStyle(
                                                      //         color: AppColor.textLightBlueBlack,
                                                      //         fontSize: 15,
                                                      //         fontFamily: AppFont.poppinSemibold,
                                                      //         fontWeight: FontWeight.w500)),

                                                      const SizedBox(height: 10),

                                                      RichText(
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(children: <TextSpan>[
                                                          TextSpan(
                                                            text: permiumbutton[i].name,
                                                            style: TextStyle(
                                                                color:
                                                                    // purchase.plan.contains(i)?
                                                                    purchase.showPlan.contains(i)
                                                                        ? // purchase.maxPlanId==i?
                                                                        Colors.white
                                                                        : AppColor.textLightBlueBlack,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w700),
                                                          ),
                                                        ]),
                                                      ),

                                                      const SizedBox(
                                                        height: 7,
                                                      ),

                                                      // Text(permiumbutton[i].amount??"",
                                                      //   textAlign: TextAlign.center,
                                                      //       style: TextStyle(
                                                      //           color: AppColor.textLightBlueBlack,
                                                      //           fontSize: 15,
                                                      //           fontFamily: AppFont.poppinSemibold,
                                                      //           fontWeight: FontWeight.w500)),

                                                      RichText(
                                                        textAlign: TextAlign.center,
                                                        text: TextSpan(children: <TextSpan>[
                                                          TextSpan(
                                                            text: permiumbutton[i].amount ?? "",
                                                            style: TextStyle(
                                                                color:
                                                                    // purchase.plan.contains(i)?
                                                                    // purchase.maxPlanId==i?
                                                                    purchase.showPlan.contains(i)
                                                                        ? Colors.white
                                                                        : AppColor.textLightBlueBlack,
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w700),
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: 2,
                                                child:
                                                    // purchase.plan.contains(i)?
                                                    // finPlanId==i?
                                                    purchase.showPlan.contains(i)
                                                        ? Image.asset(AppImage.premiumIcon)
                                                        : const SizedBox())
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        );
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .90,
                          // color: Colors.yellow,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .45,

                                  // color: Colors.yellowAccent,

                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: tr(LocaleKeys.additionText_compareplans),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontFamily: AppFont.poppinsBold,
                                        ),
                                      ),
                                    ]),
                                  ),

                                  // child: Text(
                                  //   tr(LocaleKeys.additionText_compareplans),
                                  //   maxLines: 2,
                                  //   overflow:TextOverflow.ellipsis ,
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //     fontSize: 16.0,
                                  //     color: Colors.black,
                                  //     fontFamily: AppFont.poppinsBold,
                                  //   ),
                                  // ),
                                  //
                                ),
                              ),
                              const Spacer(),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 8.0),
                              //   child: Text(
                              //     tr(LocaleKeys.additionText_basic),
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(
                              //       fontSize: 16.0,
                              //       color: Colors.black,
                              //       fontFamily: AppFont.poppinsBold,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .28,
                                // color: Colors.purple,

                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: tr(LocaleKeys.additionText_premium),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontFamily: AppFont.poppinsBold,
                                      ),
                                    ),
                                  ]),
                                ),

                                // Text(
                                //   tr(LocaleKeys.additionText_premium),
                                //   textAlign: TextAlign.right,
                                //   maxLines: 2,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(
                                //     fontSize: 16.0,
                                //     color: Colors.black,
                                //     fontFamily: AppFont.poppinsBold,
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                        if (selectedPlanList == petProvider.monthly) {
                          showList = premiumPlanLangList;
                        }
                        if (selectedPlanList == petProvider.yearly) {
                          showList = premiumPlanLangList1;
                        }
                        if (selectedPlanList == petProvider.family) {
                          showList = premiumPlanLangList3;
                        }

                        List planList = showList;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .50,
                            // color: Colors.tealAccent,
                            child: ListView.builder(
                                itemCount: planList.length,
                                itemBuilder: (context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        print("value of is selected+1===${index + 1}");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Column(
                                          children: [
                                            PremiumList(
                                                context: context,
                                                txt1: planList[index].name,
                                                icon1: 1,
                                                icon2: (selectedPlanList.contains(index + 1)) ? 2 : 1),
                                            SizedBox(
                                              height: index == planList.length - 1 ? 100 : 0,
                                            )
                                          ],
                                        ),
                                      ));
                                }),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
