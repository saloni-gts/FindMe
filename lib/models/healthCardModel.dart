class HealthCard{
  int? id;
  int? petId;
  int? userId;
  String? Allergies;
  String? Treatments;
  String? Vaccination;
  double? Weight;
  int? isDeleted;
  String? createdAt;
  String? updateAt;


  HealthCard(
  {
    this.id,
    this.userId,
    this.petId,
    this.Vaccination,
    this.Allergies,
    this.Treatments,
    this.Weight,
    this.isDeleted,
    this.updateAt,
    this.createdAt
});

  HealthCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    petId = json['petId'];
    isDeleted = json['isDeleted'];
    Treatments = json['Treatments'];
    Vaccination = json['Vaccination'];
    Allergies = json['Allergies'];
    Weight = double.parse((json["Weight"] ?? 0.0 ).toString());
  }


}