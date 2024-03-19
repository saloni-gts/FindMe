
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/models/weightDetailModel.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/appstrings.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';


import '../components/docCategoryContainer.dart';
import '../generated/locale_keys.g.dart';
import '../monish/models/newModel.dart';
import '../monish/provider/myProvider.dart';
import '../monish/screen/weightTrakrMain.dart';

class EditRecord extends StatefulWidget {
  const EditRecord({Key? key}) : super(key: key);

  @override
  State<EditRecord> createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  TextEditingController weightController = new TextEditingController();
  TextEditingController dateOfWeightController = new TextEditingController();
  TextEditingController weigtDescController = new TextEditingController();
  String timestampGmt = "";
  String dateWeight = "";
  int? recEditId;

  // List<PetWeightData> weightOfPet=[];


  void initState(){

    WeightDetails weightDetails;
    PetProvider petProvider=Provider.of(context,listen: false);
    WeightDetails? selWeightDet= petProvider.selectedWeight;



    weightController.text=selWeightDet!.weight.toString();
    weigtDescController.text=selWeightDet.description!;
    dateOfWeightController.text=dateConverterrr(int.parse(selWeightDet.date!));
    print("checking the value of date === ${dateConverterrr(int.parse(selWeightDet.date!))}");
    print("checking the value of id === ${selWeightDet.id}");

    recEditId=selWeightDet.id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Myprovider Pro = Provider.of(context, listen: false);

    // int length=Pro.weightOfPet.length();

    return Scaffold(
        appBar: customAppbar(
          titlename:  tr(LocaleKeys.additionText_editRec),
          isbackbutton: true,
        ),
        bottomNavigationBar: BotttomBorder(context),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: customBlueButton(
              context: context,
              text1: tr(LocaleKeys.additionText_confirm),
              onTap1: () {
                PetProvider petProvider = Provider.of(context, listen: false);

                if(weightController.text.trim().isNotEmpty && weigtDescController.text.trim().isNotEmpty && dateOfWeightController.text.trim().isNotEmpty){
                  petProvider.callEditWeight(
                    context: context,
                    weight: weightController.text.trim(),
                    wtDesc: weigtDescController.text.trim(),
                    wtDate: timestampGmt,
                    recId:petProvider.selectedWeight?.id??0,
                    // recEditId??0,
                  );

                }

                else{


                  if(weightController.text.trim().isEmpty && weigtDescController.text.trim().isEmpty && dateOfWeightController.text.trim().isEmpty){
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text: tr(LocaleKeys.additionText_entrAllFeilds));
                  }


                  else if(weightController.text.trim().isEmpty){
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text: tr(LocaleKeys.additionText_entrWegt));
                  }

                  else if(weigtDescController.text.trim().isEmpty){
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text: tr(LocaleKeys.additionText_entrDesc));
                  }

                  else if(dateOfWeightController.text.trim().isEmpty){
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text: tr(LocaleKeys.additionText_entrWetDate));
                  }

                }


              },


              colour: AppColor.newBlueGrey),
        ),
        body: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.83,
            minChildSize: 0.79,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Consumer2<PetProvider, Myprovider>(
                    builder: (context,petProvider, myprovider, child) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        // radius: 50,
                                        child: CachedNetworkImage(
                                          imageUrl: petProvider.selectedPetDetail?.petPhoto??"",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Image.asset(
                                            AppImage.dogCircleImage,
                                            fit: BoxFit.fill,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                AppImage.dogCircleImage,
                                                fit: BoxFit.fill,
                                              ),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   left: 65.0,
                                    //   top: 0,
                                    //   child: InkWell(
                                    //     child: ClipRRect(
                                    //       child: Image.asset(AppImage.greenCheckIcon),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Center(
                                child: Text(
                                  petProvider.selectedPetDetail?.petName??"",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinSemibold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                tr(LocaleKeys.additionText_Weight),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28.0),
                                    color: AppColor.textFieldGrey,
                                    border: Border.all(color: Colors.transparent)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 12.0, right: 12.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    controller: weightController,
                                    //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                    autofocus: false,
                                    scrollPadding: EdgeInsets.all(20.0),
                                    style: TextStyle(
                                      color: AppColor.textLightBlueBlack,
                                      fontFamily: AppFont.poppinsMedium,
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintStyle: TextStyle(
                                        color: AppColor.textGreyColor,
                                        fontFamily: AppFont.poppinsMedium,
                                        fontSize: 15.0,
                                      ),
                                      hintText: tr(LocaleKeys.additionText_kg),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              // CustomTextFeild(
                              //   hintText: "Kg",
                              //   textController: weightController,
                              //   textInputType: TextInputType.text,
                              // ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                 tr(LocaleKeys.additionText_entrWetDate),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              InkWell(
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now())
                                        .then((value) {
                                      print("******------${value}-----******");

                                      var date = DateTime.parse(value.toString());

                                      date =
                                          date.add(Duration(hours: 5, minutes: 30));
                                      timestampGmt =
                                          date.millisecondsSinceEpoch.toString();
                                      print("TIMESTAMPP ${timestampGmt}");
                                      print("GMTGMT ${DateTime.now().millisecondsSinceEpoch}");
                                      dateOfWeightController.text = dateConverterrr(int.parse(timestampGmt));
                                    });
                                  },
                                  child: CustomTextFeild(
                                      isEnabled: false,
                                      textInputType: TextInputType.none,
                                      textController: dateOfWeightController)),

                              //
                              // CustomTextFeild(
                              //   textController: dateOfWeightController,
                              // ),

                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                AppStrings.remark,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              // SizedBox(
                              //   height: 10,
                              // ),

                              // CustomTextFeild(
                              //   textController: weigtDescController,
                              //   hintText: "Describe what affects a pet's weight",
                              //   textInputType: TextInputType.text,
                              // ),

                              SizedBox(
                                height: 10,
                              ),

                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(28.0),
                              //       color: AppColor.textFieldGrey,
                              //       border: Border.all(color: Colors.transparent)),
                              //   child: new ConstrainedBox(
                              //     constraints: BoxConstraints(
                              //       maxHeight: 150.0,
                              //     ),
                              //     child: new Scrollbar(
                              //       child: new SingleChildScrollView(
                              //         scrollDirection: Axis.vertical,
                              //         reverse: true,
                              //         child: Padding(
                              //           padding: const EdgeInsets.only(
                              //               left: 12.0, right: 12.0),
                              //           child: new TextField(
                              //             controller: weigtDescController,
                              //
                              //             autofocus: false,
                              //             minLines: 5,
                              //             maxLines: null,
                              //             scrollPadding: EdgeInsets.all(20.0),
                              //             style: TextStyle(
                              //                 color: AppColor.textLightBlueBlack,
                              //                 fontFamily: AppFont.poppinsMedium,
                              //                 fontSize: 18.0),
                              //             decoration: InputDecoration(
                              //                 hintStyle: TextStyle(
                              //                     color: AppColor.textGreyColor,
                              //                     fontFamily: AppFont.poppinsMedium,
                              //                     fontSize: 15.0),
                              //                 hintText: AppStrings.descWhatAfctPet,
                              //                 border: InputBorder.none,
                              //                 focusedBorder: InputBorder.none),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              SizedBox(
                                height: 5.0,
                              ),



                              CustomTextFeild(
                                isEnabled: true,
                                textController: weigtDescController,
                                textInputType: TextInputType.text,
                              ),

                              //

                              // Container(
                              //
                              //   // height: petProvider.tagNumLst.length >2? 70 : 51,
                              //   height: 50,
                              //
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(28.0),
                              //       color: AppColor.textFieldGrey,
                              //       border: Border.all(color: Colors.transparent)),
                              //   child: Padding(
                              //     padding:
                              //     const EdgeInsets.only( left: 15.0,),
                              //     child: Container(
                              //       height: 60,
                              //       child: TextField(
                              //
                              //
                              //         maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              //         autofocus: false,
                              //         enabled: true,
                              //         scrollPadding: EdgeInsets.all(20.0),
                              //         controller: weigtDescController,
                              //         minLines: 1,
                              //
                              //         maxLines: 5,
                              //         style: TextStyle(
                              //             color: AppColor.textLightBlueBlack,
                              //             fontFamily: AppFont.poppinsMedium,
                              //             fontSize: 18.0
                              //         ),
                              //         decoration: InputDecoration(
                              //             hintText: AppStrings.descWhatAfctPet,
                              //             hintStyle: TextStyle(
                              //                 color: AppColor.textGreyColor,
                              //                 fontFamily: AppFont.poppinsMedium,
                              //                 fontSize: 15.0),
                              //             focusedBorder: InputBorder.none,
                              //             border: InputBorder.none,
                              //             // border: OutlineInputBorder()
                              //             enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(
                              //                     color: Colors.transparent))),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              //

                              //





                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),

                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            }));
  }

  String dateConverterrr(int date) {
    var d = DateTime.fromMillisecondsSinceEpoch(date);

    dateWeight = Jiffy(d).format("dd MMM y");
    return "${Jiffy(d).format("dd MMMM y ")}";
  }
}
