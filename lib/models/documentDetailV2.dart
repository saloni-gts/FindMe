class DocumentDetailsV2 {
  List<CatagoriesList>? catagoriesList;
  int? isPremium;
  int? totalDocumentAllCatagory;
  int? isNotAddDocument;
  String? totalMasterDocumentCount;

  DocumentDetailsV2.fromjson(Map<String, dynamic> json) {

    List _categoryListTemp=json["catagoriesList"] ??[];

    catagoriesList=_categoryListTemp.map((e) => CatagoriesList.fromJson(e)).toList();
    isPremium = json['isPremium'];
    totalDocumentAllCatagory = json['TotalDocumentAllCatagory'];
    isNotAddDocument = json['isNotAddDocument'];
    totalMasterDocumentCount = json['TotalMasterDocumentCount'];
  }
}


class CatagoriesList {
  int? id;
  String? createdDate;
  String? updatedDate;
  int? isDeleted;
  String? categoryName;
  String? catagoryUrl;
  int? totalDocumentCount;

  CatagoriesList({this.id,
    this.createdDate,
    this.updatedDate,
    this.isDeleted,
    this.categoryName,
    this.catagoryUrl,
    this.totalDocumentCount});

  CatagoriesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isDeleted = json['isDeleted'];
    categoryName = json['categoryName'];
    catagoryUrl = json['catagoryUrl'];
    totalDocumentCount = json['totalDocumentCount'];
  }
}