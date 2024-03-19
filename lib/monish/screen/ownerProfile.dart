import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/extension/email_extension.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/camraOption.dart';
import '../../components/cntryyPikrrComp.dart';
import '../../components/commingSoonAlert.dart';
import '../../components/customBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../components/customdropdown.dart';
import '../../components/ownerCountry.dart';
import '../../components/profileCntrePikr.dart';
import '../../components/shortpage.dart';
import '../../generated/locale_keys.g.dart';
import '../../models/petdetailsmodel.dart';
import '../../models/usermodel.dart';
import '../../provider/authprovider.dart';
import '../../provider/petprovider.dart';
import '../../screen/newDocument.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/appstrings.dart';
import '../../util/color.dart';
import '../provider/myProvider.dart';
import '../reUseClass/dropdown.dart';
import '../reUseClass/mytextfield.dart';

class OwnerProfile extends StatefulWidget {
   OwnerProfile({Key? key}) : super(key: key);

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
//  TextEditingController genderController=TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phNoController = TextEditingController();

  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;



  void initState() {

    AuthProvider auth= Provider.of(context, listen: false);

print("user country===${user.country}");
print("user short code country===${user.shortCode}");
print("user gender===${user.gender}>>====");
print("user phoneCode===${user.phoneCode}>>====");
print("user phoneCode===${user.mobileNumber}>>====");



print("gender===${user.gender}>>====");

if(user.phoneCode!.isEmpty){
  user.phoneCode="44";
}

// print("user phoneCode===${int.parse(user.phoneCode!)}>>====");

String gendr;
    gendr=user.gender??"";
    if(user.gender==""){

    }

    // if (gendr.isNotEmpty) {
    //   auth.selectedUserGender = auth.userGenderList.firstWhere((element) => element.typeId == user.gender);
    // }


    auth.usrCode=user.phoneCode;

    print(" auth.selectedUserGender${ auth.selectedUserGender}");
print("please show edited country code${user.phoneCode}");
    auth.cntrycodeOnr=user?.phoneCode??"44";
    // auth.onselectUserGender(auth.selectedUserGender!);

    auth.getContryFlag(auth.usrCode);
    // auth.getContryFlag("44");



    AddressController.text=user?.address??"";

    String countryCode = user.shortCode??"";



 //    String flagIcon = user.shortCode?.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
 //            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397))??"";
 // print("flag icon printingggggg");
 //    print(flagIcon);
 //

    AuthProvider authProvider = Provider.of(context, listen: false);



    emailController.text = user.email ?? "";



print("objectcheck printinggggg");
    print("phone code from provider${authProvider.phncode}");

    phNoController.text = user.mobileNumber.toString();
    if (phNoController.text == "0") {
      print("zeroooooo");
      phNoController.clear();
    }

    nameController.text = user.name ?? '';
    lastNameController.text = user.lastName ?? "";

    countryController.text = user.country ?? "";

    cityController.text = user.city ?? "";

    // if(user.gender!.isEmpty){
    //   user.gender="0";
    // }
    //
    // print("user.genderuser.gender ====${user.gender}");
    // else {


    if(user.gender!.isNotEmpty){
      for (var item in authProvider.userGenderList) {
        if (item.typeId == user.gender) {
          authProvider.selectedUserGender = item;
        }
      }
    }


    print("user gender===${authProvider.selectedUserGender?.title}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotttomBorder(context),
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: customAppbar(
        titlename: tr(LocaleKeys.ownerProfile_op),
        isbackbutton: true,
        //icon: false,
      ),
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          minChildSize: 0.84,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Consumer3<AuthProvider, Myprovider,PetProvider>(
                  builder: (context, authProvider, myprovider, petProvider,child) {
                String userGenderbool = authProvider.selectedUserGender?.title ?? "";

                return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.0,
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    Consumer<AuthProvider>(
                                      builder: (context, authProvider, child) {
                                        return Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            color: AppColor.textFieldGrey,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(65),
                                            // radius: 50,
                                            child: authProvider.userImage !=
                                                    null
                                                ? Image.file(
                                                    File(authProvider
                                                            .userImage?.path ??
                                                        ""),
                                                    height: 122,
                                                    width: 122,
                                                    fit: BoxFit.cover,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        user.profileImage ??
                                                            "",
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      AppImage.jamesImage,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      AppImage.jamesImage,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                          ),
                                        );
                                      
                                      
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 100),
                                      child: InkWell(
                                        onTap: () {
                                          showAlertForImage(
                                            headText: tr(LocaleKeys.additionText_petName),
                                            callBack: (val) {
                                              Navigator.pop(context);
                                              if (val) {
                                                getImage(ImageSource.camera)
                                                    .then((value) {
                                                  print("value==${value}");
                                                  if(value.toString()=="File: ''"){
                                                    print("value like this===");
                                                    value=null;

                                                  }
                                                  if (value != null) {
                                                    authProvider
                                                        .updateUserImage(value);
                                                  }
                                                });
                                              }
                                              else {
                                                getImage(ImageSource.gallery)
                                                    .then((value) {

                                                  print("value==${value}");
                                                  if(value.toString()=="File: ''"){
                                                    print("value like this===");
                                                    value=null;

                                                  }


                                                  if (value != null) {
                                                    authProvider
                                                        .updateUserImage(value);
                                                  }
                                                });
                                              }
                                            },
                                            context: context,
                                          );
                                        },
                                        child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                AppColor.textLightBlueBlack,
                                            child: Image.asset(
                                                AppImage.cameraIcon)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                tr(LocaleKeys.ownerProfile_generalInformation),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsBold),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    tr(LocaleKeys.additionText_name),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),

                                  //
                                  // myCustomTextFeild(
                                  //   textController: nameController,
                                  //   height: 56.0,
                                  //   width: 328.0,
                                  //   hintText: "James",
                                  //   fontsize: 15.0,
                                  //   color: AppColor.textLightBlueBlack,
                                  // ),

                                  CustomTextFeild(
                                    textController: nameController,
                                    textInputType: TextInputType.text,
                                  ),

                                  SizedBox(
                                    height: 22,
                                  ),

                                  Text(
                                   tr(LocaleKeys.additionText_lastName),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),

                                  CustomTextFeild(
                                    textController: lastNameController,
                                    textInputType: TextInputType.text,
                                  ),

                                  SizedBox(
                                    height: 17,
                                  ),

                                  Text(
                                    tr(LocaleKeys.addPet_sex),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  CustomDropDown<PetTypeModl>(
                                    //  width: 328.0,
                                    fontfamily: AppFont.poppinsMedium,
                                    color: AppColor.textLightBlueBlack,
                                    selecttextcolor:
                                        AppColor.textLightBlueBlack,
                                    isGrey: userGenderbool.isEmpty,
                                    selectText: authProvider.selectedUserGender?.title ?? tr(LocaleKeys.additionText_select),
                                    itemList: authProvider.userGenderList,
                                    isEnable: true,
                                    onChange: (val) {
                                      print("on gender changed ${val}");
                                      authProvider.onselectUserGender(val);
                                    },
                                    title: "",
                                    value: null,

                                  ),

                                  SizedBox(
                                    height: 17,
                                  ),




                                  //Text(flagIcon),

                                  Text(
                                    tr(LocaleKeys.addPet_contact),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Text(
                                    tr(LocaleKeys.additionText_email),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),

                                  CustomTextFeild(
                                    textController: emailController,
                                    textInputType: TextInputType.none,
                                    isEnabled: false,
                                  ),

                                  SizedBox(
                                    height: 18,
                                  ),

                                  Text(
                                   tr(LocaleKeys.additionText_phNum),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 7,
                                  ),


                                  //
                                  // CntrePikr(phoneNumController: phNoController),

                                // CntrePikrProfilepage(phoneNumController: phNoController,),

                              //    SizedBox(height: 15,),

                                 CntrePikrOwner(
                                     phoneNumController: phNoController,
                                     countryCode:authProvider.usrCode??"44",
                                     // user?.phoneCode??"44" ,
                                     // countryFlag: authProvider.getContryFlag(user?.phoneCode??"44")
                                     countryFlag: authProvider.getContryFlag(authProvider.usrCode??"44")
                                 ),



                                  SizedBox(
                                    height: 17,
                                  ),

                                  SizedBox(
                                    height: 23,
                                  ),
                                  Text(
                                    tr(LocaleKeys.ownerProfile_smsNotification),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  customBlueButton(
                                      context: context,
                                      text1: petProvider.isUserPremium==1?
                                      tr(LocaleKeys.additionText_ACTIVATED):tr(LocaleKeys.ownerProfile_getAccess),
                                      onTap1: () {
                                        petProvider.isUserPremium==1?
                                            {}  : commingSoonDialog(context) ;
                                      },
                                      colour: petProvider.isUserPremium==1? AppColor.neon : AppColor.textRed),
                                  SizedBox(
                                    height: 17,
                                  ),

                                  Text(
                                      tr(LocaleKeys.additionText_mltiplEmergcyContct),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  customBlueButton(
                                      context: context,
                                      text1: petProvider.isUserPremium==1?
                                      tr(LocaleKeys.additionText_ACTIVATED):
                                          tr(LocaleKeys.ownerProfile_getAccess),
                                      onTap1: () {
                                        petProvider.isUserPremium==1?
                                        {}:
                                        commingSoonDialog(context);
                                      },
                                      colour:petProvider.isUserPremium==1? AppColor.neon : AppColor.textRed),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    tr(LocaleKeys.ownerProfile_headline1),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsLight,
                                        fontSize: 10,
                                        color: Color(0xff777777)),
                                  ),

                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    tr(LocaleKeys.ownerProfile_messegngersContact),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  customBlueButton(
                                      context: context,
                                      text1: petProvider.isUserPremium==1?
                                      tr(LocaleKeys.additionText_ACTIVATED):
                                          tr(LocaleKeys.ownerProfile_getAccess),
                                      onTap1: () {
                                        petProvider.isUserPremium==1?
                                        {}:

                                        commingSoonDialog(context);
                                      },
                                      colour:petProvider.isUserPremium==1? AppColor.neon : AppColor.textRed),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                      tr(LocaleKeys.ownerProfile_headline2),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsLight,
                                        fontSize: 10,
                                        color: Color(0xff777777)),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    tr(LocaleKeys.ownerProfile_address),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 12,
                                  ),

                                  Text(
                                    tr(LocaleKeys.ownerProfile_country),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular),
                                  ),

                                  SizedBox(
                                    height: 7,
                                  ),

                                  CustomTextFeild(
                                    textController: countryController,
                                    textInputType: TextInputType.text,
                                  ),

                                  SizedBox(
                                    height: 12,
                                  ),

                                  Text(
                                    tr(LocaleKeys.addPet_city),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 12,
                                        color: AppColor.textLightBlueBlack),
                                  ),

                                  SizedBox(
                                    height: 7,
                                  ),

                                  CustomTextFeild(
                                    textController: cityController,
                                    textInputType: TextInputType.text,
                                  ),

                                  SizedBox(
                                    height: 12,
                                  ),

                                  Text(
                                    tr(LocaleKeys.ownerProfile_address),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 16,
                                        color: AppColor.textLightBlueBlack),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),


                                  petProvider.isUserPremium==1?
                                  CustomTextFeild(
                                    textController: AddressController,
                                    textInputType: TextInputType.text,
                                    hintText: tr(LocaleKeys.additionText_addYrAdrs)

                                  ) :

                                  customBlueButton(
                                      context: context,
                                      text1:
                                          tr(LocaleKeys.ownerProfile_getAccess),
                                      onTap1: () {
                                        commingSoonDialog(context);
                                      },
                                      colour: AppColor.textRed),


                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      tr(LocaleKeys.ownerProfile_headline3),
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsLight,
                                        fontSize: 10,
                                        color: Color(0xff777777)),
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsLight,
                                        fontSize: 10,
                                        color: Color(0xff777777)),
                                  ),

                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsLight,
                                        fontSize: 10,
                                        color: Color(0xff777777)),
                                  ),

                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsLight,
                                        fontSize: 10,
                                        color: Color(0xff777777)),
                                  ),

                                  // customBlueButton(
                                  //     context: context,
                                  //     text1:AppStrings.update,
                                  //     onTap1: () {
                                  //
                                  //       AuthProvider auth = Provider.of(context,listen: false);
                                  //       auth.updateUserProfileApi(
                                  //           context: context,
                                  //           nameee: nameController.text,
                                  //           lastNameee: lastNameController.text,
                                  //           countryy: countryController.text,
                                  //           cityy: cityController.text,
                                  //       );
                                  //     },
                                  //
                                  //     colour: AppColor.textLightBlueBlack),


                                ],
                              ),
                            ])));
              }),
            );
          }
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: customBlueButton(
            context: context,
            text1: tr(LocaleKeys.ownerProfile_update),
            onTap1: () {
              if (phNoController.text.isEmpty &&
                  nameController.text.trim().isEmpty) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    text: tr(LocaleKeys.additionText_entrNameNum));
              } else if (phNoController.text.isEmpty) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    text: tr(LocaleKeys.additionText_entrMobNum));
              } else if (nameController.text.trim().isEmpty) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    text: tr(LocaleKeys.additionText_entrNameNum));
              } else {
                if (phNoController.text.isNotEmpty &&
                    !phNoController.text.ismobile(phNoController.text)) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text:  tr(LocaleKeys.additionText_entrValidMobNum));
                } else {
                  AuthProvider auth = Provider.of(context, listen: false);
                  print("auth.phonecode${auth.cntrycodeOnr}");
                  print("auth.countryy${countryController.text}");
                  print("auth.AddressController${AddressController.text}");
                  if(countryController.text.isEmpty){
                    countryController.text=" ";
                  }
                  if(AddressController.text.isEmpty){
                       AddressController.text=" ";
                  }

                  auth.updateUserProfileApi(
                      context: context,
                      nameee: nameController.text.trim(),
                      lastNameee: lastNameController.text.trim(),
                      countryy: countryController.text.trim(),
                      cityy: cityController.text.trim(),
                      phonenum:phNoController.text,
                      phoneCodee:auth.cntrycodeOnr,
                      cntreShortCodee: auth.cntrycode,
                      onrAddress:AddressController.text.trim(),
                      // phoneCodee:auth.phncodeOnr,
                      // cntreShortCodee: auth.cntrycodeOnr

                  );
                }
              }


              // else{
              //   AuthProvider auth = Provider.of(context, listen: false);
              //   print("auth.phonecode${auth.phncode}");
              //   auth.updateUserProfileApi(
              //       context: context,
              //       nameee: nameController.text,
              //       lastNameee: lastNameController.text,
              //       countryy: countryController.text,
              //       cityy: cityController.text,
              //       phonenum:phNoController.text,
              //      phoneCodee:auth.phncode,
              //     cntreShortCodee: auth.cntrycode
              //
              //
              //   );
              //
              // }

            },
            colour: AppColor.newBlueGrey),

      ),

    );
  }
}
