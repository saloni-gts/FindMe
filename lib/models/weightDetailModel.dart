class WeightDetails{
  int? petId;
  int? id;
  int? userId;
  int? isDeleted;
  double? weight;
  String? description;
  String? date;
  String? createdAt;
  String? updatedAt;


  WeightDetails({
    this.id,
    this.petId,
    this.userId,
    this.isDeleted,
    this.weight,
    this.description,
    this.date,
    this.createdAt,
    this.updatedAt
});

  WeightDetails.fromjson(Map<String,dynamic>json){
    petId = json["petId"];
    id = json["id"];
    userId = json["userId"];
    isDeleted = json["isDeleted"];
    // weight = json["weight"];
    weight=double.parse((json["weight"] ?? 0.0 ).toString());

    description = json["description"];
    date = json["date"].toString();
    // date = DateTime.fromMillisecondsSinceEpoch(int.parse(json["date"].toString()));
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

}