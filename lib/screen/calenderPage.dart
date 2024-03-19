import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/screen/CalEvent.dart';
import 'package:find_me/util/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


import '../generated/locale_keys.g.dart';
import '../util/color.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
   late Map<DateTime,List<Event>> SelEvents;
 // List<dynamic> SelectedEvents=[];


  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDayy = DateTime.now();
  DateTime focusedDayy = DateTime.now();
  TextEditingController eventController=TextEditingController();
  @override
  void initState() {
    SelEvents={};
    super.initState();

  }
  List<Event> getEventsfromDay(DateTime date){
    return SelEvents[date]?? [];
  }

  @override
  void dispose(){
    eventController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(isbackbutton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColor.textFieldGrey,
              child: TableCalendar(

                focusedDay: focusedDayy,

                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDayy = selectDay;
                    focusedDayy = focusDay;
                  });
                },

                eventLoader: getEventsfromDay,

                calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  )
                ),


                  selectedDayPredicate: (DateTime date){
                  return isSameDay(selectedDayy, date);

    },
              ),
            ),



            ...getEventsfromDay(selectedDayy).map((Event event) =>ListTile(
              title: Text(event.title),
              trailing: IconButton(
                onPressed: (){},
                icon:Icon(Icons.delete) ,
              )
            )

            ),
          ],
        ),
      ),


        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: FloatingActionButton(

              child: Icon(Icons.add),
              backgroundColor: AppColor.textLightBlueBlack,
              onPressed: () {


                showDialog(context: context, builder: (context)=>
                    AlertDialog(
                      title: Text(tr(LocaleKeys.additionText_addEvnt)),
                      content: TextFormField(
                        controller: eventController,
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text( tr(LocaleKeys.additionText_cancel))),


                        TextButton(onPressed: (){
                          if(eventController.text.isEmpty){

                          }
                          else{
                            if(SelEvents[selectedDayy]!=null){
                              SelEvents[selectedDayy]?.add(Event(title: eventController.text)
                              );
                            }
                            else{
                              SelEvents[selectedDayy]=[Event(title: eventController.text)];
                            }
                          }
                          Navigator.pop(context);
                          eventController.clear();
                          setState(() {

                          });
                          return;
                        }, child: Text(AppStrings.ok)),
                      ],

                    ),
                );

              }
          ),
        )
    );


  }
}










//  floatingActionButton: FloatingActionButton.extended(onPressed: (){
        // showDialog(context: context, builder: (context)=>
        //   AlertDialog(
        //     title: Text("Add Event"),
        //     content: TextFormField(
        //       controller: eventController,
        //     ),
        //     actions: [
        //       TextButton(onPressed: (){
        //         Navigator.pop(context);
        //       }, child: Text("Cancel")),
        //
        //
        //       TextButton(onPressed: (){
        //         if(eventController.text.isEmpty){
        //
        //         }
        //         else{
        //           if(SelEvents[selectedDayy]!=null){
        //             SelEvents[selectedDayy]?.add(
        //               Event(title: eventController.text)
        //             );
        //           }
        //           else{
        //             SelEvents[selectedDayy]=[Event(title: eventController.text)];
        //           }
        //
        //
        //         }
        //         Navigator.pop(context);
        //         eventController.clear();
        //         setState(() {
        //
        //         });
        //         return;
        //       }, child: Text("OK")),
        //     ],
        //
        //
        //   ),
        //
        //
        // );
      // },
      //
      //   label: Text("Add Event"),
      // icon: Icon(Icons.add),
      // ),
      //
   // );
