import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../models/eventDetailsModel.dart';
import '../models/newEventDetails.dart';
import '../provider/petprovider.dart';
import '../screen/deleteEventScreen.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';

Widget upcommingEventContainer(BuildContext context ,EventModel eventdata ) {

PetProvider petProvider=Provider.of(context,listen: false);
  var setReTime =eventdata?.isRepeat;
  petProvider.getSetRepetNme(setReTime!);
  return Padding(
    padding: const EdgeInsets.only(left:7.0,right: 7.0,bottom: 10.0),
    child: Container(
      width: double.infinity,

      child: Row(

        children: [
          const CircleAvatar(
            backgroundColor: const Color(0xffB100FF),
            radius: 6.26,
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: MediaQuery.of(context).size.width * .42,
                child: Text(
                  eventdata.eventName??"",
                  maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF2E2E2E),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFont.poppinsBold),
                ),
              ),

               Row(
                 children: [
                   Text(
                       dateConverter(int.parse(eventdata.eventDate??"")) ,
                       style: const TextStyle(
                        color: AppColor.textGreyColor,
                        fontSize: 12,
                        fontFamily: AppFont.poppinsRegular),
              ),

                   petProvider.editpetRepeatEvent.text=="Never"?SizedBox():
                    Text(
                       "(${petProvider.editpetRepeatEvent.text})" ,
                       style: const TextStyle(
                        color: AppColor.textGreyColor,
                        fontSize: 12,
                        fontFamily: AppFont.poppinsRegular),
              ),

              //      Text("- "+
              //          dateConverter(int.parse(eventdata?.endEventDate??"")) ,
              //          style: const TextStyle(
              //           color: AppColor.textGreyColor,
              //           fontSize: 12,
              //           fontFamily: AppFont.poppinsRegular),
              // ),









                 ],
               ),

            ],
          ),

          Spacer(),

          Container(
            height: 33,
           // width: 46.15,

            decoration: BoxDecoration(
                color: const Color(0xffB100FF),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                timeConverter(eventdata.startDate?.millisecondsSinceEpoch??0),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),


          SizedBox(
            width: 6,
          ),

          InkWell(
            // onTap: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteEvent(petIdEvent:eventdata.petId, idEvent: eventdata.id)));
            // },

            child: Container(
              height: 32,
              // width: 29.26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColor.textLightBlueBlack,
              ),
              child: Image.asset(AppImage.nextarrow),
            ),
          ),
        ],
      ),
    ),
  );
}



String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return "${Jiffy(d).format("MMM dd yyyy ")}".toUpperCase();
  // +
  //    "${Jiffy(d).jm}";
}
String timeConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);

  return "${Jiffy(d).format("HH:mm")}".toUpperCase();
  // +
  //    "${Jiffy(d).jm}";
}
