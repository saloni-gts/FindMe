

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/cntryPikrprot.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/blur_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cntrPikrProt2.dart';
import '../components/customTextFeild.dart';
import '../generated/locale_keys.g.dart';
import '../monish/reUseClass/custombluebutton.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';

class CheckProtection extends StatefulWidget {
  var UsrData;
  CheckProtection({Key? key, this.UsrData}) : super(key: key);

  @override
  State<CheckProtection> createState() => _CheckProtectionState();
}

class _CheckProtectionState extends State<CheckProtection> {
  TextEditingController microchipController = TextEditingController();
  TextEditingController tatoo1Controller = TextEditingController();
  TextEditingController tatoo2Controller = TextEditingController();
  TextEditingController ringnoController = TextEditingController();
  TextEditingController mainemailController = TextEditingController();
  TextEditingController mainphoneController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController telegramController = TextEditingController();

  String? mnPhNum;

  var setHeight = 80.0;
  var setMsgHeight = 80.0;

  int tapVal = 0;

  List petListtt = [];
  @override
  void initState() {
    PetProvider pet = Provider.of(context, listen: false);

    pet.setSelectedPetDetails(pet.petDetailList[0]);
    petListtt = pet.petDetailList;
    print("petListtt====${petListtt}");

    if (petListtt.isNotEmpty) {
      pet.showGreenTickPro(pet.petDetailList[0].id ?? 0);
      pet.selectedPetIdForProtction = pet.petDetailList[0].id ?? 0;

      pet.callGetProt();
      mnPhNum = "+" +
          widget.UsrData.phoneCode.toString() +
          " " +
          widget.UsrData.mobileNumber.toString();

      mainphoneController.text = mnPhNum!;
      mainemailController.text = widget.UsrData.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar:      BotttomBorder(context),
      appBar: customAppbar(
          isbackbutton: true,

          titlename: tr(LocaleKeys.additionText_checktheProtection)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: customBlueButton(
            context: context,
            text1: tr(LocaleKeys.addPet_save),
            onTap1: () {
              PetProvider petProvider = Provider.of(context, listen: false);

              petProvider.addToList();
              petProvider.addToPhNumList(context);
              petProvider.addToMsngrList();

              if (petProvider.xtraPhNumlist.isNotEmpty) {
                String s1 = petProvider.xtraPhNumlist[0].controller?.text ?? "";
                if (s1.isNotEmpty && !s1.ismobile(s1)) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text: tr(LocaleKeys.additionText_entrValidMobNum));
                } else {


                  petProvider.selectedPetDetail?.microchip=petProvider.petProtMchip.text;
                  print("====microchip=${petProvider.selectedPetDetail?.microchip}");
                  Future.delayed(const Duration(milliseconds: 200), () {
                    petProvider.callEditProtection(
                      context: context,
                      petMicrochip: petProvider.petProtMchip.text,
                      PetIdentfies: petProvider.featureMap,
                      messengers: petProvider.mesngrMap,
                      mobNumLst: petProvider.PhNumMap,
                    );
                  });


                }
              } else {
                petProvider.selectedPetDetail?.microchip=petProvider.petProtMchip.text;
                print("====microchip=${petProvider.selectedPetDetail?.microchip}");
                Future.delayed(const Duration(milliseconds: 200), () {

                  petProvider.callEditProtection(
                    context: context,
                    petMicrochip: petProvider.petProtMchip.text,
                    PetIdentfies: petProvider.featureMap,
                    messengers: petProvider.mesngrMap,
                    mobNumLst: petProvider.PhNumMap,
                  );
                });


              }
            },
            colour: AppColor.newBlueGrey),
      ),
      body: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.85,
              minChildSize: 0.81,
              maxChildSize: 0.9,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    reverse: true,
                  
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,  
                          ),

                          ///------------

                          Text(
                            tr(LocaleKeys.additionText_xtraPtId),
                            style: TextStyle(
                                fontFamily: AppFont.poppinsBold,
                                fontSize: 16,
                                color: AppColor.textLightBlueBlack),
                          ),

                          Consumer<PetProvider>(
                            builder: (context, petProvider, child) {
                              var petList = petProvider.petDetailList2;
                              return Container(
                                height: 110.0,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: petList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          PetProvider provider = Provider.of(
                                              context,
                                              listen: false);

                                          provider.showGreenTickPro(petProvider
                                                  .petDetailList[index].id ??
                                              0);

                                          provider.setSelectedPetDetails(provider.petDetailList[index]);
                                          print("selected pet detail=${provider.selectedPetDetail?.petName}");
                                          print(
                                              "pet id val after sel=== >> ${petProvider.selectedPetIdForProtction}");

                                          Future.delayed(
                                              Duration(milliseconds: 200), () {
                                            provider.callGetProt();
                                          });

                                          // provider.callGetProt();

                                          var eventpetid = petProvider
                                                  .petDetailList[index].id ??
                                              0;
                                          var eventpetphoto = petProvider
                                                  .petDetailList[index]
                                                  .petPhoto ??
                                              0;
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        color: AppColor
                                                            .textFieldGrey),
                                                    height: 80,
                                                    width: 80,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: CachedNetworkImage(
                                                        imageUrl: petList[index]
                                                                .petPhoto ??
                                                            "",
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Image.asset(
                                                            AppImage
                                                                .placeholderIcon,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Image.asset(
                                                            AppImage
                                                                .placeholderIcon,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  petProvider
                                                              .petDetailList[
                                                                  index]
                                                              .id ==
                                                          petProvider
                                                              .selectedPetIdForProtction
                                                      ? Positioned(
                                                          left: 55.0,
                                                          top: 0,
                                                          child: InkWell(
                                                            child: ClipRRect(
                                                              child: Image.asset(
                                                                  AppImage
                                                                      .greenCheckIcon),
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                print(
                                                    "IMAGE PET  ${petList[index].petPhoto}");
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  petList[index].petName ?? "",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                      fontFamily: AppFont
                                                          .poppinSemibold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            },
                          ),

                          ///-------------

                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Consumer<PetProvider>(
                                builder: (context, petProvider, child) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),

                                  Text(


                                    tr(LocaleKeys.additionText_microchip),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  CustomTextFeild(
                                    textController: petProvider.petProtMchip,
                                    textInputType: petProvider.petProtMchip.text.isEmpty? TextInputType.text : TextInputType.none,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(

                                    tr(LocaleKeys.additionText_xtraPtId),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(height: 20),

                                  ///

                                  petProvider.addFechr >= 1
                                      ? Consumer<PetProvider>(builder:
                                          (context, petProvider, child) {
                                          if (petProvider
                                                  .PetFraturelist.length ==
                                              1) {
                                            setMsgHeight = 100;
                                          } else if (petProvider
                                                  .PetFraturelist.length ==
                                              2) {
                                            setMsgHeight = 200;
                                          } else if (petProvider
                                                  .PetFraturelist.length >
                                              2) {
                                            setMsgHeight = 320;
                                          }
                                          return Container(
                                            height: setMsgHeight,
                                            child: ListView.builder(
                                                reverse: true,
                                                itemCount: petProvider.PetFraturelist.length,
                                                itemBuilder:
                                                    (BuildContext, int index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${petProvider.PetFraturelist[index].SpFechr}",
                                                          // petProvider.MesngrTxt??"",
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsRegular,
                                                              fontSize: 12,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),

                                                        SizedBox(
                                                          height: 15.0,
                                                        ),

                                                        CustomTextFeild(
                                                          textController:
                                                              petProvider
                                                                  .PetFraturelist[
                                                                      index]
                                                                  .controller,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          hintText: "",
                                                        ),
                                                        // petProvider.
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          );
                                        })
                                      : SizedBox(),

                                  ///

                                  customBlueButton(
                                      context: context,
                                      text1: tr(LocaleKeys.additionText_add),
                                      onTap1: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return blurView(
                                                child: Container(
                                                  color: AppColor.textFieldGrey,
                                                  height: 370,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                AppImage
                                                                    .closeIcon,
                                                              )),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  1);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_specialfeatures),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  2);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_tattoos),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  3);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_clip),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  4);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_ringnumber),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  5);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_internalOrgniztionnumber),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  6);
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_accountnumber),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  7);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_breedingbooknumber),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          petProvider
                                                              .FechrNums();
                                                          petProvider
                                                              .incrementController(
                                                                  8);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          tr(LocaleKeys
                                                              .additionText_otherid),
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsMedium,
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   tr(LocaleKeys
                                                      //       .additionText_xtraContct),
                                                      //   style: TextStyle(
                                                      //       fontFamily:
                                                      //           AppFont.poppinsBold,
                                                      //       fontSize: 16,
                                                      //       color: AppColor
                                                      //           .textLightBlueBlack),
                                                      // ),
                                                      SizedBox(
                                                        height: 0.0,
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });

                                        // petProvider.PetFraturelist.add
                                        //   (
                                        //
                                        // );
                                      },
                                      colour: AppColor.textRed),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    tr(LocaleKeys.additionText_contacts),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    tr(LocaleKeys.additionText_email),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  CustomTextFeild(
                                    textController: mainemailController,
                                    textInputType: TextInputType.emailAddress,
                                    hintText: "james@mail.com",
                                    isEnabled: false,
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    tr(LocaleKeys.additionText_mainPhn),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),

                                  CustomTextFeild(
                                    textController: mainphoneController,
                                    textInputType: TextInputType.phone,
                                    hintText: "+44 982 965 6225",
                                    isEnabled: false,
                                  ),

                                  SizedBox(
                                    height: 22.0,
                                  ),
                                  // tr(LocaleKeys.additionText_smsTgScn),
                                  Text(
                                    tr(LocaleKeys.additionText_smsTgScn),

                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  mycustomBlueButton(
                                      context: context,
                                      colour: AppColor.neon,
                                      onTap1: () {},
                                      text1:    tr(LocaleKeys.additionText_ACTIVATED),
                                          // tr(LocaleKeys.additionText_activate),
                                      border1: false),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    tr(LocaleKeys.additionText_xtraContct),

                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),

                                  petProvider.addNum >= 1
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            tr(LocaleKeys.addPet_contact),
                                            style: TextStyle(
                                                fontFamily:
                                                    AppFont.poppinsRegular,
                                                fontSize: 12,
                                                color: AppColor
                                                    .textLightBlueBlack),
                                          ),
                                        )
                                      : SizedBox(),

                                  SizedBox(
                                    height: 7,
                                  ),

                                  petProvider.addNum >= 1
                                      ? Consumer<PetProvider>(builder:
                                          (context, petProvider, child) {
                                          if (petProvider
                                                  .xtraPhNumlist.length ==
                                              1) {
                                            setHeight = 90;
                                          } else if (petProvider
                                                  .xtraPhNumlist.length ==
                                              2) {
                                            setHeight = 150;
                                          } else if (petProvider
                                                  .xtraPhNumlist.length >
                                              2) {
                                            setHeight = 200;
                                          }

                                          return Container(
                                            height: setHeight,

                                            // height: petProvider.addNum==1 ,
                                            child: ListView.builder(
                                                reverse: true,
                                                itemCount: petProvider
                                                    .xtraPhNumlist.length,
                                                itemBuilder:
                                                    (BuildContext, int index) {
                                                      // petProvider.setPetProtFlag(petProvider.xtraPhNumlist[index].cntyflag ?? "");
                                                  print("======>${petProvider.xtraPhNumlist[index].cntyflag ?? ""}");
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: CntrePikrProt(
                                                        phoneNumController:
                                                            petProvider.xtraPhNumlist[index].controller,
                                                        inx: index,
                                                        countryCode: petProvider.xtraPhNumlist[index].cntyCode ?? "",
                                                      countryFlag:petProvider.xtraPhNumlist[index].cntyflag??"🇬🇧" ,

                                                    ),
                                                  );
                                                }),
                                          );
                                        })
                                      : SizedBox(),

                                  SizedBox(
                                    height: 15.0,
                                  ),

                                  customBlueButton(
                                      context: context,
                                      text1: tr(LocaleKeys.additionText_add),
                                      onTap1: () {
                                        if (petProvider.xtraPhNumlist.length >= 3) {
                                        } else {

                                          petProvider.incrementController3();
                                          petProvider.xtraNums();

                                          if (petProvider
                                                  .xtraPhNumlist.length ==
                                              2) {
                                            setHeight = 150;
                                          } else if (petProvider
                                                  .xtraPhNumlist.length >
                                              2) {
                                            setHeight = 200;
                                          }
                                        }
                                      },
                                      colour: AppColor.textRed),

                                  SizedBox(
                                    height: 22.0,
                                  ),

                                  Text(
                                    tr(LocaleKeys.additionText_msngrNum),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 25.0,
                                  ),

                                  ///-------------

                                  petProvider.addMsngrNum >= 1
                                      ? Consumer<PetProvider>(builder:
                                          (context, petProvider, child) {
                                          if (petProvider
                                                  .xtraContactlist.length ==
                                              2) {
                                            setMsgHeight = 200;
                                          } else if (petProvider
                                                  .xtraContactlist.length >
                                              2) {
                                            setMsgHeight = 320;
                                          }
                                          return Container(
                                            height: setMsgHeight,
                                            child: ListView.builder(
                                                reverse: true,
                                                itemCount: petProvider
                                                    .xtraContactlist.length,
                                                itemBuilder:
                                                    (BuildContext, int index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // petProvider.xtraContactlist[index].xtraContact==petProvider.title2 && index>=1 ? SizedBox():
                                                        Text(
                                                          "${petProvider.xtraContactlist[index].xtraContact}",
                                                          // petProvider.MesngrTxt??"",
                                                          style: TextStyle(
                                                              fontFamily: AppFont
                                                                  .poppinsRegular,
                                                              fontSize: 12,
                                                              color: AppColor
                                                                  .textLightBlueBlack),
                                                        ),

                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        CustomTextFeild(
                                                          textController:
                                                              petProvider
                                                                  .xtraContactlist[
                                                                      index]
                                                                  .controller,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          hintText: "",
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          );
                                        })
                                      : SizedBox(),

                                  ///-------------

                                  Consumer<PetProvider>(
                                      builder: (context, petProvider, child) {
                                    return customBlueButton(
                                        context: context,
                                        text1: tr(LocaleKeys.additionText_add),
                                        onTap1: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return blurView(
                                                  child: Container(
                                                    color:
                                                        AppColor.textFieldGrey,
                                                    height: 270,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  AppImage.closeIcon,
                                                                )),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            petProvider
                                                                .MsngrNums();
                                                            petProvider
                                                                .incrementController2(
                                                                    1);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Telegram",
                                                            style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .poppinsMedium,
                                                                fontSize: 16,
                                                                color: AppColor
                                                                    .textLightBlueBlack),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            petProvider.MsngrNums();

                                                            petProvider
                                                                .incrementController2(
                                                                    2);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Whatsapp",
                                                            style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .poppinsMedium,
                                                                fontSize: 16,
                                                                color: AppColor
                                                                    .textLightBlueBlack),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            petProvider
                                                                .MsngrNums();

                                                            petProvider
                                                                .incrementController2(
                                                                    3);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Facebook Messenger",
                                                            style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .poppinsMedium,
                                                                fontSize: 16,
                                                                color: AppColor
                                                                    .textLightBlueBlack),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            petProvider
                                                                .MsngrNums();

                                                            petProvider
                                                                .incrementController2(
                                                                    4);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Viber",
                                                            style: TextStyle(
                                                                fontFamily: AppFont
                                                                    .poppinsMedium,
                                                                fontSize: 16,
                                                                color: AppColor
                                                                    .textLightBlueBlack),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        // InkWell(
                                                        //   onTap: () {
                                                        //     petProvider
                                                        //         .MsngrNums();
                                                        //     petProvider
                                                        //         .incrementController2(
                                                        //             5);
                                                        //     Navigator.pop(
                                                        //         context);
                                                        //   },
                                                        //   child: Text(
                                                        //     tr(LocaleKeys
                                                        //         .additionText_othernumer),
                                                        //     style: TextStyle(
                                                        //         fontFamily: AppFont
                                                        //             .poppinsMedium,
                                                        //         fontSize: 16,
                                                        //         color: AppColor
                                                        //             .textLightBlueBlack),
                                                        //   ),
                                                        // ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });

                                          // if(petProvider.msgList.length==2){
                                          //   setMsgHeight=220;
                                          // }
                                        },
                                        colour: AppColor.textRed);
                                  }),

                                  SizedBox(
                                    height: 30.0,
                                  ),

                                  SizedBox(
                                    // height: 30.0,
                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
