import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../generated/locale_keys.g.dart';

import '../models/GoPreimModel.dart';
import '../monish/models/newModel.dart';
import '../monish/screen/buyPremium.dart';
import '../provider/purchase_provider.dart';
import '../util/app_font.dart';
import '../util/color.dart';

class ViewPremium extends StatefulWidget {
  const ViewPremium({Key? key}) : super(key: key);

  @override
  State<ViewPremium> createState() => _ViewPremiumState();
}

class _ViewPremiumState extends State<ViewPremium> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<goPremium> GOList = [
    goPremium(id: 0, name: tr(LocaleKeys.additionText_addUnLitedPt), showTick1: 1, showTick2: 1),
    goPremium(id: 1, name: tr(LocaleKeys.additionText_MngPtProfile), showTick1: 1, showTick2: 1),
    goPremium(id: 2, name: tr(LocaleKeys.additionText_MngYrProfile), showTick1: 1, showTick2: 1),
    goPremium(id: 3, name: tr(LocaleKeys.additionText_Mng2DocPic), showTick1: 1, showTick2: 1),
    goPremium(id: 4, name: tr(LocaleKeys.additionText_hltCrd), showTick1: 1, showTick2: 1),
    goPremium(id: 5, name: tr(LocaleKeys.additionText_MkeNotes), showTick1: 1, showTick2: 1),
    goPremium(id: 6, name: tr(LocaleKeys.additionText_crtMngEvts), showTick1: 1, showTick2: 1),
    goPremium(id: 7, name: tr(LocaleKeys.additionText_dnlodShrProfile), showTick1: 1, showTick2: 1),
    goPremium(id: 8, name: tr(LocaleKeys.additionText_cntQRTg2profile), showTick1: 1, showTick2: 1),
    goPremium(id: 9, name: tr(LocaleKeys.additionText_petLostFndMgt), showTick1: 1, showTick2: 1),
    goPremium(id: 10, name: tr(LocaleKeys.additionText_ptAchevmnt), showTick1: 1, showTick2: 1),
    goPremium(id: 11, name: tr(LocaleKeys.additionText_chkPotctinShld), showTick1: 1, showTick2: 1),
    goPremium(id: 12, name: tr(LocaleKeys.additionText_CntctCutmerSpt), showTick1: 1, showTick2: 1),
    goPremium(id: 13, name: tr(LocaleKeys.additionText_vuLocMap), showTick1: 1, showTick2: 1),
    goPremium(id: 23, name: tr(LocaleKeys.additionText_langLoc), showTick1: 1, showTick2: 1),
    goPremium(id: 14, name: tr(LocaleKeys.additionText_premPet4), showTick1: 2, showTick2: 1),
    goPremium(id: 15, name: tr(LocaleKeys.additionText_adUnlitedPicDoc), showTick1: 2, showTick2: 1),
    goPremium(id: 16, name: tr(LocaleKeys.additionText_wgtTrk), showTick1: 2, showTick2: 1),
    goPremium(id: 17, name: tr(LocaleKeys.additionText_chkPrt), showTick1: 2, showTick2: 1),
    goPremium(id: 18, name: tr(LocaleKeys.additionText_freQRtgDilv), showTick1: 2, showTick2: 1),
    goPremium(id: 19, name: tr(LocaleKeys.additionText_ptJntMgt), showTick1: 2, showTick2: 1),
    goPremium(id: 20, name: tr(LocaleKeys.additionText_shrWitFamMem), showTick1: 2, showTick2: 1),
    goPremium(id: 21, name: tr(LocaleKeys.additionText_smsNotiPtLst), showTick1: 2, showTick2: 1),
    goPremium(id: 22, name: tr(LocaleKeys.additionText_addiCnts), showTick1: 2, showTick2: 1),
    goPremium(id: 22, name: tr(LocaleKeys.additionText_cutmrPriSpt), showTick1: 2, showTick2: 1),
  ];

  List<premiumPlans> premiumPlanLangList3 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCurvedAppbar(
        title: "",
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 30),
        child: CustomButton(
          text: tr(LocaleKeys.additionText_GOPrem),
          onPressed: () {
            PurChaseProvider purChaseProvider = Provider.of(context, listen: false);
            purChaseProvider.getSubScriptionDetails();
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyPremium()));
          },
        ),
      ),
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.89,
          minChildSize: 0.80,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   "Go Premium",
                  //   textAlign: TextAlign.left,
                  //   style: TextStyle(
                  //     fontSize: 22.0,
                  //     color: AppColor.textRed,
                  //     fontFamily: AppFont.poppinsBold,
                  //   ),
                  // ),

                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: tr(LocaleKeys.additionText_goprem),
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: AppColor.textRed,
                          fontFamily: AppFont.poppinsBold,
                        ),
                      ),
                    ]),
                  ),

                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: tr(LocaleKeys.additionText_and),
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: AppColor.textLightBlueBlack,
                          fontFamily: AppFont.poppinsBold,
                        ),
                      ),
                    ]),
                  ),

                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: tr(LocaleKeys.additionText_unlckBnfits),
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: AppColor.textLightBlueBlack,
                          fontFamily: AppFont.poppinsBold,
                        ),
                      ),
                    ]),
                  ),

                  //
                  // Text("&",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontSize: 22,
                  //         color: AppColor
                  //             .textLightBlueBlack,
                  //         fontFamily:
                  //         AppFont.poppinsBold)
                  //
                  // ),
                  // Text("UnLock The Benefits",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontSize: 22,
                  //         color: AppColor
                  //             .textLightBlueBlack,
                  //         fontFamily:
                  //         AppFont.poppinsBold)
                  //
                  // ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      // width: MediaQuery.of(context).size.width*.8,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            // color: Colors.tealAccent,
                            width: MediaQuery.of(context).size.width * .5,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: tr(LocaleKeys.additionText_ftrs),
                                  style: const TextStyle(
                                      color: AppColor.textLightBlueBlack, fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                              ]),
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: tr(LocaleKeys.additionText_fre),
                                style: const TextStyle(
                                    color: AppColor.textLightBlueBlack, fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ]),
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: tr(LocaleKeys.additionText_premmm),
                                style: const TextStyle(
                                    color: AppColor.textLightBlueBlack, fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    // color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: GOList.length,
                          itemBuilder: (context, index) {
                            return GoPremList(
                              context: context,
                              txt1: GOList[index].name,
                              icon1: GOList[index].showTick1,
                              icon2: GOList[index].showTick2,
                            );
                          }),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // 2 cancel
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_smsNoti),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_LifePetProfile),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_AddiContacts),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_PicsDocs),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_MsngrFBWhatsapp),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_MultiplePetProfile),icon1: 1,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_WeitTrkr),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_freQrTgEvryYr),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_jntMgt),icon1: 2,icon2:1 ),
                  // GoPremList(context: context,txt1: tr(LocaleKeys.additionText_addFamMem),icon1: 2,icon2:1 ),
                ],
              ),
            );
          }),
    );
  }
}
