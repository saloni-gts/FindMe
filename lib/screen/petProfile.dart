import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customdropdown.dart';
import 'package:find_me/components/shortpage.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/models/petdetailsmodel.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/bottomBorderComp.dart';
import '../components/camraOption.dart';
import '../components/customSmallBlueButton.dart';
import '../components/customTextFeild.dart';
import '../generated/locale_keys.g.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/appstrings.dart';
import '../util/color.dart';
import 'newDocument.dart';

class PetProfile extends StatefulWidget {
  const PetProfile({Key? key}) : super(key: key);

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  late PetProvider petProvider;

  TextEditingController petNameController = TextEditingController();
  TextEditingController petmicrochipController = TextEditingController();
  TextEditingController petbirthController = TextEditingController();
  TextEditingController petbreedController = TextEditingController();
  TextEditingController petcolorController = TextEditingController();
  TextEditingController petdescpController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController qrTagNumberController = TextEditingController();

  double setHeight = 60;
  // double percent = 0.0;

  double percent = 0;
  PetDetails? petDetails;
  String timestampGmt = "";
  @override
  void initState() {
    petProvider = Provider.of(context, listen: false);
petProvider.valChange=0;
    print("pet petProvider.valChange===${petProvider.valChange}");
    if(petProvider.selectedPetDetail?.isPremium==1){
      petProvider.petPreVal=true;
    }else{
      petProvider.petPreVal=false;
    }

    petProvider.clearContent();
    petDetails = petProvider.selectedPetDetail;
    // petProvider.callGetQrTag();
    print("pet details qr tag list count===${petDetails?.isPetQrCount}");
    print("pet details qr tag number list===${petDetails?.qrTagNumber}");
    print("pet details microchip number list===${petDetails?.microchip}");

    // petDetails?.isPetQrCount! > 1 ? print("greater than 1"):print("less than 1");

    if (petDetails != null) {
      setDataForedit(petDetails!);
    }

    //mobileController.text=loginUser?.mobileNumber??"";

    super.initState();
  }

  List<PetTypeModl> petTypeList = [
    PetTypeModl(title: tr(LocaleKeys.additionText_dog), typeId: "1"),
    PetTypeModl(title: tr(LocaleKeys.additionText_cat), typeId: "2")
  ];

  List<PetTypeModl> petGenderList = [
    PetTypeModl(title: tr(LocaleKeys.additionText_maleE), typeId: "1"),
    PetTypeModl(title: tr(LocaleKeys.additionText_femaleE), typeId: "2"),
  ];

  List<PetTypeModl> petserializationList = [
    PetTypeModl(title: tr(LocaleKeys.additionText_yes), typeId: "1"),
    PetTypeModl(title: tr(LocaleKeys.additionText_no), typeId: "2")
  ];

  List<PetTypeModl> petSizeList = [
    PetTypeModl(title: tr(LocaleKeys.additionText_large), typeId: "1"),
    PetTypeModl(title: tr(LocaleKeys.additionText_medium), typeId: "2"),
    PetTypeModl(title: tr(LocaleKeys.additionText_small), typeId: "3")
  ];

  setDataForedit(PetDetails detail) {
    String type, gendr, serialize, petSizee;
    type = detail.petType ?? "";
    gendr = detail.gender ?? "";
    serialize = detail.sterilization ?? "";
    petSizee = detail.size ?? "";

    print("gendr pet========${gendr}");

    if (type.isNotEmpty) {
      petProvider.selectedPetType =
          petTypeList.firstWhere((element) => element.typeId == detail.petType);
    }

    //    if (type.isNotEmpty) {
    //   petProvider.selectedPetType = petProvider.petTypeList
    //       .firstWhere((element) => element.typeId == detail.petType);
    // }
    //
    //

    if (gendr.isNotEmpty) {
      petProvider.selectedPetGender = petGenderList
          .firstWhere((element) => element.typeId == detail.gender);
    }

    if (serialize.isNotEmpty) {
      petProvider.selectedSerialization = petserializationList
          .firstWhere((element) => element.typeId == detail.sterilization);
    }

    // if (serialize.isNotEmpty) {
    //   petProvider.selectedSerialization = petProvider.petserializationList
    //       .firstWhere((element) => element.typeId == detail.sterilization);
    // }
    if (petSizee.isNotEmpty) {
      petProvider.selectedPetSize =
          petSizeList.firstWhere((element) => element.typeId == detail.size);
    }
    petNameController.text = detail.petName ?? "";

    petmicrochipController.text = detail.microchip ?? "";
    String bdate = detail.birthDate ?? "";

    if (bdate.isNotEmpty) {
      petbirthController.text =
          dateConverter(int.parse(detail.birthDate ?? ""));
    }

    petbreedController.text = detail.breedName ?? "";
    petcolorController.text = detail.color ?? "";
    petdescpController.text = detail.shortDescription ?? "";
    mobileController.text = detail.contact ?? "";



    cityController.text = detail.city ?? "";
    percent = detail.profilePercantage ?? 0.0;
    percent = percent / 100;

    if (petProvider.tagNumLst.length > 2 && petProvider.tagNumLst.length < 5) {
      setHeight = 88;
    } else if (petProvider.tagNumLst.length < 2) {
      setHeight = 52;
    } else {
      setHeight = 100;
    }

    if (petProvider.tagNumLst.isNotEmpty) {
      print("set value in controller===>>> ${qrTagNumberController.text}");
      print("set height value of controller===>>> ${setHeight}");
      qrTagNumberController.clear();

      qrTagNumberController.text = petProvider.tagNumLst
          .toString()
          .replaceAll("]", "")
          .replaceAll("[", "");
      print("set value in controller===>>> ${qrTagNumberController.text}");
    }

    // qrTagNumberController.text = detail.qrTagNumber ?? "";
    // if (detail.qrTagNumber == "0") {
    //   qrTagNumberController.clear();
    // }
    //
  }

  var loginUser = HiveHandler.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BotttomBorder(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        //extendBody: true,
        floatingActionButton: Container(
          // color: Colors.yellowAccent,
          height: 92,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(),
                  flex: 4,
                ),
                Expanded(
                    flex: 40,
                    child: customSmallBlueButton(
                        colour: AppColor.textRed,
                        context: context,
                        onTap1: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(tr(LocaleKeys
                                      .additionText_uSureUwannaDelPet)),
                                  actions: <Widget>[
                                    InkWell(
                                      child: Text(
                                        tr(LocaleKeys.additionText_cancel),
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily:
                                                AppFont.poppinsMedium),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    InkWell(
                                      child: Text(
                                        tr(LocaleKeys.additionText_yes),
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily:
                                                AppFont.poppinsMedium),
                                      ),
                                      onTap: () {
                                        Map<String, dynamic> body = {
                                          "petId": petDetails?.id ?? 0
                                        };
                                        petProvider.deletePet(
                                            context, body);
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        text1: tr(LocaleKeys.additionText_Delete))),
                Expanded(
                  child: SizedBox(),
                  flex: 4,
                ),
                Expanded(
                    flex: 40,
                    child: customSmallBlueButton(
                        colour: AppColor.textLightBlueBlack,
                        context: context,
                        onTap1: () {
                          print("petProvider.permPetCountAddPet:::::${petProvider.permPetCountAddPet}");
                          print("petProvider.isUserPremium::::::${petProvider.isUserPremium}");
                          print("petProvider.petPreVal::::${petProvider.petPreVal}");


                          {
                            petProvider.petNameController = petNameController;

                            if (petNameController.text
                                .trim()
                                .isEmpty) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text:
                                  tr(LocaleKeys.additionText_entrDName));
                            }

                            // if(mobileController.text.isEmpty){
                            //   CoolAlert.show(
                            //       context: context,
                            //       type: CoolAlertType.warning,
                            //       text: "Enter Mobile Number");
                            // }
                            //
                            //
                            // if(  mobileController.text.isNotEmpty && !mobileController.text.ismobile(mobileController.text)){
                            //   CoolAlert.show(
                            //       context: context,
                            //       type: CoolAlertType.warning,
                            //       text: "Enter Valid Mobile Number");
                            // }

                            if (!mobileController.text
                                .ismobile(mobileController.text) &&
                                mobileController.text.isNotEmpty) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text: tr(LocaleKeys
                                      .additionText_entrValidMobNum));
                            } else {
                              if (petProvider.petNameController.text
                                  .trim()
                                  .isNotEmpty) {
                                String petnm,
                                    petchip,
                                    petbdate,
                                    petbred,
                                    petcolor,
                                    petdesc,
                                    petmob,
                                    petcity;
                                petnm = petNameController.text.trim();
                                petchip = petmicrochipController.text.trim();
                                petbdate = petbirthController.text;
                                petbred = petbreedController.text.trim();
                                petcolor = petcolorController.text.trim();
                                petdesc = petdescpController.text.trim();
                                petmob = mobileController.text.trim();
                                petcity = cityController.text.trim();

                                if (petNameController.text
                                    .trim()
                                    .isEmpty) {
                                  petnm = " ";
                                }
                                if (petmicrochipController.text.isEmpty) {
                                  petchip = " ";
                                }
                                if (petbirthController.text.isEmpty) {
                                  timestampGmt = " ";
                                }
                                if (petbreedController.text.isEmpty) {
                                  petbred = " ";
                                }
                                if (petcolorController.text.isEmpty) {
                                  petcolor = " ";
                                }
                                if (petdescpController.text.isEmpty) {
                                  petdesc = " ";
                                }
                                // if (mobileController.text.isEmpty) {
                                //   petmob = " ";
                                // }
                                if (cityController.text.isEmpty) {
                                  petcity = " ";
                                }

                                petProvider.updatePetCalling(
                                    petnme: petnm,
                                    microchipp: petchip,
                                    bdate: timestampGmt,
                                    bred: petbred,
                                    petcolr: petcolor,
                                    shortdesc: petdesc,
                                    contact: petmob,
                                    city: petcity,
                                    contxt: context);
                              }
                            }
                          } },
                        text1: tr(LocaleKeys.ownerProfile_update)))
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: customAppbar(
            titlename: tr(LocaleKeys.additionText_petProfile),
            isbackbutton: true),
        body: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.87,
            minChildSize: 0.75,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Consumer<PetProvider>(
                  builder: (context, petProvider, child) {
                    String pettypebool =
                        petProvider.selectedPetType?.title ?? "";
                    String petGenderbool =
                        petProvider.selectedPetGender?.title ?? "";
                    String petSerializationbool =
                        petProvider.selectedSerialization?.title ?? "";
                    String petSizeBool =
                        petProvider.selectedPetSize?.title ?? "";
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SingleChildScrollView(
                        //primary: false,
                        // physics:BouncingScrollPhysics() ,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    Consumer<PetProvider>(
                                      builder: (context, petProvider, child) {
                                        return Container(
                                          height: 125,
                                          width: 125,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            color: AppColor.textFieldGrey,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            child: petProvider.petImage != null
                                                ? Image.file(
                                                    File(petProvider
                                                            .petImage?.path ??
                                                        ""),
                                                    height: 122,
                                                    width: 122,
                                                    fit: BoxFit.cover,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        petDetails?.petPhoto ??
                                                            "",
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Image.asset(
                                                        AppImage
                                                            .placeholderIcon,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Image.asset(
                                                        AppImage
                                                            .placeholderIcon,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      left: 90,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertForImage(
                                            headText: tr(LocaleKeys
                                                .additionText_petName),
                                            callBack: (val) {
                                              print("TTST ${val}");
                                              Navigator.pop(context);
                                              if (val) {
                                                print("TTST ${val}");
                                                getImage(ImageSource.camera)
                                                    .then((value) {

                                                      print("value==${value}");
                                                      if(value.toString()=="File: ''"){
                                                        print("value like this===");
                                                        value=null;

                                                      }

                                                  if (value != null) {
                                                    petProvider
                                                        .updateImage(value);
                                                  }
                                                });
                                              } else {
                                                getImage(ImageSource.gallery)
                                                    .then((value) {
                                                  if (value == null) {
                                                    print("value==${value}");
                                                  } else {
                                                    print("value not null==${value}");
                                                  }
                                                  if(value.toString()=="File: ''"){
                                                    print("value like this===");
                                                    value=null;

                                                  }

                                                  if (value != null) {
                                                    petProvider
                                                        .updateImage(value);
                                                  }
                                                });
                                              }
                                            },
                                            context: context,
                                          );
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            color: AppColor.textLightBlueBlack,
                                          ),
                                          child: InkWell(
                                            child: ClipRRect(
                                              child: Image.asset(
                                                  AppImage.cameraIcon),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: LinearPercentIndicator(
                                  // width:MediaQuery.of(context).size.width*.85,
                                  progressColor: AppColor.progressneonColor,
                                  percent: percent,
                                  backgroundColor: AppColor.textFieldGrey,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  lineHeight: 4.0,
                                ),
                              ),

                              SizedBox(
                                height: 15.0,
                              ),

                              Center(
                                child: Text(
                                  // tr(LocaleKeys.additionText_yes)
                                  "${tr(LocaleKeys.additionText_completedBy)} " +
                                      "${(percent * 100).toStringAsFixed(0)}%",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.black,
                                      fontFamily: AppFont.poppinsMedium),
                                ),
                              ),

                              SizedBox(
                                height: 15.0,
                              ),


                              petProvider.isUserPremium==1?
                              Row(
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width*.65,

                                    child: Text(
                                      // "Activate premium feature",
                                         tr(LocaleKeys.additionText_actiPreFetr),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsBold),
                                    ),
                                  ),
                                  new Spacer(),


                                  Consumer<PetProvider>(
                                    builder: (context,petProvider,child) {
                                      return Checkbox(
                                      activeColor: AppColor.textLightBlueBlack,
                                      value:  petProvider.petPreVal,
                                      // groupValue: ,
                                      onChanged: (value) async {
                                        print("petProvider.permPetCountAddPet${petProvider.permPetCountAddPet}");

                                        print("petProvider.petPreVal${petProvider.petPreVal}");


                                          petProvider.changePetPremVal();
                                          petProvider.setPetStatusVal();

                                      }
                                      );
                                    }
                                  )

                                ],
                              )
                              :SizedBox(),



                               SizedBox(height: 15,),


                              Text(
                                tr(LocaleKeys.additionText_identifier),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsBold),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                AppStrings.microchip,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              CustomTextFeild(
                                  textInputType:
                                      petmicrochipController.text.isEmpty
                                          ? TextInputType.text
                                          : TextInputType.none,
                                  textController: petmicrochipController),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                petDetails!.isPetQrCount! <= 1
                                    ? tr(LocaleKeys.additionText_qrPetTg)
                                    : tr(LocaleKeys.additionText_qrPetTgs),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // CustomTextFeild(
                              //   isEnabled: false,
                              //   textInputType: TextInputType.text,
                              //   textController: qrTagNumberController,
                              // ),
                              //
                              // SizedBox(
                              //   height:10.0
                              // ),

                              //

                              // AutoSizeTextField(
                              //   controller: qrTagNumberController,
                              //   decoration: InputDecoration(hintText: 'Hint Text'),
                              //   fullwidth: false,
                              //   minFontSize: 20,
                              //   minWidth: 280,
                              //   style: TextStyle(fontSize: 20),
                              //   textAlign: TextAlign.center,
                              // ),

                              //

                              Container(
                                // height: petProvider.tagNumLst.length >2? 70 : 51,
                                height: setHeight,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28.0),
                                    color: AppColor.textFieldGrey,
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: Container(
                                    height: 60,
                                    child: TextField(
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      autofocus: false,
                                      enabled: false,
                                      scrollPadding: EdgeInsets.all(20.0),
                                      controller: qrTagNumberController,
                                      minLines: 1,
                                      maxLines: 5,
                                      style: TextStyle(
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 18.0),
                                      decoration: InputDecoration(
                                          // hintText: AppStrings.descWhatAfctPet,
                                          hintStyle: TextStyle(
                                              color: AppColor.textGreyColor,
                                              fontFamily: AppFont.poppinsMedium,
                                              fontSize: 15.0),
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          // border: OutlineInputBorder()
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent))),
                                    ),
                                  ),
                                ),
                              ),

                              //

                              SizedBox(
                                height: 15.0,
                              ),

                              Text(
                                tr(LocaleKeys.additionText_petInfo),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsBold),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tr(LocaleKeys.addPet_name),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              CustomTextFeild(
                                textController: petNameController,
                                textInputType: TextInputType.text,
                                hintText: tr(LocaleKeys.additionText_entrDName),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tr(LocaleKeys.additionText_petType),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.0,
                              ),
                              CustomDropDown<PetTypeModl>(
                                isGrey: pettypebool.isEmpty,
                                selectText:
                                    petProvider.selectedPetType?.title ??
                                        tr(LocaleKeys.additionText_select),
                                itemList: petTypeList,
                                isEnable: true,
                                onChange: (val) {
                                  petProvider.onselectPetType(val);
                                },
                                title: "",
                                value: null,
                              ),

                              SizedBox(
                                height: 5.0,
                              ),

                              Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      tr(LocaleKeys.additionText_birthDate),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
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
                                        //  print("/////******/////${value}");
                                        var date =
                                            DateTime.parse(value.toString());
                                        petbirthController.text =
                                            date.day.toString() +
                                                " " +
                                                date.month.toString() +
                                                " " +
                                                date.year.toString();
                                        date = date.add(
                                            Duration(hours: 5, minutes: 30));
                                        timestampGmt = date
                                            .millisecondsSinceEpoch
                                            .toString();
                                        print("TIMESTAMPP ${timestampGmt}");

                                        petbirthController.text = dateConverter(
                                            int.parse(timestampGmt));
                                      });
                                    },
                                    child: CustomTextFeild(
                                      isEnabled: false,
                                      textController: petbirthController,
                                      textInputType: TextInputType.text,
                                      hintText:
                                          tr(LocaleKeys.additionText_select),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      tr(LocaleKeys.additionText_breed),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  CustomTextFeild(
                                      textController: petbreedController,
                                      textInputType: TextInputType.text,
                                      hintText: tr(
                                          LocaleKeys.additionText_entrBreed)),

                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                tr(LocaleKeys.addPet_sex),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: AppColor
                                                      .textLightBlueBlack,
                                                  fontFamily:
                                                      AppFont.poppinsRegular,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 3.0,
                                            // ),

                                            CustomDropDown<PetTypeModl>(
                                              isGrey: petGenderbool.isEmpty,
                                              selectText: petProvider
                                                      .selectedPetGender
                                                      ?.title ??
                                                  tr(LocaleKeys
                                                      .additionText_select),
                                              itemList: petGenderList,
                                              isEnable: true,
                                              onChange: (val) {
                                                petProvider
                                                    .onselectPetGender(val);
                                              },
                                              title: "",
                                              value: null,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  tr(LocaleKeys
                                                      .addPet_sterilization),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: AppColor
                                                        .textLightBlueBlack,
                                                    fontFamily:
                                                        AppFont.poppinsRegular,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 10.0,
                                            // ),
                                            CustomDropDown<PetTypeModl>(
                                              isGrey:
                                                  petSerializationbool.isEmpty,
                                              selectText: petProvider
                                                      .selectedSerialization
                                                      ?.title ??
                                                  tr(LocaleKeys
                                                      .additionText_select),
                                              itemList: petserializationList,
                                              isEnable: true,
                                              onChange: (val) {
                                                petProvider
                                                    .onSerializationSelect(val);
                                              },
                                              title: "",
                                              value: null,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 18.0,
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      tr(LocaleKeys.additionText_entrPetColor),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15.0,
                                  ),

                                  CustomTextFeild(
                                      textController: petcolorController,
                                      textInputType: TextInputType.text,
                                      hintText: tr(LocaleKeys
                                          .additionText_entrPetColor)),

                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      tr(LocaleKeys.additionText_size),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10.0,
                                  // ),
                                  CustomDropDown<PetTypeModl>(
                                    isGrey: petSerializationbool.isEmpty,
                                    selectText:
                                        petProvider.selectedPetSize?.title ??
                                            tr(LocaleKeys.additionText_select),
                                    itemList: petSizeList,
                                    isEnable: true,
                                    onChange: (val) {
                                      petProvider.onselectPetSize(val);
                                    },
                                    title: "",
                                    value: null,
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      tr(LocaleKeys.additionText_shortDesc),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15.0,
                                  ),

                                  // CustomTextFeild(
                                  //     textController: petdescpController,
                                  //     textInputType: TextInputType.text,
                                  //     hintText: AppStrings.descYrPet
                                  //
                                  // ),
                                  //

                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(28.0),
                                        color: AppColor.textFieldGrey,
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      child: TextField(
                                        maxLines: 3,
                                        controller: petdescpController,
                                        //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                        autofocus: false,
                                        scrollPadding: EdgeInsets.all(20.0),

                                        style: TextStyle(
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 18.0,
                                        ),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            color: AppColor.textGreyColor,
                                            fontFamily: AppFont.poppinsMedium,
                                            fontSize: 15.0,
                                          ),
                                          hintText: tr(LocaleKeys
                                              .additionText_descYrPet),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr(LocaleKeys.addPet_contact),
                                          // textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinsRegular,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ))
                                          ]),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15.0,
                                  ),

                                  CustomTextFeild(
                                      hintText: tr(LocaleKeys.addPet_contact),
                                      textController: mobileController,
                                      textInputType:
                                          TextInputType.numberWithOptions(
                                              signed: true)),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      // tr(LocaleKeys.additionText_city),
                                      tr(LocaleKeys.addPet_city),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15.0,
                                  ),

                                  CustomTextFeild(
                                      textController: cityController,
                                      textInputType: TextInputType.text,
                                      hintText:
                                          tr(LocaleKeys.additionText_entrCity)),

                                  SizedBox(
                                    height: 45.0,
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              );
            }));
  }
}

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return "${Jiffy(d).format("dd MMM yyyy ")}".toUpperCase();
}
