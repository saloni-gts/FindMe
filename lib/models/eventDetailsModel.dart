import 'package:jiffy/jiffy.dart';

class EventDetails {
  int? petId;
  int? id;
  int? eventCategory;
  String? eventType;
  String? eventDate;
  String? eventName;
  DateTime? convertedDate;
  String? petName;
  String? petPhoto;

  // create constructuor
 EventDetails({
    this.petId,
    this.id,
    this.eventCategory,
    this.eventType,
    this.eventDate,
    this.convertedDate,
    this.petName,
    this.petPhoto,
  });

  EventDetails.fromjson(Map<String, dynamic> json) {

    petId = json["petId"];
    id = json["id"];
    eventCategory = json["eventCategory"];
    eventType = json["eventType"];
    eventDate = json["eventDate"];
    eventName = json["eventName"];

    convertedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(json["eventDate"].toString()));
    petName = json["petName"];
    petPhoto = json["petPhoto"];

  }
}




String dateConverter(int date) {
  var d = DateTime.fromMillisecondsSinceEpoch(date);
  return Jiffy(d).format("dd MMMM yyyy");

}
