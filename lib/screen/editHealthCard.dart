import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customBlueButton.dart';
import '../components/customSmallBlueButton.dart';
import '../generated/locale_keys.g.dart';
import '../models/healthCardModel.dart';
import '../provider/petprovider.dart';
import '../util/color.dart';

class EditHealthCard extends StatefulWidget {
  const EditHealthCard({Key? key}) : super(key: key);

  @override
  State<EditHealthCard> createState() => _EditHealthCardState();
}

class _EditHealthCardState extends State<EditHealthCard> {

  TextEditingController editvacineController = new TextEditingController();
  TextEditingController editweightController = new TextEditingController();
  TextEditingController editalergyController = new TextEditingController();
  TextEditingController edittreatmentController = new TextEditingController();

  @override
  var v1;

  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    HealthCard? editHealthCardData = petProvider.selectedCard;
    print("${editHealthCardData!.Weight}");
    v1 = editHealthCardData!.Weight;

    editvacineController.text = editHealthCardData?.Vaccination ?? "";
    editweightController.text = v1.toString();
    editalergyController.text = editHealthCardData?.Allergies ?? "";
    edittreatmentController.text = editHealthCardData?.Treatments ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          return Scaffold(
            // bottomNavigationBar: BotttomBorder(context),


            floatingActionButtonLocation: FloatingActionButtonLocation
                .endDocked,
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0,),
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
                                colour: AppColor.newGrey,
                                context: context,
                                onTap1: () {
                                  showDialog(
                                      context: context,
                                      builder: (context1) {
                                        return AlertDialog(
                                          title: Text(
                                              tr(LocaleKeys.additionText_sureDelHlthCard)),
                                          actions: <Widget>[
                                            InkWell(
                                              child: Text(
                                                tr(LocaleKeys.additionText_cancel),
                                                style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontFamily: AppFont
                                                        .poppinsMedium),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context1);
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
                                                    fontFamily: AppFont
                                                        .poppinsMedium),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context1);

                                                petProvider
                                                    .callDeletePetHealthApi(
                                                  context: context,
                                                  idddd: petProvider.healthCardId,

                                                );
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                text1:tr(LocaleKeys.additionText_Delete))),
                        Expanded(
                          child: SizedBox(),
                          flex: 4,
                        ),
                        Expanded(
                            flex: 40,
                            child: customSmallBlueButton(
                                colour: AppColor.newBlueGrey,
                                context: context,
                                onTap1: () {

                                  if(editvacineController.text.trim().isNotEmpty &&
                                      editweightController.text.trim().isNotEmpty &&
                                      editalergyController.text.trim().isNotEmpty &&
                                      edittreatmentController.text.trim().isNotEmpty) {
                                    petProvider.callEditPetHealthApi(
                                      context: context,
                                      vacination: editvacineController.text
                                          .trim(),
                                      treatment: edittreatmentController.text
                                          .trim(),
                                      allergies: editalergyController.text.trim(),
                                      weight: double.parse(
                                          editweightController.text.trim()),
                                      iddd: petProvider.healthCardId,

                                    );
                                  }
                                  else{
                                    if (editvacineController.text.trim().isEmpty &&
                                        editweightController.text.trim().isEmpty &&
                                        editalergyController.text.trim().isEmpty &&
                                        edittreatmentController.text.trim().isEmpty){
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          text: tr(LocaleKeys.additionText_entrAllFeilds),);
                                    }

                                    else if (editweightController.text.isEmpty) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          text:  tr(LocaleKeys.additionText_wghtFldReq),);
                                    } else if (editalergyController.text.isEmpty) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          text:   tr(LocaleKeys.additionText_lergyFldReq),);
                                    } else if (edittreatmentController.text.isEmpty) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          text:  tr(LocaleKeys.additionText_trtmntFldReq),);
                                    } else if (editvacineController.text.isEmpty) {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          text:  tr(LocaleKeys.additionText_vacFldReq),);
                                    }
                                  //       tr(LocaleKeys.additionText_wghtFldReq),

                                  }



                                },
                                text1:tr(LocaleKeys.additionText_capUpdte),
                            )


                        )
                      ],
                    ),
                  ),
                ),
                
                BotttomBorder(context)
              ],
            ),


            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: true,

            appBar: customAppbar(
              titlename:tr(LocaleKeys.additionText_editHlthCard),
              isbackbutton: true,
            ),
            body: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.72,
                minChildSize: 0.70,
                maxChildSize: 0.9,
              builder: (BuildContext context,ScrollController scrollController) {
                return GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),

                          Text(
                            tr(LocaleKeys.additionText_vaccin),
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColor
                                    .textLightBlueBlack,
                                fontFamily:
                                AppFont.poppinsBold),
                          ),

                          SizedBox(
                            height: 8.0,
                          ),

                          CustomTextFeild(
                            textInputType: TextInputType.text,
                            hintText: tr(LocaleKeys.additionText_ntrVacName),
                            textController: editvacineController,
                          ),


                          SizedBox(
                            height: 10.0,
                          ),


                          Text(
                            tr(LocaleKeys.additionText_wghtInKg),
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColor
                                    .textLightBlueBlack,
                                fontFamily:
                                AppFont.poppinsBold),
                          ),

                          SizedBox(
                            height: 8.0,
                          ),

                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28.0),
                                color: AppColor.textFieldGrey,
                                border:
                                Border.all(color: Colors.transparent)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                controller:
                                editweightController,
                                //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                autofocus: false,
                                scrollPadding: EdgeInsets.all(20.0),
                                style: TextStyle(
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinsMedium,
                                  fontSize: 18.0,
                                ),
                                decoration: InputDecoration(
                                  hintText:  tr(LocaleKeys.additionText_entrWeight),
                                  counterText: "",
                                  hintStyle: TextStyle(
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
                          SizedBox(
                            height: 10.0,
                          ),


                          Text(
                            tr(LocaleKeys.additionText_allergies),
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColor
                                    .textLightBlueBlack,
                                fontFamily:
                                AppFont.poppinsBold),
                          ),

                          SizedBox(
                            height: 8.0,
                          ),

                          CustomTextFeild(
                            textInputType: TextInputType.text,
                            hintText: tr(LocaleKeys.additionText_ntrAlgTyp),
                            textController: editalergyController,
                          ),

                          SizedBox(
                            height: 10.0,
                          ),


                          Text(
                            tr(LocaleKeys.additionText_treatments),
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColor
                                    .textLightBlueBlack,
                                fontFamily:
                                AppFont.poppinsBold),
                          ),

                          SizedBox(
                            height: 8.0,
                          ),

                          CustomTextFeild(
                            textInputType: TextInputType.text,
                            hintText: tr(LocaleKeys.additionText_ntrTrtmntDetail),
                            textController: edittreatmentController,
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          // customBlueButton(context: context,
                          //     text1: tr(LocaleKeys.additionText_Delete),
                          //     onTap1: () {},
                          //     colour: AppColor.textRed),

                          SizedBox(
                            height: 15.0,
                          )

                        ],
                      ),
                    ),
                  ),
                );
              }
            ),


          );
        });
  }
}
