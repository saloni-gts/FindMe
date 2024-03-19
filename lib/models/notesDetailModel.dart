class NotesDetails {
  int? id;
  int? notesCatagoriesId;
  int? notesTypesCatagoriesId;
  String? title;
  String? drug;
  String? petName;
  String? petPhoto;
  int? reaction;
  int? petId;
  int? userId;
  int? isDeleted;
  String? createdAt;
  String? updateAt;
  String? profileImage;
  String? createdDateTimeStamp;
  String? notesCatagoriesName;
  String? notesCatagoriesTypesName;
  List<Imagee>image=[];

  NotesDetails({
    this.id,
    this.notesCatagoriesId,
    this.notesTypesCatagoriesId,
    this.title,
    this.drug,
    this.reaction,
    this.petName,
    this.petPhoto,
    this.createdDateTimeStamp,
    required this.image,
    this.petId,
    this.userId,
    this.isDeleted,
    this.createdAt,
    this.updateAt,
    this.profileImage,
    this.notesCatagoriesName,
    this.notesCatagoriesTypesName
  });

  NotesDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notesCatagoriesId = json['notesCatagoriesId'];
    notesTypesCatagoriesId = json['notesTypesCatagoriesId'];
    title = json['title'];
    drug = json['drug'];
    reaction = json['reaction'];
    notesCatagoriesName = json['notesCatagoriesName'];
    notesCatagoriesTypesName = json['notesCatagoriesTypesName'];

    if (json['image'] != null) {
      image = <Imagee>[];
      json['image'].forEach((v) {
        image!.add(new Imagee.fromJson(v));
      });
    }

    petId = json['petId'];
    petPhoto=json['petPhoto'];
    petName=json['petName'];
    userId = json['userId'];
    isDeleted = json['isDeleted'];
    createdDateTimeStamp = json['createdDateTimeStamp'].toString();
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    profileImage = json['profileImage'];
  }
}


  class Imagee {
  String? url;
  String? halfUrl;

  Imagee({this.url,this.halfUrl});

  Imagee.fromJson(Map<String, dynamic> json) {
  url = json['url'];
  halfUrl = json['halfUrl'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['url'] = this.url;
  data['halfUrl'] = this.halfUrl;
  return data;
  }
  }


  // class Imagee {
  // String? url;
  //
  // Imagee({this.url});
  //
  // Imagee.fromJson(Map<String, dynamic> json) {
  // url = json['url'];
  // }
  //
  // Map<String, dynamic> toJson() {
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['url'] = this.url;
  // return data;
  // }
  // }
  //
  //
