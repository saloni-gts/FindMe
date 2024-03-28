import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/models/achievement_model.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/appbarComp.dart';
import '../components/bottomBorderComp.dart';
import '../components/camPermissionAlert.dart';
import '../components/camraOption.dart';
import '../components/shortpage.dart';
import '../util/app_images.dart';
import '../util/appstrings.dart';
import '../util/color.dart';

class AddAchieven extends StatefulWidget {
  final AchievementModel? achievementModel;
  const AddAchieven({Key? key, this.achievementModel}) : super(key: key);

  @override
  State<AddAchieven> createState() => _AddAchievenState();
}

class _AddAchievenState extends State<AddAchieven> {
  late TextEditingController nameController;
  late TextEditingController desciptionController;
  late AchievementProvider provider;
  late PetProvider petProvider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    petProvider = Provider.of(context, listen: false);
    nameController = TextEditingController();
    desciptionController = TextEditingController();
    nameController.text = widget.achievementModel?.title ?? "";
    desciptionController.text = widget.achievementModel?.description ?? "";
    provider.updateAchievementImage(null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget.achievementModel != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: CustomButton(
                      // context: context,
                      text: tr(LocaleKeys.additionText_capDel),
                      onPressed: () {
                        provider.callDeleteAchievement(widget.achievementModel?.id ?? 0, context);
                      },
                      clr: AppColor.newGrey),
                )
              : const SizedBox(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: CustomButton(
              // context: context,
              text: widget.achievementModel != null
                  ? tr(LocaleKeys.additionText_capUpdte)
                  : tr(LocaleKeys.additionText_capSave),
              onPressed: () {
                if (widget.achievementModel != null) {
                  provider.updateAchieveMent(widget.achievementModel?.id ?? 0, nameController.text,
                      desciptionController.text, widget.achievementModel?.halfUrl ?? "", context);
                } else {
                  if (nameController.text.trim().isEmpty) {
                    CoolAlert.show(
                        context: context, type: CoolAlertType.error, text: tr(LocaleKeys.additionText_plsNtrName));
                  } else if (desciptionController.text.trim().isEmpty) {
                    CoolAlert.show(
                        context: context, type: CoolAlertType.error, text: tr(LocaleKeys.additionText_plsNtrDesc));
                  } else if (provider.achievementImage == null) {
                    CoolAlert.show(
                        context: context, type: CoolAlertType.error, text: tr(LocaleKeys.additionText_plsAdImg));
                  } else {
                    provider.callAddAchieve(
                      widget.achievementModel != null
                          ? widget.achievementModel?.id ?? 0
                          : petProvider.selectedPetDetail?.id ?? 0,
                      nameController.text,
                      desciptionController.text,
                      context,
                      isForEdit: widget.achievementModel != null,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BotttomBorder(context),
      appBar: CustomCurvedAppbar(
          isTitleCenter: true,
          // isbackbutton: true,
          title: widget.achievementModel == null
              ? tr(LocaleKeys.additionText_addAcheve)
              : tr(LocaleKeys.additionText_editAcheve)),
      body: GestureDetector(
        onTap: () {
          print("fhgfh");
          FocusManager.instance.primaryFocus?.unfocus();
          // Focus.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    showAlertForImage(
                      headText: tr(LocaleKeys.additionText_petName),
                      callBack: (val) {
                        print("TTST $val");
                        Navigator.pop(context);
                        if (val) {
                          print("TTST $val");
                          getImage(ImageSource.camera, isCropped: false).then((value) {
                            print("values is >> $value");
                            print("value==$value");
                            if (value.toString() == "File: ''") {
                              print("value like this===");
                              value = null;
                            }

                            if (value != null) {
                              provider.updateAchievementImage(value);
                            }
                          });
                        } else {
                          getImage(ImageSource.gallery, isCropped: false).then((value) {
                            print("values is >> $value");
                            print("value==$value");
                            if (value.toString() == "File: ''") {
                              print("value like this===");
                              value = null;
                            }

                            if (value != null) {
                              provider.updateAchievementImage(value);
                            }
                          });
                        }
                      },
                      context: context,
                    );
                  },
                  child: Center(
                    child: Container(
                      height: 180,
                      width: 250,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 0,
                            child: Consumer<AchievementProvider>(
                              builder: (context, data, child) {
                                return Container(
                                  height: 170,
                                  width: 240,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.textFieldGrey,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: data.achievementImage != null
                                        ? Image.file(
                                            File(data.achievementImage?.path ?? ""),
                                            height: 170,
                                            width: 240,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: widget.achievementModel?.images ?? "",
                                            fit: BoxFit.cover,
                                            height: 170,
                                            width: 240,
                                            placeholder: (context, url) => Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Image.asset(
                                                AppImage.achievePlaceholder,
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Image.asset(
                                                AppImage.achievePlaceholder,
                                                // fit: BoxFit.cover,
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                color: AppColor.buttonPink,
                              ),
                              child: InkWell(
                                child: ClipRRect(
                                  child: Image.asset(AppImage.cameraIcon),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          tr(LocaleKeys.additionText_acheveName),
                          style: const TextStyle(
                              fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                        ),
                      ),
                      Container(
                        child: CustomTextFeild(
                          textController: nameController,
                          hintText: tr(LocaleKeys.additionText_entrAcheveName),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          tr(LocaleKeys.additionText_acheveDesc),
                          style: const TextStyle(
                              fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                        ),
                      ),
                      CustomTextFeild(
                        textController: desciptionController,
                        hintText: tr(LocaleKeys.additionText_entrAcheveDesc),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
