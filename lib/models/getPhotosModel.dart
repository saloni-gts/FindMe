class GetPetPhotos{
  int? id;
  int? petId;
  int? userId;
  String? photo;

  GetPetPhotos({this.id,this.photo,this.petId,this.userId});

  GetPetPhotos.fromJson(Map<String,dynamic> json){

    id=json["id"];
    petId=json["petId"];
    userId=json["userId"];
    photo=json["photo"];

  }


}