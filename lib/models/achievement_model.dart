class AchievementApiModel {
  List<AchievementModel>? achievement;

  AchievementApiModel.fromJson(Map<String, dynamic> json) {
    if (json['Achievement'] != null) {
      achievement = List<AchievementModel>.from(
          json['Achievement'].map((x) => AchievementModel.fromJson(x)));
    }
  }
}

class AchievementModel {
  int? id;
  String? title;
  String? description;
  String? images;
  int? userId;
  int? petId;
  int? isDeleted;
  String? createdAt;
  String? updateAt;
  String? halfUrl;

  AchievementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    userId = json['userId'];
    petId = json['petId'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
    halfUrl = json['halfUrl'] ?? "";
  }
}
