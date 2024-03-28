import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/customBlueButton.dart';
import '../../components/customTextFeild.dart';
import '../../components/customdropdown.dart';
import '../../components/docCategoryContainer.dart';
import '../../models/petdetailsmodel.dart';
import '../../provider/petprovider.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/appstrings.dart';
import '../../util/color.dart';
import '../api/staus_enum.dart';
import '../components/radioButtonComp.dart';
import '../components/reminderRadio.dart';
import '../generated/locale_keys.g.dart';
import '../models/masterEvent.dart';
import '../models/newEventDetails.dart';
import '../monish/provider/myProvider.dart';
import '../monish/reUseClass/myappbar.dart';
// import '../provider/myProvider.dart';
// import '../reUseClass/dropdown.dart';
// import '../reUseClass/myappbar.dart';

class EditEvent extends StatefulWidget {
  int? petIdEvent;
  int? idEvent;
  bool isfrompet;

  EditEvent({Key? key, required this.petIdEvent, required this.idEvent, required this.isfrompet}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late Myprovider my;
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController editevtRepeatController = TextEditingController();
  TextEditingController editrecurringController = TextEditingController();
  TextEditingController eventRepeatController = TextEditingController();

  var date2;
  var month2;
  var year2;

  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    // EventDetails? editEventData = petProvider.selectedEvent;

    petProvider.EvntcateApiCall(context, isfromedit: true);
    EventModel? editEventData = petProvider.seleectedEvnt;

    print("startDate init inside func===${editEventData?.startDate?.millisecondsSinceEpoch}");

    timestampGmt = editEventData?.eventDate ?? "";
    timestampGmt2 = editEventData?.recring ?? "";

    print("timestamp==>>$timestampGmt");

    int mn1 = getMonth(timestampGmt);
    int yr1 = getYear(timestampGmt);
    int dt1 = getDatee(timestampGmt);

    date2 = dt1 + 1;
    month2 = mn1;
    year2 = yr1;

    print("date2=====$date2");
    print("month2=====$month2");
    print("year2=====$year2");

    petProvider.callgetPetEventP2(mn1, yr1, widget.isfrompet);

    petProvider.repeatType = editEventData?.isRepeat;
    petProvider.remindType = editEventData?.EventRemendirBefore;

    print("remind before ====>>${editEventData?.EventRemendirBefore}");
    print("repeat before ====>>${editEventData?.isRepeat}");

    var v1 = dateConverter(int.parse(editEventData?.eventDate ?? ""));
    var v2 = timeConverter(int.parse(editEventData?.eventDate ?? ""));

    if (editEventData?.recring == editEventData?.eventDate) {
      editrecurringController.text = "";
    } else {
      print("editEventData?.eventEndDate========${editEventData?.eventEndDate}");
      if (editEventData!.eventEndDate!.isNotEmpty) {
        editrecurringController.text = formatDateTym2(editEventData.eventEndDate ?? "");
      }
    }
    // var v5=editEventData?.eventEndDate?.millisecondsSinceEpoch;

    // editrecurringController.text=dateConverter(v5!);

    // var v3=dateConverter(int.parse(editEventData?.eventEndDate));

    var v3 = editEventData?.eventEndDate.toString();
    var v4 = editEventData?.eventDate;

    idd = editEventData?.id ?? 0;

// var v4=dateConverter(int.parse(v3!));

    print("v4=======>$v3");
    print("v4=======>$v4");
    eventNameController.text = editEventData?.eventName ?? "";
    eventDateController.text = "$v1 $v2";

    petProvider.selectedPetIdForEvent = petProvider.seleectedEvnt?.petId ?? 0;

    var remndrNum = petProvider.seleectedEvnt?.EventRemendirBefore;
    var setReTime = petProvider.seleectedEvnt?.isRepeat;

    print("petProvider.seleectedEvnt?.EventRemendirBefore===${petProvider.seleectedEvnt?.EventRemendirBefore}");
    print("petProvider.isRepeat?.isRepeat===${petProvider.seleectedEvnt?.isRepeat}");

    petProvider.getSetRemName(remndrNum!);
    petProvider.getSetRepetNme(setReTime!);

    var stPetId = petProvider.selectedPetIdForEvent;
    petProvider.setPetIdFroEditEvent(stPetId!);

    super.initState();
  }

  var idd;
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
      appBar: CustomCurvedAppbar(
        // tap2: () {},
        title: tr(LocaleKeys.additionText_editEvent),
        isTitleCenter: true,
        // isbackbutton: true,
        // icon: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 30),
        child: CustomButton(
          // context: context,
          text: tr(LocaleKeys.ownerProfile_update),
          onPressed: () {
            // provider.callEditEvent(
            //   context: context,
            //   time: timestampGmt,
            //   name: eventNameController.text.trim(),
            //   petId: provider.petIdForEdit,
            //   idddd: widget.idEvent ?? 0,
            //
            // );

            print("event date api==>>$timestampGmt");
            print("event date end api==>>$timestampGmt2");
            PetProvider petProvider = Provider.of(context, listen: false);

            provider.editEventP2ApiCall(
                context: context,
                idd: petProvider.seleectedEvnt?.id ?? 0,
                name: eventNameController.text.trim(),
                pettidd: provider.petIdForEdit,
                evntCateType: petProvider.selectedSubEvnt?.id ?? 0,
                end: timestampGmt2,
                start: timestampGmt,
                evntCateid: petProvider.selectedSubEvnt?.EventCatgoriesId ?? 0,
                frompet: widget.isfrompet);
          },
          // colour: AppColor.newBlueGrey
        ),
      ),
      body: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.88,
          minChildSize: 0.86,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Consumer2<PetProvider, Myprovider>(builder: (context, petProvider, myprovider, child) {
                // String petGenderbool = petProvider.selectedPetGender?.title ?? "";
                return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                              print(
                                                  "finally selected pet id::::::::::${petProvider.petDetailList[index].id}");
                                              print("comming pet  selected pet id::::::::::${widget.petIdEvent}");
                                              var cngPetId = petProvider.petDetailList[index].id;
                                              provider.setPetIdFroEditEvent(cngPetId!);
                                              print("pet id from provider${provider.petIdForEdit}");
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
                                                  child: Text(
                                                    petList[index].petName ?? "",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                        fontFamily: AppFont.poppinSemibold),
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
                                                              ? AppColor.buttonPink
                                                              : AppColor.textFieldGrey)),
                                                  onPressed: () {
                                                    petProvider.updateSelectedEvntCate(petProvider.masterEventlList[i]);

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
                                      height: 20,
                                    ),
                                    Consumer<PetProvider>(builder: (context, petProvider, child) {
                                      // return
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

                                    // SizedBox(
                                    //   height: 19,
                                    // ),

                                    Consumer<PetProvider>(
                                      builder: (context, value, child) {
                                        var handle = petProvider.seletedMaterEvnt?.evtCatagoryList ?? [];
                                        return handle.isEmpty
                                            ? const SizedBox()
                                            : CustomDropDown<EvntCatagoryList>(
                                                // isGrey: pettypebool.isEmpty,
                                                selectText: petProvider.selectedSubEvnt?.name ??
                                                    tr(LocaleKeys.additionText_select),
                                                itemList: petProvider.seletedMaterEvnt?.evtCatagoryList ?? [],
                                                isEnable: true,
                                                onChange: (val) {
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
                                    Row(
                                      children: [
                                        Text(
                                          tr(LocaleKeys.newEvent_eventName),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColor.textLightBlueBlack,
                                              fontFamily: AppFont.poppinsBold),
                                        ),
                                        Text("(${tr(LocaleKeys.newEvent_required)}+)",
                                            style: const TextStyle(
                                                fontFamily: AppFont.poppinsRegular,
                                                fontSize: 12,
                                                color: Color(0xffFF0000)))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    CustomTextFeild(
                                      textController: eventNameController,
                                      textInputType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       tr(LocaleKeys.newEvent_date),
                                    //       style: TextStyle(
                                    //           fontSize: 14,
                                    //           color: AppColor.textLightBlueBlack,
                                    //           fontFamily: AppFont.poppinsBold),
                                    //     ),
                                    //     StatefulBuilder(builder:
                                    //         (BuildContext context,
                                    //             StateSetter setState) {
                                    //       return Row(
                                    //         children: [
                                    //           InkWell(
                                    //             onTap: () {
                                    //               DatePicker.showDateTimePicker(
                                    //                       context,
                                    //                       minTime: DateTime.now(),
                                    //                       maxTime: DateTime(2050))
                                    //                   .then((value) {
                                    //                 print(
                                    //                     ">>>>><<<<<${value?.minute}");
                                    //                 var date = DateTime.parse(
                                    //                     value.toString());
                                    //                 timestampGmt = date
                                    //                     .millisecondsSinceEpoch
                                    //                     .toString();
                                    //
                                    //                 // print("=======${dateConverter(int.parse(timestampGmt))} ");
                                    //                 // print("====**********===${timeConverter(int.parse(timestampGmt))} ");
                                    //
                                    //                 String str2 = timeConverter(
                                    //                     int.parse(timestampGmt));
                                    //                 print(
                                    //                     "/*/*/*/*/>>>>>>${dateConverter(int.parse(timestampGmt)) + " " + str2}");
                                    //
                                    //                 setState(() {
                                    //                   eventDateController.text =
                                    //                       dateConverter(int.parse(
                                    //                               timestampGmt)) +
                                    //                           " " +
                                    //                           str2;
                                    //                   print(
                                    //                       "/*/*/*/*/${eventDateController.text}");
                                    //                 });
                                    //                 //  eventDateController.text=value.toString();
                                    //               });
                                    //             },
                                    //             child: Text(
                                    //               eventDateController.text,
                                    //               style: TextStyle(
                                    //                   fontSize: 12,
                                    //                   color:
                                    //                       AppColor.textLightBlueBlack,
                                    //                   fontFamily:
                                    //                       AppFont.poppinsRegular),
                                    //             ),
                                    //           )
                                    //         ],
                                    //       );
                                    //     }),
                                    //   ],
                                    // ),

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
                                              // tr(LocaleKeys.newEvent_selectDate),
                                              tr(LocaleKeys.additionText_reminderTime),
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
                                                    showDatePicker(
                                                            context: context,
                                                            firstDate: DateTime.now(),
                                                            initialDate: DateTime.now(),
                                                            lastDate: DateTime(2050))
                                                        .then((value) {
                                                      var date = DateTime.parse(value.toString());

                                                      month2 = value?.month;
                                                      year2 = value?.year;

                                                      date2 = value?.day;
                                                      date2 = date2 + 1;

                                                      String newdate = date.toString();
                                                      print("***-----//////${dateeConverter(newdate)}");

                                                      timestampGmt = date.millisecondsSinceEpoch.toString();
                                                      print(">>>>><<<<<$timestampGmt");
                                                      // print("=======${dateConverter(timestampGmt)} ");
                                                      print("======*****${timeConverter(int.parse(timestampGmt))} ");
                                                      String str = timeConverter(int.parse(timestampGmt));

                                                      setState(() {
                                                        eventDateController.text = "${dateeConverter(newdate)} $str";
                                                        print(">>>><<<<${eventDateController.text}");
                                                      });
                                                    });

                                                    // DatePicker
                                                    //         .showDateTimePicker(
                                                    //             context,
                                                    //             minTime:
                                                    //                 DateTime
                                                    //                     .now(),
                                                    //             maxTime:
                                                    //                 DateTime(  2050)
                                                    //                 )
                                                    //     .then((value) {
                                                    //   var date = DateTime.parse(
                                                    //       value.toString());

                                                    //   month2=value?.month;
                                                    //   year2=value?.year;

                                                    //   date2=value?.day;
                                                    //   date2=date2+1;

                                                    //   String newdate =
                                                    //       date.toString();
                                                    //   print(
                                                    //       "***-----//////${dateeConverter(newdate)}");

                                                    //   timestampGmt = date
                                                    //       .millisecondsSinceEpoch
                                                    //       .toString();
                                                    //   print(
                                                    //       ">>>>><<<<<${timestampGmt}");
                                                    //   // print("=======${dateConverter(timestampGmt)} ");
                                                    //   print(
                                                    //       "======*****${timeConverter(int.parse(timestampGmt))} ");
                                                    //   String str = timeConverter(
                                                    //       int.parse(
                                                    //           timestampGmt));

                                                    //   setState(() {
                                                    //     eventDateController
                                                    //             .text =
                                                    //         dateeConverter(
                                                    //                     newdate)
                                                    //                 .toString() +
                                                    //             " " +
                                                    //             str;
                                                    //     print(
                                                    //         ">>>><<<<${eventDateController.text}");
                                                    //   });
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

                                    Container(
                                      // color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              // "Start",
                                              // tr(LocaleKeys.newEvent_selectDate),
                                              tr(LocaleKeys.additionText_repeat),
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
                                                  child: petProvider.editpetRepeatEvent.text.isEmpty
                                                      // editevtRepeatController.text.isEmpty
                                                      ? Text(
                                                          // tr(LocaleKeys.newEvent_selectDate),
                                                          // petProvider.petRepeatEvent.text,
                                                          petProvider.editpetRepeatEvent.text,
                                                          maxLines: 2,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: AppColor.textLightBlueBlack,
                                                              fontFamily: AppFont.poppinsRegular),
                                                        )
                                                      : Text(
                                                          petProvider.editpetRepeatEvent.text,
                                                          // eventDateController.text,
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

                                    Consumer<PetProvider>(builder: (context, petProvider, child) {
                                      return
                                          // petProvider.showRadioList==1?
                                          Column(
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
                                      );
                                      // :SizedBox();
                                    }),

                                    petProvider.repeatType != 0
                                        ? Container(
                                            // color: Colors.blue,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        // "Start",
                                                        // tr(LocaleKeys.newEvent_selectDate),
                                                        tr(LocaleKeys.additionText_recuringend),
                                                        maxLines: 2,
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
                                                StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                  return Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showDatePicker(
                                                                  context: context,
                                                                  firstDate: DateTime(year2, month2, date2),
                                                                  initialDate: DateTime(year2, month2, date2),
                                                                  lastDate: DateTime(2050))
                                                              .then((value) {
                                                            var date = DateTime.parse(value.toString());
                                                            String newdate = date.toString();
                                                            print("***-----//////${dateeConverter(newdate)}");

                                                            timestampGmt2 = date.millisecondsSinceEpoch.toString();
                                                            print(">>>>>recurring<<<<<$timestampGmt2");
                                                            // print("=======${dateConverter(timestampGmt)} ");
                                                            print(
                                                                "======*****${timeConverter(int.parse(timestampGmt2))} ");
                                                            String str = timeConverter(int.parse(timestampGmt2));

                                                            setState(() {
                                                              editrecurringController.text =
                                                                  dateeConverter(newdate).toString();
                                                              print(">>>><<<<${editrecurringController.text}");
                                                            });
                                                          });

                                                          // DatePicker.showDatePicker(
                                                          //         context,
                                                          //         minTime: DateTime(year2,month2,date2),
                                                          //         maxTime: DateTime(2050))
                                                          //     // .showDateTimePicker(context, minTime: DateTime.now(),
                                                          //     // maxTime: DateTime(2050)
                                                          //     // )
                                                          //     .then((value) {
                                                          //   var date = DateTime
                                                          //       .parse(value
                                                          //           .toString());
                                                          //   String newdate =
                                                          //       date.toString();
                                                          //   print(
                                                          //       "***-----//////${dateeConverter(newdate)}");

                                                          //   timestampGmt2 = date
                                                          //       .millisecondsSinceEpoch
                                                          //       .toString();
                                                          //   print(
                                                          //       ">>>>>recurring<<<<<${timestampGmt2}");
                                                          //   // print("=======${dateConverter(timestampGmt)} ");
                                                          //   print(
                                                          //       "======*****${timeConverter(int.parse(timestampGmt2))} ");
                                                          //   String str =
                                                          //       timeConverter(
                                                          //           int.parse(
                                                          //               timestampGmt2));

                                                          //   setState(() {
                                                          //     editrecurringController
                                                          //             .text =
                                                          //         dateeConverter(
                                                          //                 newdate)
                                                          //             .toString();
                                                          //     print(
                                                          //         ">>>><<<<${editrecurringController.text}");
                                                          //   });
                                                          //   //  eventDateController.text=value.toString();
                                                          // });
                                                        },
                                                        child: editrecurringController.text.isEmpty
                                                            ? Text(
                                                                // "Select Date ",
                                                                tr(LocaleKeys.newEvent_selectDate),
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize: 12,
                                                                    color: AppColor.textLightBlueBlack,
                                                                    fontFamily: AppFont.poppinsRegular),
                                                              )
                                                            : Text(
                                                                editrecurringController.text,
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
                                              // tr(LocaleKeys.newEvent_selectDate),
                                              tr(LocaleKeys.additionText_reminderBefore),
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
                                                  onTap: () {},
                                                  child: eventRepeatController.text.isEmpty
                                                      ? Text(
                                                          petProvider.editRemindBefor.text,
                                                          // tr(LocaleKeys.newEvent_selectDate),
                                                          // petProvider.petRepeatEvent.text,
                                                          maxLines: 2,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: AppColor.textLightBlueBlack,
                                                              fontFamily: AppFont.poppinsRegular),
                                                        )
                                                      : Text(
                                                          petProvider.editRemindBefor.text,
                                                          // eventDateController.text,
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
                                      height: 20,
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

                                    const SizedBox(
                                      height: 30,
                                    ),

                                    // customBlueButton(
                                    //   text1: tr(LocaleKeys.additionText_save),
                                    //   onTap1: () {
                                    //     // provider.callEditEvent(
                                    //     //   context: context,
                                    //     //   time: timestampGmt,
                                    //     //   name: eventNameController.text.trim(),
                                    //     //   petId: provider.petIdForEdit,
                                    //     //   idddd: widget.idEvent ?? 0,
                                    //     //
                                    //     // );
                                    //
                                    //
                                    //     print("event date api==>>${timestampGmt}");
                                    //     print("event date end api==>>${timestampGmt2}");
                                    //
                                    //
                                    //     provider.editEventP2ApiCall(
                                    //       context: context,
                                    //       idd:  petProvider.seleectedEvnt?.id??0,
                                    //
                                    //       name: eventNameController.text.trim(),
                                    //       pettidd: provider.petIdForEdit ,
                                    //       evntCateType: petProvider.selectedSubEvnt?.id??0,
                                    //       end: timestampGmt2,
                                    //       start: timestampGmt,
                                    //       evntCateid: petProvider.selectedSubEvnt?.EventCatgoriesId??0,
                                    //       frompet: widget.isfrompet
                                    //
                                    //     );
                                    //
                                    //
                                    //   },
                                    //   colour: AppColor.textLightBlueBlack,
                                    //   context: context,
                                    // ),
                                  ],
                                ),
                              ),
                            ])));
              }),
            );
          }),
      // bottomNavigationBar: BotttomBorder(context),
    );
  }

  int getMonth(String start) {
    var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
    int convertedDateTime = now.month;
    return convertedDateTime;
  }

  int getDatee(String start) {
    var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
    int convertedDateTime = now.day;
    return convertedDateTime;
  }

  int getYear(String start) {
    var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
    int convertedDateTime = now.year;
    return convertedDateTime;
  }
}

String dateeConverter(String date) {
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

String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return Jiffy(d).format("d-MMM-yyyy ").toUpperCase();
}

String formatDateTym2(String str) {
  print("formatDateTym2===$str");
  var v1 = int.parse(str);
  print("int parse str===$v1");
  var d = DateTime.fromMillisecondsSinceEpoch(v1);
  print("dte time convert====${Jiffy(d).format("d-MMM-yyyy ")}");

  if (str.isNotEmpty) {
    var now = DateTime.fromMillisecondsSinceEpoch(int.parse(str));
    String convertedDateTime =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year.toString()} ";
    // return convertedDateTime;
    return Jiffy(d).format("d-MMM-yyyy ");
  } else {
    return "";
  }

  // return convertedDateTime;
}

String timeConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return Jiffy(d).format("HH:mm a").toUpperCase();
}

String monthConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return Jiffy(d).format("MM").toUpperCase();
}
