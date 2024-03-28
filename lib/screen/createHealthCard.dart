import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/commingSoonAlert.dart';
import '../generated/locale_keys.g.dart';

class CreateHealthCard extends StatefulWidget {
  const CreateHealthCard({Key? key}) : super(key: key);

  @override
  State<CreateHealthCard> createState() => _CreateHealthCardState();
}

class _CreateHealthCardState extends State<CreateHealthCard> {
  TextEditingController vacineController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController alergyController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();

  @override
  void initState() {
    print("*********");
    vacineController.clear();
    weightController.clear();
    alergyController.clear();
    treatmentController.clear();

    super.initState();
  }

  @override
  void dispose() {
    vacineController.clear();
    weightController.clear();
    alergyController.clear();
    treatmentController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BotttomBorder(context),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, bottom: 10),
              child: CustomButton(
                // context: context,
                text: tr(LocaleKeys.additionText_capSave),
                // tr(LocaleKeys.additionText_create),
                onPressed: () {
                  PetProvider petProvider = Provider.of(context, listen: false);

                  if (petProvider.PetallHlthCard.length >= 3 && petProvider.isUserPremium == 0) {
                    commingSoonDialog(context, isFullAccess: 1);
                  } else {
                    if (vacineController.text.trim().isNotEmpty &&
                        weightController.text.trim().isNotEmpty &&
                        alergyController.text.trim().isNotEmpty &&
                        treatmentController.text.trim().isNotEmpty) {
                      petProvider.callAddPetHealthApi(
                          context: context,
                          weight: weightController.text.trim(),
                          allergies: alergyController.text.trim(),
                          treatment: treatmentController.text.trim(),
                          vacination: vacineController.text.trim());

                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 200), () {
                        vacineController.clear();
                        weightController.clear();
                        alergyController.clear();
                        treatmentController.clear();
                      });
                    } else {
                      if (vacineController.text.trim().isEmpty &&
                          weightController.text.trim().isEmpty &&
                          alergyController.text.trim().isEmpty &&
                          treatmentController.text.trim().isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_entrAllFeilds),
                        );
                      } else if (weightController.text.trim().isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_wghtFldReq),
                        );
                      } else if (alergyController.text.trim().isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_lergyFldReq),
                        );
                      } else if (treatmentController.text.trim().isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_trtmntFldReq),
                        );
                      } else if (vacineController.text.trim().isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: tr(LocaleKeys.additionText_vacFldReq),
                        );
                      }
                    }
                  }
                },
              ),
            ),

            // BotttomBorder(context)
          ],
        ),
      ),

      backgroundColor: Colors.white,
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.72,
          minChildSize: 0.70,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),

                      Text(
                        tr(LocaleKeys.additionText_vaccin),
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                      ),

                      const SizedBox(
                        height: 8.0,
                      ),

                      CustomTextFeild(
                        textInputType: TextInputType.text,
                        hintText: tr(LocaleKeys.additionText_ntrVacName),
                        textController: vacineController,
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),

                      Text(
                        tr(LocaleKeys.additionText_wghtInKg),
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                      ),

                      const SizedBox(
                        height: 8.0,
                      ),

                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28.0),
                            color: AppColor.textFieldGrey,
                            border: Border.all(color: Colors.transparent)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            controller: weightController,
                            //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            autofocus: false,
                            scrollPadding: const EdgeInsets.all(20.0),
                            style: const TextStyle(
                              color: AppColor.textLightBlueBlack,
                              fontFamily: AppFont.poppinsMedium,
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.additionText_entrWeight),
                              counterText: "",
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

                      // SizedBox(
                      //   height: 8.0,
                      // ),

                      // CustomTextFeild(
                      //   textInputType: TextInputType.number,
                      //   hintText: AppStrings.entrWeight,
                      //   textController: weightController,
                      // ),

                      const SizedBox(
                        height: 15.0,
                      ),

                      Text(
                        tr(LocaleKeys.additionText_allergies),
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                      ),

                      const SizedBox(
                        height: 8.0,
                      ),

                      CustomTextFeild(
                        textInputType: TextInputType.text,
                        hintText: tr(LocaleKeys.additionText_ntrAlgTyp),
                        textController: alergyController,
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),

                      Text(
                        tr(LocaleKeys.additionText_treatments),
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                      ),

                      const SizedBox(
                        height: 8.0,
                      ),

                      CustomTextFeild(
                        textInputType: TextInputType.text,
                        hintText: tr(LocaleKeys.additionText_ntrTrtmntDetail),
                        textController: treatmentController,
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      const SizedBox(
                        height: 15.0,
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
