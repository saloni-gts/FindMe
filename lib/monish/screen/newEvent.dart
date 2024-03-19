import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/api/staus_enum.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/customBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../components/customdropdown.dart';
import '../../components/docCategoryContainer.dart';
import '../../components/radioButtonComp.dart';
import '../../components/reminderRadio.dart';
import '../../models/masterEvent.dart';
import '../../models/petdetailsmodel.dart';
import '../../provider/petprovider.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/appstrings.dart';
import '../../util/color.dart';
import '../provider/myProvider.dart';
import '../reUseClass/dropdown.dart';
import '../reUseClass/myappbar.dart';

class NewEvent extends StatefulWidget {
  bool frmPet;
  NewEvent({Key? key, required this.frmPet}) : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  late Myprovider my;

  var date1;
  var month1;
  var year1;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  TextEditingController recurringController = TextEditingController();

  TextEditingController eventRepeatController = TextEditingController();

  late var Switchcontroller = ValueNotifier<bool>(false);
  late var Switchcontroller2 = ValueNotifier<bool>(false);

  late PetProvider petProvider = Provider.of(context, listen: false);
  @override
  void initState() {
    petProvider = Provider.of(context, listen: false);
    petProvider.eventButton = 0;
    petProvider.selectedSubEvnt?.EventCatgoriesId = 1;
    petProvider.selectedSubEvnt?.id = 18;

    petProvider.setRepeat(Repeat.never);
    petProvider.setRemindVal("RemindTime.never");

    print("**************");
    petProvider.setValue("Repeat.never");

    petProvider.setReTime(RemindTime.never);

    // print();

    timestampGmt2 = "";

    petProvider.petRepeatEvent.text = "Never";
    petProvider.repeatType = 0;
    petProvider.showRadioList = 0;
    petProvider.showGreenTick(petProvider.petDetailList[0].id ?? 0);
    petProvider.getAllPet();

    petProvider.EvntcateApiCall(context);
    petProvider.selectedSubEvnt?.name = "Select";

    my = Provider.of(context, listen: false);
    my.updateSelectedData(0);
    super.initState();
  }

  String timestampGmt = "";
  String timestampGmt2 = "";
  var selectpet;
  var eventHr;
  var eventMin;

  @override
  Widget build(BuildContext context) {
    PetProvider provider = Provider.of(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: customAppbar(
        titlename: tr(LocaleKeys.newEvent_newEvent),
        isbackbutton: true,
        // icon: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 35.0, left: 18),
          // padding: const EdgeInsets.only(bottom: 35.0,left: 18),
          child: Consumer<PetProvider>(builder: (context, petProvider, child) {
            return customBlueButton(
                context: context,
                text1: tr(LocaleKeys.addPet_save),
                onTap1: () {
                  print("eventDateController.text====${eventNameController.text}");
                  print("eventDateController.text====${eventDateController.text}");
                  if (eventNameController.text.trim().isEmpty || eventDateController.text.isEmpty) {
                  } else {
                    PetProvider petProvider = Provider.of(context, listen: false);

                    if (petProvider.repeatType == 0) {
                      timestampGmt2 = "";
                    }
                    if (petProvider.repeatType != 0 && timestampGmt2.isEmpty) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text: tr(LocaleKeys.additionText_recrinTimeReq),
                      );
                    }

                    if (petProvider.repeatType != 0 && int.parse(timestampGmt) >= int.parse(timestampGmt2)) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text: tr(LocaleKeys.additionText_recTimGrtrRemindr),
                      );
                    } else {
                      if (eventNameController.text.trim().isNotEmpty && eventDateController.text.isNotEmpty) {
                        print("repeatType=====>>>${petProvider.repeatType}");
                        print("timestampGmt2=====>>>$timestampGmt2");
                        print("timestampGmt=====>>>$timestampGmt");

                        // if (petProvider.repeatType != 0 && timestampGmt2.isEmpty) {
                        //   // CoolAlert.show(
                        //   //     context: context,
                        //   //     type: CoolAlertType.warning,
                        //   //     text: "Recurring Time is required");
                        // }
                        // else {
                        provider.addEventP2ApiCall(
                            context: context,
                            pettidd: petProvider.selectedPetIdForEvent ?? 0,
                            name: eventNameController.text.trim(),
                            start: timestampGmt,
                            end: timestampGmt2,
                            evntCateid: petProvider.selectedSubEvnt?.EventCatgoriesId ?? 1,
                            evntCateType: petProvider.selectedSubEvnt?.id ?? 18,
                            fromPet: widget.frmPet);
                        // }
                      } else {
                        if (eventNameController.text.trim().isEmpty) {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: tr(LocaleKeys.additionText_plaseenternameofevent),
                          );
                        } else if (eventDateController.text.isEmpty) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: tr(LocaleKeys.additionText_plsSlectEvtDate));
                        }
                      }
                    }
                  }
                },
                colour: (eventNameController.text.trim().isEmpty || petProvider.eventButton == 0)
                    ? AppColor.disableButton
                    : AppColor.newBlueGrey);
          })),
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.89,
          minChildSize: 0.88,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Consumer2<PetProvider, Myprovider>(builder: (context, petProvider, myprovider, child) {
                  String petGenderbool = petProvider.selectedPetGender?.title ?? "";
                  return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Consumer<PetProvider>(
                                  builder: (context, petProvider, child) {
                                    var petList = petProvider.petDetailList;
                                    return SizedBox(
                                      height: 110.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: petList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                PetProvider provider = Provider.of(context, listen: false);

                                                provider.showGreenTick(petProvider.petDetailList[index].id ?? 0);

                                                var eventpetid = petProvider.petDetailList[index].id ?? 0;
                                                var eventpetphoto = petProvider.petDetailList[index].petPhoto ?? 0;
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(40),
                                                              color: AppColor.textFieldGrey),
                                                          height: 80,
                                                          width: 80,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(40),
                                                            child: CachedNetworkImage(
                                                              imageUrl: petList[index].petPhoto ?? "",
                                                              fit: BoxFit.cover,
                                                              placeholder: (context, url) => Padding(
                                                                padding: const EdgeInsets.all(15.0),
                                                                child: Image.asset(
                                                                  AppImage.placeholderIcon,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              errorWidget: (context, url, error) => Padding(
                                                                padding: const EdgeInsets.all(15.0),
                                                                child: Image.asset(
                                                                  AppImage.placeholderIcon,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        petProvider.petDetailList[index].id ==
                                                                petProvider.selectedPetIdForEvent
                                                            ? Positioned(
                                                                left: 55.0,
                                                                top: 0,
                                                                child: InkWell(
                                                                  child: ClipRRect(
                                                                    child: Image.asset(AppImage.greenCheckIcon),
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print("IMAGE PET  ${petList[index].petPhoto}");
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: Text(
                                                        petList[index].petName ?? "",
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                            fontFamily: AppFont.poppinSemibold),
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
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        return Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            for (int i = 0; i < petProvider.masterEventlList.length; i++)
                                              SizedBox(
                                                height: 32,
                                                width: 105,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 5.0, bottom: 5),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4),
                                                        )),
                                                        backgroundColor: MaterialStateProperty.all<Color>(
                                                            petProvider.masterEventlList[i] ==
                                                                    petProvider.seletedMaterEvnt
                                                                ? const Color(0xff2A3C6A)
                                                                : AppColor.textFieldGrey)),
                                                    onPressed: () {
                                                      petProvider
                                                          .updateSelectedEvntCate(petProvider.masterEventlList[i]);

                                                      petProvider.selectedSubEvnt?.name =
                                                          tr(LocaleKeys.additionText_select);

                                                      // print("event cate==> ${petProvider.updateSelectedEvntCate(detail)}");
                                                    },
                                                    child:
                                                        // Text(
                                                        //   petProvider.masterEventlList[i].categoryName ?? "",
                                                        //   style: TextStyle(
                                                        //       color: petProvider.masterEventlList[i] == petProvider.seletedMaterEvnt
                                                        //           ? Colors.white
                                                        //           : Colors.black,
                                                        //       fontFamily: AppFont
                                                        //           .poppinsMedium,
                                                        //       fontSize: 10),
                                                        // ),

                                                        RichText(
                                                      textAlign: TextAlign.center,
                                                      text: TextSpan(children: <TextSpan>[
                                                        TextSpan(
                                                          text: petProvider.masterEventlList[i].categoryName ?? "",
                                                          style: TextStyle(
                                                              color: petProvider.masterEventlList[i] ==
                                                                      petProvider.seletedMaterEvnt
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                              fontSize: 10.0,
                                                              fontWeight: FontWeight.w800),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      }),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        var handle = petProvider.seletedMaterEvnt?.evtCatagoryList ?? [];
                                        return handle.isEmpty
                                            ? const SizedBox()
                                            : Text(
                                                tr(LocaleKeys.additionText_type),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: AppColor.textLightBlueBlack,
                                                    fontFamily: AppFont.poppinsBold),
                                              );
                                      }),

                                      Consumer<PetProvider>(
                                        builder: (context, value, child) {
                                          var handle = petProvider.seletedMaterEvnt?.evtCatagoryList ?? [];
                                          return handle.isEmpty
                                              ? const SizedBox()
                                              : CustomDropDown<EvntCatagoryList>(
                                                  selectText: petProvider.selectedSubEvnt?.name ??
                                                      tr(LocaleKeys.additionText_select),
                                                  itemList: petProvider.seletedMaterEvnt?.evtCatagoryList ?? [],
                                                  isEnable: true,
                                                  onChange: (val) {
                                                    print(
                                                        "petProvider.selectedSubEvnt?.name=>${petProvider.selectedSubEvnt?.name}");
                                                    petProvider.onselectEventType(val);
                                                  },
                                                  title: "",
                                                  value: null,
                                                );
                                        },
                                      ),

                                      const SizedBox(
                                        height: 19,
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        // color: Colors.redAccent,
                                        child: Row(
                                          children: [
                                            Text(
                                              tr(LocaleKeys.newEvent_eventName),
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: AppColor.textLightBlueBlack,
                                                  fontFamily: AppFont.poppinsBold),
                                            ),
                                            Text(tr(LocaleKeys.additionText_required),
                                                style: const TextStyle(
                                                    fontFamily: AppFont.poppinsRegular,
                                                    fontSize: 12,
                                                    color: Color(0xffFF0000)))
                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 7,
                                      ),

                                      CustomTextFeild(
                                        textController: eventNameController,
                                        hintText: tr(LocaleKeys.additionText_ntrEvrName),
                                        textInputType: TextInputType.text,
                                      ),

                                      // Container(
                                      //   height: 56,
                                      //   width: 328,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(28),
                                      //     color: AppColor.textFieldGrey,
                                      //   ),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         left: 16, top: 18, bottom: 17, right: 199),
                                      //     child: Text(
                                      //       "${petProvider.selectedPetGender?.title}",
                                      //       style: TextStyle(
                                      //           fontSize: 15,
                                      //           color: AppColor.textLightBlueBlack,
                                      //           fontFamily: AppFont.poppinsMedium),
                                      //     ),
                                      //   ),
                                      // ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      Container(
                                        // color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                // "Start",
                                                tr(LocaleKeys.additionText_reminderTime),
                                                // "Reminder Time",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: AppColor.textLightBlueBlack,
                                                    fontFamily: AppFont.poppinsBold),
                                              ),
                                            ),
                                            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                              return Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      var v1 = DateTime.now().hour;
                                                      print("===hrs to add===>>${24 - v1}");
                                                      var v3 = 24 - v1 - 1;

                                                      var v2 = DateTime.now().minute;
                                                      print("===mins to add===>>${60 - v2}");
                                                      var v4 = 60 - v2;

                                                      showDatePicker(
                                                        context: context,
                                                        firstDate: DateTime.now(),
                                                        initialDate: DateTime.now(),
                                                        lastDate: DateTime(2050),
                                                      ).then((value) {
                                                        var date = DateTime.parse(value.toString());

                                                        print("value date year====${value?.month}");
                                                        print("value date year====${value?.year}");
                                                        print("value date year====${value?.day}");

                                                        date1 = value?.day;
                                                        date1 = date1 + 1;
                                                        print("date1 val after 1 add=$date1");

                                                        month1 = value?.month;
                                                        year1 = value?.year;

                                                        String newdate = date.toString();
                                                        print("***-----//////${dateConverter(newdate)}");

                                                        timestampGmt = date.millisecondsSinceEpoch.toString();
                                                        print(">>>>><<<<<$timestampGmt");
                                                        // print("=======${dateConverter(timestampGmt)} ");
                                                        print("======*****${timeConverter(int.parse(timestampGmt))} ");
                                                        String str = timeConverter(int.parse(timestampGmt));

                                                        setState(() {
                                                          print("Setting the date in the event date controller");
                                                          petProvider.enableEntButton();
                                                          print(
                                                              "   petProvider.enableEntBut===${petProvider.eventButton}");

                                                          eventDateController.text = "${dateConverter(newdate)} $str";
                                                          print(">>>><<<<${eventDateController.text}");
                                                        });
                                                      });

                                                      // DatePicker
                                                      //         .showDateTimePicker(
                                                      //             context,
                                                      //             minTime: DateTime.now(),
                                                      //                 // .add(Duration(hours: v3,minutes: v4)),
                                                      //             maxTime:
                                                      //                 DateTime(
                                                      //                     2050))
                                                      //     .then((value) {

                                                      //   //  eventDateController.text=value.toString();
                                                      // });
                                                    },
                                                    child: eventDateController.text.isEmpty
                                                        ? Text(
                                                            tr(LocaleKeys.newEvent_selectDate),
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsRegular),
                                                          )
                                                        : Text(
                                                            eventDateController.text,
                                                            maxLines: 2,
                                                            // maxlines:2,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsRegular),
                                                          ),
                                                  )
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      ///**************

                                      Container(
                                        // color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                // "Start",
                                                tr(LocaleKeys.additionText_repeat),
                                                // "Repeat",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: AppColor.textLightBlueBlack,
                                                    fontFamily: AppFont.poppinsBold),
                                              ),
                                            ),
                                            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                              return Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      petProvider.isShowRadioList(1);
                                                    },
                                                    child: eventRepeatController.text.isEmpty
                                                        ? Text(
                                                            // tr(LocaleKeys.newEvent_selectDate),
                                                            petProvider.petRepeatEvent.text,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsRegular),
                                                          )
                                                        : Text(
                                                            eventDateController.text,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsRegular),
                                                          ),
                                                  )
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),

                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        return petProvider.showRadioList == 1
                                            ? Column(
                                                children: [
                                                  RadioContainer(
                                                      context: context,
                                                      Rname: tr(LocaleKeys.additionText_never),
                                                      repeeet: Repeat.never),
                                                  RadioContainer(
                                                      context: context,
                                                      Rname: tr(LocaleKeys.additionText_everyday),
                                                      repeeet: Repeat.everyday),
                                                  RadioContainer(
                                                      context: context,
                                                      Rname: tr(LocaleKeys.additionText_everyweek),
                                                      repeeet: Repeat.everyweek),
                                                  RadioContainer(
                                                      context: context,
                                                      Rname: tr(LocaleKeys.additionText_everymonth),
                                                      repeeet: Repeat.everymonth),
                                                  RadioContainer(
                                                      context: context,
                                                      Rname: tr(LocaleKeys.additionText_everyyear),
                                                      repeeet: Repeat.everyyear),
                                                ],
                                              )
                                            : const SizedBox();
                                      }),

                                      const SizedBox(
                                        height: 15,
                                      ),

                                      petProvider.repeatType != 0
                                          ? Container(
                                              // color: Colors.blue,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: MediaQuery.of(context).size.width * .45,
                                                      // color: Colors.deepOrange,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            // "Start",
                                                            tr(LocaleKeys.additionText_recuringend),
                                                            // "Recurring End",
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsBold),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(context).size.width * .23,
                                                            // color: Colors.deepPurple,
                                                            child: Text(tr(LocaleKeys.additionText_required),
                                                                style: const TextStyle(
                                                                    fontFamily: AppFont.poppinsRegular,
                                                                    fontSize: 12,
                                                                    color: Color(0xffFF0000))),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState) {
                                                    return Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            print("value before select$timestampGmt");
                                                            // EasyLoading.showToast("Please select reminder start time before selecting recurring end time");
                                                            timestampGmt.isEmpty
                                                                ? EasyLoading.showToast(
                                                                    tr(LocaleKeys.additionText_evntDateToast),
                                                                  )
                                                                : showDatePicker(
                                                                    context: context,
                                                                    initialDate: DateTime(year1, month1, date1),
                                                                    firstDate: DateTime(year1, month1, date1),
                                                                    lastDate: DateTime(2050),
                                                                  )
                                                                    // .then((value) => print("value"));

                                                                    // DatePicker.showDatePicker(context,minTime:DateTime.now(),
                                                                    // maxTime: DateTime(2050)
                                                                    // )
                                                                    .then((value) {
                                                                    print("******------$value-----******");
                                                                    var date = DateTime.parse(value.toString());
                                                                    String newdate = date.toString();
                                                                    print("***-----//////${dateConverter(newdate)}");

                                                                    timestampGmt2 =
                                                                        date.millisecondsSinceEpoch.toString();
                                                                    print(">>>>>recurring<<<<<$timestampGmt2");
                                                                    // print("=======${dateConverter(timestampGmt)} ");
                                                                    print(
                                                                        "======*****${timeConverter(int.parse(timestampGmt2))} ");
                                                                    String str =
                                                                        timeConverter(int.parse(timestampGmt2));

                                                                    setState(() {
                                                                      recurringController.text =
                                                                          dateConverter(newdate).toString();
                                                                      print(">>>><<<<${recurringController.text}");
                                                                    });
                                                                    //  eventDateController.text=value.toString();
                                                                  });
                                                          },
                                                          child: recurringController.text.isEmpty
                                                              ? Center(
                                                                  child: Text(
                                                                    // "Select Date ",
                                                                    tr(LocaleKeys.newEvent_selectDate),
                                                                    maxLines: 2,
                                                                    style: const TextStyle(
                                                                        fontSize: 12,
                                                                        color: AppColor.textLightBlueBlack,
                                                                        fontFamily: AppFont.poppinsRegular),
                                                                  ),
                                                                )
                                                              : Text(
                                                                  recurringController.text,
                                                                  maxLines: 2,
                                                                  // maxlines:2,
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      color: AppColor.textLightBlueBlack,
                                                                      fontFamily: AppFont.poppinsRegular),
                                                                ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Container(
                                        // color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  print("repeatType=====>>>${petProvider.repeatType}");
                                                },
                                                child: Text(
                                                  // "Start",
                                                  tr(LocaleKeys.additionText_reminderBefore),
                                                  // "Reminder Before",
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: AppColor.textLightBlueBlack,
                                                      fontFamily: AppFont.poppinsBold),
                                                ),
                                              ),
                                            ),
                                            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                              return Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: eventRepeatController.text.isEmpty
                                                        ? const Text(
                                                            "",
                                                            // tr(LocaleKeys.newEvent_selectDate),
                                                            // petProvider.petRepeatEvent.text,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsRegular),
                                                          )
                                                        : const Text(
                                                            "",
                                                            // eventDateController.text,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor.textLightBlueBlack,
                                                                fontFamily: AppFont.poppinsRegular),
                                                          ),
                                                  )
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),

                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        return
                                            //petProvider.showRadioList==1?
                                            Column(
                                          children: [
                                            RemindTimeCont(
                                                context: context,
                                                Rname: tr(LocaleKeys.additionText_off),
                                                remindTime: RemindTime.never),
                                            RemindTimeCont(
                                                context: context,
                                                Rname: tr(LocaleKeys.additionText_15minutes),
                                                remindTime: RemindTime.Min15),
                                            RemindTimeCont(
                                                context: context,
                                                Rname: tr(LocaleKeys.additionText_30minutes),
                                                remindTime: RemindTime.Min30),
                                            RemindTimeCont(
                                                context: context,
                                                Rname: tr(LocaleKeys.additionText_1hour),
                                                remindTime: RemindTime.Hour1),
                                            RemindTimeCont(
                                                context: context,
                                                Rname: tr(LocaleKeys.additionText_12hour),
                                                remindTime: RemindTime.Hour12),
                                            RemindTimeCont(
                                                context: context,
                                                Rname: tr(LocaleKeys.additionText_24hour),
                                                remindTime: RemindTime.Hour24),
                                          ],
                                        );
                                        //:SizedBox();
                                      }),

                                      ///**************

                                      //
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      //
                                      // Container(
                                      //   // color: Colors.blue,
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      //     children: [
                                      //       Expanded(
                                      //         child: Text(
                                      //           "Ends",
                                      //           maxLines: 2,
                                      //           style: TextStyle(
                                      //               fontSize: 13,
                                      //               color: AppColor.textLightBlueBlack,
                                      //               fontFamily: AppFont.poppinsBold),
                                      //         ),
                                      //       ),
                                      //
                                      //
                                      //       StatefulBuilder(builder:
                                      //           (BuildContext context,
                                      //           StateSetter setState) {
                                      //         return Row(
                                      //           children: [
                                      //             InkWell(
                                      //               onTap: () {
                                      //                 DatePicker.showDateTimePicker(
                                      //                     context,
                                      //                     minTime: DateTime.now(),
                                      //                     maxTime: DateTime(2050))
                                      //                     .then((value) {
                                      //
                                      //                   var date = DateTime.parse(
                                      //                       value.toString());
                                      //                   String newdate = date.toString();
                                      //                   print(
                                      //                       "***-----//////${dateConverter(newdate)}");
                                      //
                                      //                   timestampGmt2 = date
                                      //                       .millisecondsSinceEpoch
                                      //                       .toString();
                                      //                   print(
                                      //                       ">>>>><<<<<${timestampGmt2}");
                                      //                   // print("=======${dateConverter(timestampGmt)} ");
                                      //                   print(
                                      //                       "======*****${timeConverter(int.parse(timestampGmt2))} ");
                                      //                   String str = timeConverter(
                                      //                       int.parse(timestampGmt2));
                                      //
                                      //                   setState(() {
                                      //                     eventEndDateController.text =
                                      //                         dateConverter(newdate)
                                      //                             .toString() +
                                      //                             " " +
                                      //                             str;
                                      //                     print(
                                      //                         ">>>><<<<${eventEndDateController.text}");
                                      //                   });
                                      //                   //  eventDateController.text=value.toString();
                                      //                 });
                                      //               },
                                      //               child:
                                      //               eventEndDateController.text.isEmpty
                                      //                   ? Text(
                                      //
                                      //                 tr(LocaleKeys.newEvent_selectDate),
                                      //                 maxLines: 2,
                                      //                 style: TextStyle(
                                      //
                                      //                     fontSize: 12,
                                      //                     color: AppColor
                                      //                         .textLightBlueBlack,
                                      //                     fontFamily: AppFont
                                      //                         .poppinsRegular),
                                      //               )
                                      //                   : Text(
                                      //                 eventEndDateController.text,
                                      //                 maxLines: 2,
                                      //                 // maxlines:2,
                                      //                 style: TextStyle(
                                      //                     fontSize: 12,
                                      //                     color: AppColor
                                      //                         .textLightBlueBlack,
                                      //                     fontFamily: AppFont
                                      //                         .poppinsRegular),
                                      //               ),
                                      //             )
                                      //           ],
                                      //         );
                                      //       }),
                                      //     ],
                                      //   ),
                                      // ),
                                      //

                                      ///**************

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      //
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Repeat Reminder",
                                      //       textAlign: TextAlign.left,
                                      //       style: TextStyle(
                                      //           fontFamily: AppFont.poppinsBold,
                                      //           fontSize: 14,
                                      //           color: AppColor.textLightBlueBlack),
                                      //     ),
                                      //     Container(
                                      //       decoration: BoxDecoration(),
                                      //     ),
                                      //     new Spacer(),
                                      //
                                      //     AdvancedSwitch(
                                      //       controller: Switchcontroller,
                                      //       activeColor: AppColor.textRed,
                                      //       inactiveColor: Colors.black12,
                                      //       borderRadius: BorderRadius.all(const Radius.circular(4)),
                                      //       width: 38.0,
                                      //       height: 16.0,
                                      //       enabled: true,
                                      //       disabledOpacity: 0.5,
                                      //
                                      //     ),
                                      //   ],
                                      // ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      // customBlueButton(
                                      //   text1: tr(LocaleKeys.addPet_save),
                                      //   onTap1: () {
                                      //     if (eventNameController.text.trim().isNotEmpty && eventDateController.text.isNotEmpty)
                                      //     {
                                      //       // provider.callAddEvent(
                                      //       //     context: context,
                                      //       //     time: timestampGmt,
                                      //       //     name: eventNameController.text
                                      //       //         .trim(),
                                      //       //     pettidd: petProvider
                                      //       //             .selectedPetIdForEvent ??
                                      //       //         0);
                                      //
                                      //       provider.addEventP2ApiCall(
                                      //         context: context,
                                      //         pettidd: petProvider.selectedPetIdForEvent ?? 0,
                                      //         name: eventNameController.text.trim(),
                                      //         start: timestampGmt,
                                      //         end: timestampGmt2,
                                      //         evntCateid:petProvider.selectedSubEvnt?.EventCatgoriesId??18,
                                      //         evntCateType: petProvider.selectedSubEvnt?.id??1,
                                      //         fromPet: widget.frmPet
                                      //
                                      //       );
                                      //
                                      //     } else {
                                      //       if (eventNameController.text
                                      //           .trim()
                                      //           .isEmpty) {
                                      //         CoolAlert.show(
                                      //             context: context,
                                      //             type: CoolAlertType.warning,
                                      //             text: "Please enter name of event");
                                      //       } else if (eventDateController
                                      //           .text.isEmpty) {
                                      //         CoolAlert.show(
                                      //             context: context,
                                      //             type: CoolAlertType.warning,
                                      //             text: "Please select event date");
                                      //       }
                                      //     }
                                      //   },
                                      //   colour: AppColor.textLightBlueBlack,
                                      //   context: context,
                                      // ),
                                      //
                                    ],
                                  ),
                                ),
                              ])));
                }),
              ),
            );
          }),
      bottomNavigationBar: BotttomBorder(context),
    );
  }
}

// String dateConverter(int date) {
//
//   var d = DateTime.fromMillisecondsSinceEpoch(date);
//   return "${Jiffy(d).format("d MMM,yyyy HH:MM  a")}".toUpperCase();
//
// }

String dateConverter(String date) {
  String value = "";
  print("dateeee select >>>  $date");

  DateTime now = DateTime.now();
  try {
    var mod = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    value = Jiffy(mod).format("EEE, dd-MMM-yyyy");
  } catch (e) {
    value = Jiffy(date).format("EEE, dd-MMM-yyyy");
  }

  return value;
}

String timeConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return Jiffy(d).format("HH:mm a").toUpperCase();
}
