import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/upcommingEventCont.dart';
import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/newEventDetails.dart';
import '../../provider/petprovider.dart';
import '../../screen/deleteEventScreen.dart';
import '../../util/app_font.dart';
import '../../util/color.dart';
import 'newEvent.dart';

class Calender extends StatefulWidget {
  bool frmpet;
  Calender({Key? key, required int val, required this.frmpet}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  // List<dynamic> SelectedEvents=[];
  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDayy = DateTime.now();

  // DateTime focusedDayy = DateTime.now();

  TextEditingController eventController = TextEditingController();

  late PetProvider petProvider1;

  List<EventModel> noNewEvntList = [];
  DateTime? selectedDateForFiler;
  List<EventModel> eventList = [];
  @override
  void initState() {
    print(ConnectivityResult == ConnectivityResult.none ? "no net" : "yes net");
    print("is from pet====>>${widget.frmpet}");

    petProvider1 = Provider.of(context, listen: false);
    // petProvider1.SelEvents = {selectedDayy,petProvider1.eve};
    // var item=petProvider1?.petDetailList[0].id??0;
    petProvider1.callgetPetEventP2(DateTime.now().month, DateTime.now().year, widget.frmpet);

    // petProvider1.callGetEvents();
    print("api call");

    petProvider1.focusedDayyPP = DateTime.now();

    //petProvider1.selectedPetDetail?.id ?? 0);
    super.initState();
  }

  // List<EventDetails> getEventsfromDay(DateTime date) {
  //
  //
  //   PetProvider petProvider=Provider.of(context,listen: false);
  //   for(var item in petProvider.eventMainList){
  //
  //   }
  //     return petProvider.eventMainList;
  //
  //       //petProvider.eventList;
  // }

  @override
  void dispose() {
    eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,

      //appBar: customAppbar(titlename: "Care Diary"),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 1.0, left: 3),
              child: Center(
                child: Container(
                    height: 410,
                    width: double.infinity,
                    color: AppColor.textFieldGrey,
                    child: Consumer<PetProvider>(
                      builder: (context, value, child) {
                        print("CONSUMER CALLING${value.eventP2List.length}");

                        return Center(
                          child: TableCalendar(
                            calendarFormat: CalendarFormat.month,
                            shouldFillViewport: true,
                            daysOfWeekHeight: 30.0,
                            onPageChanged: (d) {
                              value.mySelectedEvents = {};

                              // selectedDay = d;
                              value.focusedDayyPP = d;

                              value.callgetPetEventP2(d.month, d.year, widget.frmpet);
                              print("month value===>>  ${d.month.toString()}");
                              print("year value===>>  ${d.year.toString()}");
                            },

                            headerStyle: HeaderStyle(
                                headerPadding: const EdgeInsets.symmetric(vertical: 2),
                                headerMargin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                rightChevronIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.newBlueGrey,
                                ),
                                leftChevronIcon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColor.newBlueGrey,
                                ),
                                formatButtonPadding: const EdgeInsets.all(10),
                                rightChevronVisible: true,
                                formatButtonVisible: false,
                                titleCentered: true,
                                formatButtonDecoration: const BoxDecoration(
                                  color: AppColor.newBlueGrey,
                                ),
                                titleTextStyle: const TextStyle(
                                    fontSize: 18, color: AppColor.newBlueGrey, fontWeight: FontWeight.bold),
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColor.newGrey)),

                            focusedDay: value.focusedDayyPP,
                            firstDay: DateTime(1990, 01, 01),
                            lastDay: DateTime(2050, 01, 01),

                            //  startingDayOfWeek: StartingDayOfWeek.monday,
                            // daysOfWeekVisible: true,

                            onDaySelected: (DateTime selectDay, DateTime focusDay) {
                              selectedDayy = selectDay;
                              value.focusedDayyPP = focusDay;
                              selectedDateForFiler = selectDay;
                              setState(() {
                                eventList = petProvider1.filterData(selectDay);
                              });
                            },

                            eventLoader: value.loader ? null : value.getEventsfromDay,

                            calendarStyle: const CalendarStyle(
                              cellMargin: EdgeInsets.zero,
                              todayDecoration: BoxDecoration(
                                color: AppColor.newGrey,
                                shape: BoxShape.rectangle,
                                // borderRadius: BorderRadius.circular(4.0),
                              ),
                              canMarkersOverflow: true,
                              isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                color: AppColor.newBlueGrey,
                                shape: BoxShape.rectangle,
                                // borderRadius: BorderRadius.circular(4.0),
                              ),
                              markerDecoration: BoxDecoration(
                                color: Color(0xffB100FF),
                                shape: BoxShape.circle,
                              ),
                            ),

                            selectedDayPredicate: (DateTime date) {
                              return isSameDay(selectedDayy, date);
                            },
                          ),
                        );
                      },
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                tr(LocaleKeys.petCare_eventList),
                style: const TextStyle(fontFamily: AppFont.poppinsMedium, fontSize: 12, color: Color(0xffBFBFBF)),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            eventList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                        child: Text(
                      tr(LocaleKeys.petCare_noEventsFound),
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColor.newBlueGrey, fontFamily: AppFont.poppinSemibold),
                    )),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: eventList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                petProvider1.setSelNewEvnt(eventList[index]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DeleteEvent(
                                              petIdEvent: eventList[index].petId,
                                              idEvent: eventList[index].id,
                                              frmpet: widget.frmpet,
                                            )));
                              },
                              child: upcommingEventContainer(context, eventList[index]));
                        }),
                  ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 0, top: 2),
        child: FloatingActionButton(
            backgroundColor: AppColor.newBlueGrey,
            onPressed: () {
              petProvider1.petDetailList.isEmpty
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                              child: ConnectivityResult == ConnectivityResult.none
                                  ? Text(tr(LocaleKeys.additionText_chkNet))
                                  : Text(tr(LocaleKeys.home_noPetFound))),
                          actions: <Widget>[
                            InkWell(
                              child: Text(
                                tr(LocaleKeys.additionText_dismiss),
                                style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                              ),
                              onTap: () {
                                print("connectivity status:::::::$ConnectivityResult");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      })
                  : Navigator.push(context, MaterialPageRoute(builder: (context) => NewEvent(frmPet: widget.frmpet)));
            },
            child: const Icon(
              Icons.add,
              size: 40,
            )
            // Image.asset(
            //   AppImage.addIcon,
            //   height: 20,
            // )
            ),
      ),
    );
  }
}

class Event {
  final String title;
  Event({required this.title});

  @override
  String toString() => title;
}
