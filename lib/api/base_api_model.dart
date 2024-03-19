class BaseApiModel {
  
  late int statusCode;
  late String message;

  late Map? data;

  BaseApiModel();
  BaseApiModel.fromJson(Map<String, dynamic> json) {

    statusCode = (int.parse((json["status"] ?? "400").toString()));
    if (json["message"] is Map) {
      message = "Server error, please try again later!";
    } else {
      message = json["message"].toString();
    }

    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = statusCode;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
