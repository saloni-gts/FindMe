class DocumentDetails {
  int? id;
  String? createdDate;
  String? updatedDate;
  int? userId;
  int? petId;
  int? documentCategoryId;
  String? title;
  String? docUrls;
  String? issuedDate;
  int? fileType;
  String? petPhoto;


  DocumentDetails.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    createdDate = json["createdDate"].toString();
    updatedDate = json["updatedDate"].toString();
    userId = json["userId"];
    petId = json["petId"];
    documentCategoryId = json["documentCategoryId"];
    title = json["title"];
    docUrls = json["docUrls"];
    issuedDate = json["issuedDate"];
    fileType = json["fileType"];
    petPhoto = json["petPhoto"];
  }
}
