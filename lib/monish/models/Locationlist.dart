
class LocationListDetails{

  String? Id;
  String?createdDate;
  String?createdDateTimestamp;
  String?updatedDate;
  String?isDeleted;
  String?petId;
  String?userId;
  String?latitude ;
  String?longitude ;

  LocationListDetails.fromjson(Map<String,dynamic> json){
    print("json data $json");
    Id=json["id"].toString();
    createdDate =json['createdDate'].toString();
    // createdDate =json['createdDateTimestamp'].toString();
    createdDateTimestamp =json['createdDateTimestamp'].toString();
    updatedDate =json['updatedDate'].toString();
    isDeleted =json['isDeleted'].toString();
    petId =json['petId'].toString();
    userId =json['userId '].toString();
    latitude=json['latitude'].toString();
    longitude = json['longitude'].toString();
  }
// "id": 5,
// "createdDate": "2022-10-17T08:01:08.000Z",
// "updatedDate": "2022-10-17T08:01:08.000Z",
// "isDeleted": 0,
// "petId": 30,
// "userId": 1,
// "latitude": "26.238947",
// "longitude": "73.024307"

}