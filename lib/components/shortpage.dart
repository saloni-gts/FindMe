import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:find_me/components/camraOption.dart';
import 'package:find_me/components/customdropdown.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/appstrings.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../generated/locale_keys.g.dart';
import '../models/usermodel.dart';
import '../monish/screen/ownerProfile.dart';
import '../provider/authprovider.dart';
import '../screen/checkProtection.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'camPermissionAlert.dart';
import 'customBlueButton.dart';
import 'customTextFeild.dart';
import 'globalnavigatorkey.dart';

Future<FilePickerResult?> getFile() async {
  File getput;
  Map body = {};
  print("pick file");
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc'],
  ).onError((error, stackTrace) {
    print("Access Denied $error");
    return null;
  });
  return result;
}

int x = 0;
int z = 0;

Future<File?> getImage(ImageSource source, {bool circleCropStyle = true, bool isCropped = true}) async {
// PetProvider petProvider=Provider.of(GlobalVariable.navState.currentContext!,listen: false);
// petProvider.updateLoader(true);

  print("isCropped===$isCropped");
  print("TEST!!1");
  final ImagePicker picker = ImagePicker();
// petProvider.updateLoader(false);
  final pickedFile = await picker
      .pickImage(
    source: source,
  )
      .onError((error, stackTrace) async {
    var status3 = await Permission.camera.status;
    var status4 = await Permission.photos.status;

    print("status4status4$status4");

    print("value of status===>>> $status3");
    if (!status3.isGranted) {
      print("x value is ==>$x");

      if (x >= 1) {
        camPermissionDialog(GlobalVariable.navState.currentContext!);
      }

      if (x == 0) {
        await Permission.camera.request();
      }
      x = x + 1;
    }
    return null;
  });
  if (isCropped) {
    if (pickedFile != null) {
      // Image? image = await cropKey.currentState?.cropImage();

      var cropfile = await ImageCropper.platform.cropImage(
        cropStyle: (circleCropStyle == true) ? CropStyle.circle : CropStyle.rectangle,
        sourcePath: pickedFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
      );
      return File(cropfile?.path ?? "");
    }
  } else {
    return File(pickedFile?.path ?? "");
  }

  return null;
}

int i = 0;
Future<File?> getDirectImage(ImageSource source, {bool circleCropStyle = true}) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker
      .pickImage(
    source: source,
  )
      .onError((error, stackTrace) {
    print("value of int i===$i");
    if (i > 0) {
      camPermissionDialog(GlobalVariable.navState.currentContext!);
    } else {}
    i = i + 1;
    print("IN CAMERA EXCEPTION $error");
    return null;
  });
  if (pickedFile != null) {
    var cropfile = await ImageCropper.platform.cropImage(
      cropStyle: (circleCropStyle == true) ? CropStyle.circle : CropStyle.rectangle,
      sourcePath: pickedFile.path,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    return File(cropfile?.path ?? "");
  }
  return null;
}

class PetShortPage extends StatefulWidget {
  int val;

  PetShortPage({Key? key, this.val = 0}) : super(key: key);

  @override
  State<PetShortPage> createState() => _PetShortPageState();
}

class _PetShortPageState extends State<PetShortPage> {
  late PetProvider petProvider1;
  File? img;
  String timestampGmt = "";
  TextEditingController petbirthController = TextEditingController();
  TextEditingController petbreedController = TextEditingController();
  TextEditingController petcolorController = TextEditingController();
  TextEditingController petdescpController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;

  @override
  void initState() {
    //print("check if num added.....${user.mobileNumber}");

    petProvider1 = Provider.of(context, listen: false);

    petProvider1.addPetChackVal = false;

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

  @override
  void dispose() {
    super.dispose();
  }

  var loginUser = HiveHandler.getUser();
  callunfocus() {
    print("CHK FLOW");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.84,
          minChildSize: 0.79,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                const SizedBox(
                  height: 15.0,
                ),
                Consumer<PetProvider>(
                  builder: (context, petProvider, child) {
                    String pettypebool = petProvider.selectedPetType?.title ?? "";
                    String petGenderbool = petProvider.selectedPetGender?.title ?? "";
                    String petSerializationbool = petProvider.selectedSerialization?.title ?? "";
                    String petSizeBool = petProvider.selectedPetSize?.title ?? "";
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.newGrey,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(65),
                                        child: petProvider.petImage != null
                                            ? Image.file(
                                                File(petProvider.petImage?.path ?? ""),
                                                height: 122,
                                                width: 122,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                AppImage.placeholderIcon,
                                                height: 122,
                                                width: 122,
                                              ),
                                      ))),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 78.0),
                                  child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.newGrey,
                                          border: Border.all(color: Colors.white)),
                                      child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.asset(AppImage.cameraIcon, fit: BoxFit.fill),
                                        ),
                                        onTap: () async {
                                          showAlertForImage(
                                            headText: "Select",
                                            // tr(LocaleKeys.additionText_yes),
                                            callBack: (val) {
                                              Navigator.pop(context);
                                              if (val) {
                                                getImage(
                                                  ImageSource.camera,
                                                ).then((value) {
                                                  print("value==$value");
                                                  if (value.toString() == "File: ''") {
                                                    print("value like this===");
                                                    value = null;
                                                  }

                                                  if (value != null) {
                                                    petProvider.updateImage(value);
                                                  }
                                                });
                                              } else {
                                                getImage(ImageSource.gallery, isCropped: false).then((value) {
                                                  print("value==$value");
                                                  if (value.toString() == "File: ''") {
                                                    print("value like this===");
                                                    value = null;
                                                  }

                                                  if (value != null) {
                                                    petProvider.updateImage(value);
                                                  }
                                                });
                                              }
                                            },
                                            context: context,
                                          );
                                        },
                                      )),
                                ),
                              ),
                            ],
                          ),
                          petProvider.isUserPremium == 1 && petProvider.permPetCountAddPet <= 3
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * .65,

                                      child: Text(
                                        tr(LocaleKeys.additionText_actiPreFetr),
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinsBold),
                                      ),
                                      // color: Colors.indigo,
                                    ),
                                    const Spacer(),

                                    Consumer<PetProvider>(builder: (context, petProvider, child) {
                                      return Checkbox(
                                          activeColor: AppColor.textLightBlueBlack,
                                          value: petProvider.addPetChackVal,
                                          // groupValue: ,
                                          onChanged: (value) {
                                            petProvider.changePetPremAdd();
                                            petProvider.changeAddPetChackVal();
                                          });
                                    }) //selected value
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tr(LocaleKeys.addPet_name),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColor.textLightBlueBlack,
                                fontFamily: AppFont.poppinsRegular,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomTextFeild(
                            textController: petProvider.petNameController,
                            textInputType: TextInputType.text,
                            hintText: tr(LocaleKeys.additionText_entrPetName),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tr(LocaleKeys.addPet_petType),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColor.textLightBlueBlack,
                                fontFamily: AppFont.poppinsRegular,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0.0,
                          ),
                          CustomDropDown<PetTypeModl>(
                            isGrey: pettypebool.isEmpty,
                            selectText: petProvider.selectedPetType?.title ?? tr(LocaleKeys.additionText_select),
                            itemList: petTypeList,
                            isEnable: true,
                            onChange: (val) {
                              petProvider.enableAddPetButton();
                              petProvider.onselectPetType(val);
                              print("AddPetButton==${petProvider.AddPetButton}");
                            },
                            title: "",
                            value: null,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor: AppColor.newBlueGrey,
                                      toggleable: true,
                                      value: true,
                                      groupValue: petProvider.radioVal,
                                      onChanged: (value) {
                                        petProvider.onRadioChange();
                                        print(value); //selected value
                                      }),
                                  const Text(
                                    AppStrings.microchip,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinsRegular,
                                    ),
                                  ),
                                ],
                              )),
                          petProvider.radioVal
                              ? CustomTextFeild(
                                  textController: petProvider.petmicrochipController,
                                  textInputType: TextInputType.text,
                                  hintText: AppStrings.microchip,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 5.0,
                          ),
                          widget.val == 1
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        tr(LocaleKeys.addPet_birthday),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsRegular,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                                selectableDayPredicate: (day) {
                                                  return true;
                                                },
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime.now())
                                            .then((value) {
                                          var date = DateTime.parse(value.toString());
                                          petbirthController.text = "${date.day}-${date.month}-${date.year}";
                                          date = date.add(const Duration(hours: 5, minutes: 30));
                                          timestampGmt = date.millisecondsSinceEpoch.toString();

                                          print("TIMESTAMPP $timestampGmt");
                                        });
                                      },
                                      child: CustomTextFeild(
                                        isEnabled: false,
                                        textController: petbirthController,
                                        textInputType: TextInputType.text,
                                        hintText: tr(LocaleKeys.additionText_select),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        tr(LocaleKeys.addPet_breed),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsRegular,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomTextFeild(
                                      textController: petbreedController,
                                      textInputType: TextInputType.text,
                                      hintText: tr(LocaleKeys.additionText_entrBreed),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
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
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: AppColor.textLightBlueBlack,
                                                    fontFamily: AppFont.poppinsRegular,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              CustomDropDown<PetTypeModl>(
                                                isGrey: petGenderbool.isEmpty,
                                                selectText: petProvider.selectedPetGender?.title ??
                                                    tr(LocaleKeys.additionText_select),
                                                itemList: petGenderList,
                                                isEnable: true,
                                                onChange: (val) {
                                                  petProvider.onselectPetGender(val);
                                                },
                                                title: "",
                                                value: null,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    tr(LocaleKeys.addPet_sterilization),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                      color: AppColor.textLightBlueBlack,
                                                      fontFamily: AppFont.poppinsRegular,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              CustomDropDown<PetTypeModl>(
                                                isGrey: petSerializationbool.isEmpty,
                                                selectText: petProvider.selectedSerialization?.title ??
                                                    tr(LocaleKeys.additionText_select),
                                                itemList: petserializationList,
                                                isEnable: true,
                                                onChange: (val) {
                                                  petProvider.onSerializationSelect(val);
                                                },
                                                title: "",
                                                value: null,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        tr(LocaleKeys.addPet_color),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsRegular,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomTextFeild(
                                        textController: petcolorController,
                                        textInputType: TextInputType.text,
                                        hintText: tr(LocaleKeys.additionText_entrPetColor)),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        tr(LocaleKeys.addPet_size),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsRegular,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomDropDown<PetTypeModl>(
                                      isGrey: petSizeBool.isEmpty,
                                      selectText:
                                          petProvider.selectedPetSize?.title ?? tr(LocaleKeys.additionText_select),
                                      itemList: petSizeList,
                                      isEnable: true,
                                      onChange: (val) {
                                        petProvider.onselectPetSize(val);
                                      },
                                      title: "",
                                      value: null,
                                    ),
                                    //CustomDropDown(onChange: onChange, value: value, itemList: itemList, title: title, isEnable: isEnable)
                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        tr(LocaleKeys.addPet_shortDesciption),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsRegular,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(28.0),
                                          color: AppColor.textFieldGrey,
                                          border: Border.all(color: Colors.transparent)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                        child: TextField(
                                          maxLines: 3,
                                          controller: petdescpController,
                                          //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                          autofocus: false,
                                          scrollPadding: const EdgeInsets.all(20.0),
                                          style: const TextStyle(
                                            color: AppColor.textLightBlueBlack,
                                            fontFamily: AppFont.poppinsMedium,
                                            fontSize: 18.0,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: tr(LocaleKeys.additionText_descYrPet),
                                            hintStyle: const TextStyle(
                                              color: AppColor.textGreyColor,
                                              fontFamily: AppFont.poppinsMedium,
                                              fontSize: 15.0,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    // CustomTextFeild(
                                    //     textController: petdescpController,
                                    //     textInputType: TextInputType.text,
                                    //     hintText: "Describe your pet"),

                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                            text: tr(LocaleKeys.addPet_contact),
                                            // textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              color: AppColor.textLightBlueBlack,
                                              fontFamily: AppFont.poppinsRegular,
                                            ),
                                            children: const [
                                              TextSpan(
                                                  text: '',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ))
                                            ]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomTextFeild(
                                        hintText: tr(LocaleKeys.addPet_contact),
                                        textController: mobileController,
                                        textInputType: TextInputType.phone),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        tr(LocaleKeys.addPet_city),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.textLightBlueBlack,
                                          fontFamily: AppFont.poppinsRegular,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomTextFeild(
                                      textController: cityController,
                                      textInputType: TextInputType.text,
                                      hintText: tr(LocaleKeys.additionText_entrCity),
                                    ),

                                    const Text(
                                      "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.textLightBlueBlack,
                                        fontFamily: AppFont.poppinsRegular,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    );
                  },
                ),
                // customBlueButton(
                //     context: context,
                //     text1: "SAVE",
                //     onTap1: () {
                //       if (petProvider1.petNameController.text.isNotEmpty &&
                //           petProvider1.selectedPetType != null) {
                //         petProvider1.addPetCalling(
                //             bred: petbreedController.text,
                //             bdate: timestampGmt,
                //             city: cityController.text,
                //             contact: mobileController.text,
                //             microchipp: petProvider1.petmicrochipController.text,
                //             petcolr: petcolorController.text,
                //             petnme: petProvider1.petNameController.text,
                //             shortdesc: petdescpController.text,
                //             contxt: context);
                //       } else {
                //         if (petProvider1.petNameController.text.isEmpty &&
                //             petProvider1.selectedPetType == null) {
                //           CoolAlert.show(
                //               context: context,
                //               type: CoolAlertType.warning,
                //               text: "Enter Pet Name and Pet Type ");
                //         } else if (petProvider1.petNameController.text.isEmpty) {
                //           CoolAlert.show(
                //               context: context,
                //               type: CoolAlertType.warning,
                //               text: "Enter Pet Name ");
                //         } else if (petProvider1.selectedPetType == null) {
                //           CoolAlert.show(
                //               context: context,
                //               type: CoolAlertType.warning,
                //               text: "Enter Pet Type ");
                //         }
                //       }
                //     },
                //     colour: AppColor.textLightBlueBlack
                // ),
                //
              ]),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 22.0),
        child: Consumer<PetProvider>(builder: (context, petProvider, child) {
          return customBlueButton(
              context: context,
              text1: tr(LocaleKeys.additionText_save),
              onTap1: () {
                print("(petProvider1.petNameController.text==${petProvider1.petNameController.text}");
                print("(petProvider1.petNameController.text==${petProvider1.selectedPetType}");
                if (petProvider1.petNameController.text.trim().isEmpty || petProvider1.selectedPetType == null) {
                } else {
                  if (petProvider1.petNameController.text.trim().isNotEmpty && petProvider1.selectedPetType != null) {
                    petProvider1.addPetCalling(
                        bred: petbreedController.text,
                        bdate: timestampGmt,
                        city: cityController.text,
                        contact: mobileController.text,
                        microchipp: petProvider1.petmicrochipController.text,
                        petcolr: petcolorController.text,
                        petnme: petProvider1.petNameController.text.trim(),
                        shortdesc: petdescpController.text,
                        contxt: context);
                  } else {
                    if (petProvider1.petNameController.text.trim().isEmpty && petProvider1.selectedPetType == null) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_entrPetNameType));
                    } else if (petProvider1.petNameController.text.trim().isEmpty) {
                      CoolAlert.show(
                          context: context, type: CoolAlertType.warning, text: tr(LocaleKeys.additionText_entrPetName));
                    } else if (petProvider1.selectedPetType == null) {
                      CoolAlert.show(
                          context: context, type: CoolAlertType.warning, text: tr(LocaleKeys.additionText_entrPetType));
                    }
                  }
                }
              },
              colour: (petProvider1.petNameController.text.trim().isEmpty || petProvider1.selectedPetType == null)
                  ? AppColor.disableButton
                  : AppColor.newBlueGrey);
        }),
      ),
    );
  }

  void bottomSheetShow() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 250,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          );
        });
  }
}
