import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/models/eventDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';


import '../components/bottomBorderComp.dart';
import '../components/customSmallBlueButton.dart';
import '../generated/locale_keys.g.dart';
import '../models/newEventDetails.dart';
import '../provider/petprovider.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'editEvent.dart';

class DeleteEvent extends StatefulWidget {
  int? petIdEvent;
  int? idEvent;
  bool frmpet;

  DeleteEvent({Key? key, required this.petIdEvent, required this.idEvent, required this.frmpet}) : super(key: key);

  @override
  State<DeleteEvent> createState() => _DeleteEventState();
}

class _DeleteEventState extends State<DeleteEvent> {
  EventDetails? selectedEvent;

  var v1;
  var v2;

  int showRecTime = 0;

  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);

    v1 = petProvider.seleectedEvnt?.petName;
    v2 = petProvider.seleectedEvnt?.eventName;

    EventModel? editEventData = petProvider.seleectedEvnt;

    //  print("event end dat=======>....${editEventData?.eventEndDate}");
    if (editEventData?.eventEndDate == null) {
      editEventData?.eventEndDate = "";
    }
    eventCateTypeController.text = editEventData?.name ?? "";
    var remndrNum = editEventData?.EventRemendirBefore;
    var setReTime = editEventData?.isRepeat;

    print("remndrNum=====>${remndrNum}");
    print("setReTime=====>${setReTime}");
    if (editEventData?.EventRemendirBefore == null) {
      editEventData?.EventRemendirBefore = 0;
      remndrNum = 0;
    }
    if (setReTime == null) {
      setReTime = 0;
    }
    petProvider.getSetRemName(remndrNum!);
    petProvider.getSetRepetNme(setReTime);

    var w1 = editEventData?.startDate?.millisecondsSinceEpoch;

    print("p1 start date==>>${w1}");

    mn1 = getMonth(w1.toString());
    yr1 = getYear(w1.toString());

    print("start month ==>${mn1}");
    print("start year ==>${yr1}");
    print("editEventData?.eventEndDate ====${editEventData?.eventEndDate}");

    if (editEventData!.eventEndDate!.isNotEmpty) {
      evntrecurringController.text = formatDateTym2(editEventData.eventEndDate ?? "");
    }

    // if(editEventData?.eventEndDate == editEventData?.eventDate){
    //   showRecTime=1;
    // }
    if (editEventData.eventEndDate == "") {
      showRecTime = 1;
    }

    eventCategoryController.text = editEventData.categoryName ?? "";
    // evtRepeatController.text=

    // v1=petProvider.selectedEvent?.petName??"";
    // v2=petProvider.selectedEvent?.eventName??"";
    var v3 = petProvider.selectedEvent?.petName;
  }

  int yr1 = 0;
  int mn1 = 0;

  TextEditingController eventCategoryController = TextEditingController();
  TextEditingController eventCateTypeController = TextEditingController();
  TextEditingController eventRemindTimeController = TextEditingController();
  TextEditingController evtRepeatController = TextEditingController();
  TextEditingController evntrecurringController = TextEditingController();
  TextEditingController eventRemindController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PetProvider provider = Provider.of(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(isbackbutton: true),
      bottomNavigationBar: BotttomBorder(context),
      body: Consumer<PetProvider>(builder: (context, petProvider, child) {
        var eventnameDis = petProvider.selectedEvent?.eventName ?? "";

        // var enventDateee=petProvider.selectedEvent?.eventDate??"";
        var enventDateee = petProvider.seleectedEvnt?.eventDate ?? "";

        var it = provider.selectedEvent?.id ?? "";

        print("pet event pet enventDateee${enventDateee}");

        var p1 = timeConverter(int.parse(enventDateee.isNotEmpty ? enventDateee : "0"));
        var p2 = dateConverter(int.parse(enventDateee.isNotEmpty ? enventDateee : "0"));

        // print("p1 start date==>>${enventDateee}");

        var v3 = p2 + " " + p1;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColor.textFieldGrey),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        // radius: 50,
                        child: CachedNetworkImage(
                          imageUrl: petProvider.seleectedEvnt?.petPhoto ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset(
                              AppImage.placeholderIcon,
                              fit: BoxFit.fill,
                            ),
                          ),
                          errorWidget: (context, url, error) => Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset(
                              AppImage.placeholderIcon,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 65.0,
                      top: 0,
                      child: InkWell(
                        child: ClipRRect(
                          child: Image.asset(AppImage.greenCheckIcon),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  v1,
                  //  petProvider.selectedEvent?.petName ?? "",
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 15.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.textLightBlueBlack,
                        radius: 6.26,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Text(
                          "${tr(LocaleKeys.additionText_eventName)}" + " : " + " ${v2}",
                          // petProvider.selectedEvent?.eventName ?? "",
                          maxLines: 5,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.textLightBlueBlack,
                        radius: 6.26,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Text(
                          "${tr(LocaleKeys.additionText_eventCategory)}" + " : " + "${eventCategoryController.text}",
                          // petProvider.selectedEvent?.eventName ?? "",
                          maxLines: 5,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  eventCateTypeController.text.isEmpty
                      ? SizedBox()
                      : Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.textLightBlueBlack,
                              radius: 6.26,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .85,
                              child: Text(
                                "${tr(LocaleKeys.additionText_eventCategoryName)}" +
                                    " : " +
                                    "${eventCateTypeController.text}",
                                // petProvider.selectedEvent?.eventName ?? "",
                                maxLines: 5,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                            ),
                          ],
                        ),
                  eventCateTypeController.text.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          height: 20.0,
                        ),
                  Row(
                    children: [
                      // Image.asset(AppImage.petcareIcon),

                      CircleAvatar(
                        backgroundColor: AppColor.textLightBlueBlack,
                        radius: 6.26,
                      ),

                      SizedBox(
                        width: 15.0,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * .82,
                        child: Row(
                          children: [
                            Text(
                              "${tr(LocaleKeys.additionText_reminderTime)}" + " : ",
                              // "${dateConverter2(DateTime.fromMillisecondsSinceEpoch(int.parse(enventDateee,),isUtc: true))}",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinSemibold),
                            ),
                            Text(
                              "${v3}",
                              // "${dateConverter2(DateTime.fromMillisecondsSinceEpoch(int.parse(enventDateee,),isUtc: true))}",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinSemibold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  petProvider.editpetRepeatEvent.text == "Never"
                      ? SizedBox()
                      : Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.textLightBlueBlack,
                              radius: 6.26,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "${tr(LocaleKeys.additionText_repeat)}" +
                                  " : " +
                                  "${petProvider.editpetRepeatEvent.text}",
                              // "${dateConverter2(DateTime.fromMillisecondsSinceEpoch(int.parse(enventDateee,),isUtc: true))}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinSemibold),
                            ),
                          ],
                        ),
                  petProvider.editpetRepeatEvent.text == "Never"
                      ? SizedBox()
                      : SizedBox(
                          height: 20.0,
                        ),
                  showRecTime == 1
                      ? SizedBox()
                      : Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.textLightBlueBlack,
                              radius: 6.26,
                            ),

                            SizedBox(
                              width: 10.0,
                            ),

                            // showRecTime==1?SizedBox():

                            Container(
                              width: MediaQuery.of(context).size.width * .85,
                              child: Text(
                                "${tr(LocaleKeys.additionText_recuringend)}" + " : " "${evntrecurringController.text}",
                                // petProvider.selectedEvent?.eventName ?? "",
                                maxLines: 5,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                            ),
                          ],
                        ),
                  showRecTime == 1
                      ? SizedBox()
                      : SizedBox(
                          height: 20,
                        ),
                  petProvider.editRemindBefor.text == "Off"
                      ? SizedBox()
                      : Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.textLightBlueBlack,
                              radius: 6.26,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .85,
                              child: Text(
                                "${tr(LocaleKeys.additionText_reminderBefore)} " +
                                    " : " +
                                    "${petProvider.editRemindBefor.text}",
                                // petProvider.selectedEvent?.eventName ?? "",
                                maxLines: 5,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 8.0, bottom: 40.0),
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
                              title: Text(tr(LocaleKeys.additionText_deleteEvent)),
                              actions: <Widget>[
                                InkWell(
                                  child: Text(
                                    tr(LocaleKeys.additionText_cancel),
                                    style: TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                  ),
                                  onTap: () {
                                    print("month==>${mn1}");
                                    print("year==>${yr1}");
                                    Navigator.pop(context1);
                                  },
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                InkWell(
                                  child: Text(
                                    tr(LocaleKeys.additionText_yes),
                                    style: TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                  ),
                                  onTap: () async {
                                    Navigator.pop(context1);
                                    PetProvider petProvider = Provider.of(context, listen: false);
                                    petProvider.deleteEventApiCall(
                                        context: context,
                                        month: mn1,
                                        year: yr1,
                                        idddd: widget.idEvent ?? 0,
                                        petiddd: widget.petIdEvent ?? 0,
                                        frmpet: widget.frmpet);
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
                    colour: AppColor.newBlueGrey,
                    context: context,
                    onTap1: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditEvent(
                                    idEvent: widget.idEvent ?? 0,
                                    petIdEvent: widget.petIdEvent ?? 0,
                                    isfrompet: widget.frmpet,
                                  )));
                    },
                    text1: tr(LocaleKeys.additionText_edit)))
          ],
        ),
      ),
    );
  }
}

String dateConverter(
  int date,
) {
  print("date covrter date=====${date}");
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return "${Jiffy(d).format("d-MMM-yyyy ")}".toUpperCase();
}

String dateConverter2(
  DateTime date,
) {
  return "${Jiffy(date).format("d-MMM-yyyy ")}".toUpperCase();
}

String formatDateTym2(String str) {
  print("formatDateTym2===${str}");
  var v1 = int.parse(str);
  print("int parse str===${v1}");
  var d = DateTime.fromMillisecondsSinceEpoch(v1);
  print("dte time convert====${Jiffy(d).format("d-MMM-yyyy ")}");
  // return "${Jiffy(d).format("d-MMM-yyyy ")}".toUpperCase();
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

  return "${Jiffy(d).format("HH:mm a")}".toUpperCase();
}

int getMonth(String start) {
  var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
  int convertedDateTime = now.month;
  return convertedDateTime;
}

int getYear(String start) {
  var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
  int convertedDateTime = now.year;
  return convertedDateTime;
}
