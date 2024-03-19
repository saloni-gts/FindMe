class PlansApiModel{
  int? id;
  String? receiptInfo;
  String? startDate;
  String? endDate;
  int? planId;
  int? paymentStatus;
  String? userId;
  int? isPrremium;
  int? isRenewed;
  int? isExpire;
  int? isJoint;
  int? osType;
  int? isBtnDisable;


PlansApiModel.fromJson(Map json){
      id=json['id'] ??0;
      receiptInfo=json['receiptInfo']??"";
      endDate=json['endDate']??"";
      startDate=json['startDate']??"";
      planId=json['planId'] ??0;
      paymentStatus=json['paymentStatus']??0;
      userId=json['userId'].toString()??"";
      isPrremium=json['isPremium']??0;
      isRenewed=json['isRenewed']??0;
      isExpire=json['isExpire']??0;
      isJoint=json['isJoint']??0;
      osType=json['osType'] ??1;
      isBtnDisable=json['isBtnDisable'] ??1;

  }


}

  // "id": 2,
  //               "receiptInfo": "0",
  //               "startDate": "100",
  //               "endDate": "200",
  //               "planId": 3,
  //               "paymentStatus": 1,
  //               "userId": "100",
  //               "isDeleted": 0,
  //               "createdAt": "2023-04-18T06:45:29.000Z",
  //               "updateAt": "2023-04-18T06:45:29.000Z",
  //               "isPremium": 1