import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:find_me/api/resource.dart';
import 'package:find_me/models/usermodel.dart';

import '../models/petProtectionModel.dart';
import '../services/hive_handler.dart';
import 'base_api_model.dart';
import 'network_calls.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class

AppApi {
  static final netWorkCalls = NetworkCalls();

  Future<UserModel> socialLoingApi(Map body) async {
    print("social login request body  $body");
    print("social login api url  body  ${ApiUrl.socialLogin}");
    return resourceApiFun(ApiUrl.socialLogin, body, sendToken: false)
        .then((response) {
      print("social login api response  ${response.data}");
      return UserModel.fromJson(
          response.data, response.status, response.message);
    });
  }

  Future<Resource> signupApi(Map body) async {
    print("API Bodyy  $body");
    return resourceApiFun(ApiUrl.signUpApi, body, sendToken: false)
        .then((response) {
      return response;
    });
  }

  Future<Resource> callupdateNameApi(Map body) async {
    print("API REQUESTT  $body");
    return resourcePut(ApiUrl.updatesNameAPI, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<UserModel> loginCalling(Map body) async {
    print("API REQUESTT  $body");
    return resourceApiFun(ApiUrl.simplogin, body, sendToken: false)
        .then((response) {
      return UserModel.fromJson(
          response.data, response.status, response.message);
    });
  }

  Future<Resource> callAddPetApii(Map body) async {
    print("request  printt  $body");
    return await resourceApiFun(ApiUrl.addPetAPI, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> callupdatePetApii(Map body) async {
    print("request  printt  $body");
    return await resourcePut(ApiUrl.editPet, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getPetApiCall() async {
    return await resourceApiFun(ApiUrl.getAllPets, {}, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> deletecallApi(Map<String, dynamic> body) async {
    return await resourceApiFun(ApiUrl.deletePet, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addDocumentsApi(Map<String, dynamic> body) async {
    return await resourceApiFun(ApiUrl.addDoc, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getDocumentsApi(Map<String, dynamic> body) async {
    return await resourceApiFun(ApiUrl.getDocs, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getDocumentsCList(Map<String, dynamic> body) async {
    return await resourceApiFun(ApiUrl.getDocsCl, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> callDeleteDocApi(Map<String, dynamic> body) async {
    return await resourceApiFun(ApiUrl.deleteDocs, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  // static Future createCustomEvent(String eventName) async {
  //   late FirebaseAnalytics firebaseAnalytics;
  //   firebaseAnalytics = FirebaseAnalytics.instance;
  //   await firebaseAnalytics.logEvent(name: '${eventName}');
  // }

  Future<Resource> callUploadPetImage(bool isSendTokn, List imgs) async {
    return await imageUpload(ApiUrl.commonUpload, {},
            imagesList: imgs, sendToken: isSendTokn)
        .then((value) {
      return value;
    });
  }

  // Future<Resource> requestManagement(
  //     String phoneCode, String mobileNumber) async {
  //   Map body = {"phoneCode": phoneCode, "mobileNumber": mobileNumber};
  //   return await resourceApiFun(ApiUrl.joinManagementAdd, body, sendToken: true)
  //       .then((response) {
  //     return response;
  //   });
  // }

  Future<Resource> verifiedList() async {
    return await resourceApiFun(ApiUrl.joinManagementverifiedList, {},
            sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> verifiedRequest(int id, int isVerified, int userId) async {
    return await resourcePut(ApiUrl.joinManagementverified,
            {"id": id, "isVerfied": isVerified, "userId": userId},
            sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> verifiedPremiumRequest(
      int id, int isVerified, int userId) async {
    return await resourcePut(ApiUrl.deletePremiumMember,
            {"id": id, "isVerfied": isVerified, "userId": userId},
            sendToken: true)
        .then((response) {
      return response;
    });
  }

  ///**Image updload function */
  static Future<Resource> imageUpload(String url, Map body,
      {required List imagesList, bool sendToken = false}) async {
    print("url in api $url");
    print("body in api $body");
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.headers["Content-Type"] = "multipart/form-data";
    var user = HiveHandler.getUser();

    if (sendToken) {
      var _token = user?.token ?? "";
      if (_token.isNotEmpty) {
        request.headers["Authorization"] = user?.token ?? "";
      } else {
        throw "Token not found";
      }
    }

    print("header in api ${request.headers}");
    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // image upload
    if (imagesList.isNotEmpty) {
      // print("image update list not empty");
      print("image update for mobile");
      for (var i = 0; i < imagesList.length; i++) {
        var img = imagesList[i]['image'] as File;
        var key = imagesList[i]['key'] as String;
        // open a bytestream
        var stream = http.ByteStream(DelegatingStream.typed(img.openRead()));
        // get file length
        var length = await img.length();
        var multipartFile = http.MultipartFile(key, stream, length,
            filename: basename(img.path));
        request.files.add(multipartFile);
      }
    }
    print("send files  key ${request.files}");

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        String value = await response.stream.transform(utf8.decoder).join();

        print("response for upload images $value");
        var baseApiModel = BaseApiModel.fromJson(jsonDecode(value));

        if (baseApiModel.statusCode == 200) {
          return Resource.success(baseApiModel.data, baseApiModel.message);
        } else {
          return Resource.error({}, baseApiModel.message);
        }
      } else {
        // String value = await response.stream.transform(utf8.decoder).join()
        return Resource.error({}, "error");
      }
    } catch (e) {
      print("Error in api $e");
      return Resource.error({}, "error");
    }
  }

  static Future<Resource> resourceApiFun(String url, Map body,
      {bool sendToken = false}) async {
    print("############ START POST API  \n"
        "Api Body : ${jsonEncode(body)}   \n\nApi Url:>> $url \n");

    //  Connectivity _connectivity = Connectivity();
    //
    // _connectivity.onConnectivityChanged.listen((result) async {
    //   print("result connection:::::::::${result}");
    //   if (result == ConnectivityResult.none){
    //       return showDialog.....("check internet")
    // else

    return commonPostMethod(url, body, sendToken: sendToken)
        .then((response) async {
      print("response jso $response");
      BaseApiModel? baseApiModel = BaseApiModel.fromJson(jsonDecode(response));
      print(
          "\nApi Data Response>>> \n${baseApiModel.data}  \n\nMessage :>>>> \n${baseApiModel.message}   \n\nStatus :>>>> \n${baseApiModel.statusCode}\n\nEND ###############\n\n ");
      if (baseApiModel.statusCode == 200) {
        return Resource.success(baseApiModel.data, baseApiModel.message);
      } else if (baseApiModel.statusCode == 201) {
        return Resource.inValidMobile(baseApiModel.data, baseApiModel.message);
      } else if (baseApiModel.statusCode == 400) {
        return Resource.errors(baseApiModel.data ?? {}, baseApiModel.message);
      } else if (baseApiModel.statusCode == 401) {
        // return Resource.forceLogout(baseApiModel.data,baseApiModel.message);
        /// other errror
        return Resource.expair({}, baseApiModel.message);
      } else {
        return Resource.error({}, baseApiModel.message);
      }
    });
  }

  static Future<Resource> resourcePut(String url, Map body,
      {bool sendToken = false}) async {
    print("############ START POST API  \n"
        "Api Body : ${jsonEncode(body)}   \n\nApi Url:>> $url \n");

    return commonPutMethod(url, body, sendToken: sendToken)
        .then((response) async {
      print("response jso $response");
      BaseApiModel? baseApiModel = BaseApiModel.fromJson(jsonDecode(response));
      print("\nApi Data Response>>> \n${baseApiModel.data} "
          " \n\nMessage :>>>> \n${baseApiModel.message} "
          "  \n\nStatus :>>>> \n${baseApiModel.statusCode}\n\nEND ###############\n\n ");
      if (baseApiModel.statusCode == 200) {
        return Resource.success(baseApiModel.data, baseApiModel.message);
      } else if (baseApiModel.statusCode == 400) {
        return Resource.errors(baseApiModel.data ?? {}, baseApiModel.message);
      } else if (baseApiModel.statusCode == 401) {
        // return Resource.forceLogout(baseApiModel.data ?? {}, baseApiModel.message);
        /// other errror
        return Resource.expair({}, baseApiModel.message);
      } else {
        return Resource.error({}, baseApiModel.message);
      }
    });
  }

  static Future<Resource> resourceGet(String url,
      {bool sendToken = false}) async {
    print("############ START GET API   \n\nApi Url:>> $url \n");
    return commonGetMethod(url, sendToken: sendToken).then((response) async {
      print(">>>>>>>> response $response");
      BaseApiModel? baseApiModel = BaseApiModel.fromJson(jsonDecode(response));
      print(
          "\nApi Data Response>>> \n${baseApiModel.data}  \n\nMessage :>>>> \n${baseApiModel.message}   \n\nStatus :>>>> \n${baseApiModel.statusCode}\n\nEND ###############\n\n ");
      if (baseApiModel.statusCode == 200) {
        return Resource.success(baseApiModel.data, baseApiModel.message);
      } else if (baseApiModel.statusCode == 400) {
        return Resource.error({}, baseApiModel.message);
      } else if (baseApiModel.statusCode == 401) {
        // return Resource.forceLogout(baseApiModel.data, baseApiModel.message);
        // other error
        return Resource.expair({}, baseApiModel.message);
      } else {
        return Resource.error({}, baseApiModel.message);
      }
    });
  }

  static Future commonPostMethod(String url, Map params,
      {bool sendToken = true}) async {
    Map<String, String> header = {};
    if (sendToken) {
      /// Get token form local
      var user = HiveHandler.getUser();
      if (user != null) {
        //   // var langList=user.userLanguage!.split("-");
        print(" user token >>>> ${user.token}");
        header.putIfAbsent("Authorization", () => user.token ?? "");
        //   // header.putIfAbsent("language", () => langList.last);
      } else {
        print("user not found");
      }
    }
    header.putIfAbsent("content-type", () => "application/json");

    print("header >>>>>> $header");
    var response = await netWorkCalls.post(url, jsonEncode(params), header);
    return response;
  }

  static Future commonPutMethod(String url, Map params,
      {bool sendToken = true}) async {
    Map<String, String> header = {};
    if (sendToken) {
      /// Get token form local
      var user = HiveHandler.getUser();
      if (user != null) {
        //   // var langList=user.userLanguage!.split("-");
        header.putIfAbsent("Authorization", () => user.token ?? "");
        //   // header.putIfAbsent("language", () => langList.last);
      } else {
        print("user not found");
      }
    }
    header.putIfAbsent("content-type", () => "application/json");

    print("header >>>>>> $header");
    var response = await netWorkCalls.put(url, jsonEncode(params), header);
    return response;
  }

  static Future commonGetMethod(String url, {bool sendToken = true}) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    if (sendToken) {
      /// Get token form local
      var user = HiveHandler.getUser();
      await header.putIfAbsent("Authorization", () => user?.token ?? "");
    }

    print("header >>>>>> $header");
    var response = await netWorkCalls.get(url, header);
    return response;
  }

  Future<Resource> forgetPasswordApi(Map body) async {
    return await resourceApiFun(ApiUrl.forgetPassword, body, sendToken: false)
        .then((response) {
      return response;
    });
  }

  Future<Resource> changePasswordApi(Map body) async {
    return await resourcePut(ApiUrl.resetPassword, body, sendToken: false)
        .then((response) {
      return response;
    });
  }

  Future<Resource> callresetPassword(Map body) async {
    return await resourcePut(ApiUrl.passwordupdate, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addPetPhotosApi(Map body) async {
    return await resourceApiFun(ApiUrl.addPetPic, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getPetPhotosGallery(Map body) async {
    return await resourceApiFun(ApiUrl.getAllPetPhoto, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> deletePetPhotos(Map body) async {
    return await resourceApiFun(ApiUrl.deletePetPic, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> petLostApi(Map body) async {
    return await resourcePut(ApiUrl.petLost, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> petLostApiP2(Map body) async {
    return await resourcePut(ApiUrl.petLostP2, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addAchievement(Map body, {bool isForEdit = false}) async {
    return await isForEdit
        ? resourcePut(ApiUrl.editAchievement, body, sendToken: true)
        : resourceApiFun(ApiUrl.addAchievement, body, sendToken: true)
            .then((value) {
            return value;
          });
  }

  Future<Resource> allAchievement(Map body) async {
    return await resourceApiFun(ApiUrl.getAllAchievement, body, sendToken: true)
        .then((value) {
      return value;
    });
  }

  Future<Resource> getAchievementById(Map body) async {
    return await resourceApiFun(ApiUrl.getAchievementById, body,
            sendToken: true)
        .then((value) {
      return value;
    });
  }

  Future<Resource> deleteAchieve(Map body) async {
    return await resourcePut(ApiUrl.deleteAchievement, body, sendToken: true)
        .then((value) {
      return value;
    });
  }

  Future<Resource> attachQrToPet(Map body) async {
    return await resourceApiFun(ApiUrl.petQrCode, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> editDocApi(Map body) async {
    return await resourcePut(ApiUrl.editDoc, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addEventApi(Map body) async {
    return await resourceApiFun(ApiUrl.addEvent, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getAllPetEventsApi(Map body) async {
    return await resourceApiFun(ApiUrl.getAllPetEvents, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> deleteEventsApi(Map body) async {
    return await resourceApiFun(ApiUrl.deleteEvent, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  static Future<Resource> deviceapi(Map body) async {
    print("${body}+++++++*********");
    return await resourceApiFun(ApiUrl.deviceTokenApi, body, sendToken: true)
        .then((response) {
      print("response of token ${response.data}");
      return response;
    });
  }

  Future<Resource> editEventApi(Map body) async {
    return await resourcePut(ApiUrl.editEvent, body, sendToken: true);
  }

  Future<Resource> deleteUserApi(Map body) async {
    return await resourceGet(ApiUrl.deleteUser, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> logoutApi(Map body) async {
    return await resourceGet(ApiUrl.logout, sendToken: true).then((response) {
      return response;
    });
  }

  Future<UserModel> editUserProfileApi(Map body) async {
    return await resourcePut(ApiUrl.updateProfile, body, sendToken: true)
        .then((response) {
      return UserModel.fromJson(
          response.data, response.status, response.message);
    });
  }

  Future<Resource> petlocation(Map body) async {
    return await resourceApiFun(ApiUrl.locationapi, body, sendToken: true)
        .then((response) {
      print("response of map api ${response.data}");
      return response;
    });
  }

  ///p2

  Future<Resource> masterListApi(Map body) async {
    return await resourceGet(ApiUrl.masterList, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> masterEventApi(Map body) async {
    return await resourceGet(ApiUrl.masterEvent, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addNotesApi(Map body) async {
    return await resourceApiFun(ApiUrl.addNotes, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getPetNotesApi(Map body) async {
    return await resourceApiFun(ApiUrl.getNotes, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> deleteNotesApi(Map body) async {
    return await resourcePut(ApiUrl.deleteNotes, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> editNotesApi(Map body) async {
    return await resourcePut(ApiUrl.editNotes, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<UserModel> editProfileP2Api(Map body) async {
    return await resourcePut(ApiUrl.editProfileP2, body, sendToken: true)
        .then((response) {
      return UserModel.fromJson(
          response.data, response.status, response.message);
    });
  }
  //
  // Future<Resource> editProfileP2Api(Map body) async {
  //   return await resourcePut(ApiUrl.editProfileP2, body, sendToken: true)
  //       .then((response) {
  //     return response;
  //   });
  // }

  Future<Resource> addWeightApi(Map body) async {
    return await resourceApiFun(ApiUrl.addWeight, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> forceUpdateApi(Map body) async {
    return await resourceApiFun(ApiUrl.forceUpdate, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getWeightApi(Map body) async {
    return await resourceApiFun(ApiUrl.getWeight, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> deleteWeightApi(Map body) async {
    return await resourcePut(ApiUrl.deleteWeight, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> editWeightApi(Map body) async {
    return await resourcePut(ApiUrl.editWeight, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> sendNotificationApi(Map body) async {
    return await resourcePut(ApiUrl.sendNotification, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addNewDocV2(Map body) async {
    return await resourceApiFun(ApiUrl.addDocV2, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getAllQrTag(Map body) async {
    return await resourceApiFun(ApiUrl.getAllQrTag, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<ProtectionModel> getProtctionApi(Map<String, dynamic> body) async {
    return resourceApiFun(ApiUrl.getProtction, body, sendToken: true)
        .then((response) {
      return ProtectionModel.fromJson(response.data);
    });
  }

  Future<Resource> addProtctionApi(Map body) async {
    return await resourceApiFun(ApiUrl.addProtction, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> requestManagementApi(Map body) async {
    return await resourceApiFun(ApiUrl.joinManagementAdd, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addEventP2Api(Map body) async {
    return await resourceApiFun(ApiUrl.addEventP2, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> editEventP2Api(Map body) async {
    return await resourcePut(ApiUrl.editEventP2, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getEventP2Api(Map body) async {
    return await resourceApiFun(ApiUrl.getEventP2, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> addPetHealthApi(Map body) async {
    return await resourceApiFun(ApiUrl.addPetHealth, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  // Future<Resource> editPetHealthApi(Map body) async {
  //   return await resourceApiFun(ApiUrl.editPetHealth, body, sendToken: true)
  //       .then((response) {
  //     return response;
  //   });
  // }

  Future<Resource> deletePetHealthApi(Map body) async {
    return await resourcePut(ApiUrl.deletePetHealth, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> editPetHealthApi(Map body) async {
    return await resourcePut(ApiUrl.editPetHealth, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> setPetPremApi(Map body) async {
    return await resourcePut(ApiUrl.setPetPrem, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getAllPetHealthApi(Map body) async {
    return await resourceApiFun(ApiUrl.getAllPetHealth, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getAllPetEvent(Map body) async {
    return await resourceApiFun(ApiUrl.getAllEvents, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> downloadProfileApi(Map body) async {
    return await resourceApiFun(ApiUrl.downloadProfile, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> privacyUpdateApi(Map body) async {
    return await resourceApiFun(ApiUrl.privacyUpdate, body, sendToken: true)
        .then((response) {
      return response;
    });
  }




  // Future<Resource> requestManagement(
  //     String phoneCode, String mobileNumber) async {
  //   Map body = {"phoneCode": phoneCode, "mobileNumber": mobileNumber};
  //   return await resourceApiFun(ApiUrl.joinManagementAdd, body, sendToken: true)
  //       .then((response) {
  //     return response;
  //   });
  // }

  Future<Resource> requestManagement(String phoneCode, String mobileNumber,
      int familyMember, int joinManagment) async {
    Map body = {
      "phoneCode": phoneCode,
      "mobileNumber": mobileNumber,
      "addAsFamilyMember": familyMember, // 1
      "addAsJointManagment": joinManagment //1
    };

    print("body is $body");
    return await resourceApiFun(ApiUrl.joinManagementAdd, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> updateSubscription(
      {int planId = 0,
      String receiptData = "",
        bool isRenewd=false,
        int osType=1
      // required int transactionDate
      }) async {
    
    Map bodyMap = {
      "receiptInfo": receiptData,
      // "startDate": 1,
      // "endDate": 1,
      "planId": planId,
      "osType": isRenewd ? osType: Platform.isIOS ?2:1
    };
    print("body $bodyMap");
    return await resourceApiFun(ApiUrl.updateInAppPurchase, bodyMap,sendToken: true);
  }
  

  Future<Resource> callPremiusUserApi() async {
    return await resourceGet(ApiUrl.getFamilyMember, sendToken: true)
        .then((value) {
      return value;
    });
  }


  Future<Resource> preUserInfoApi(Map body) async {
    return await resourceGet(ApiUrl.preUserInfo, sendToken: true)
        .then((response) {
      return response;
    });
  }
  // Future<void> addProduct(String petiddd) {
  //   String url =
  //       'https://testapi.unique-tags.com/api/v2//account/PetProfileDownload';
  //
  //   return http
  //       .post(Uri.parse(url),
  //       body: json.encode({
  //         "petId":petiddd,
  //       }))
  //       .then((response) {
  //     final newProduct = Product(
  //
  //
  //
  //   }).catchError((error){
  //     throw error;
  //   });
  // }

  Future<http.Response> callDownloadAPI() async {
    return http.post(
      Uri.parse(
          'https://testapi.unique-tags.com/api/v2//account/PetProfileDownload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data': "petId",
      }),
    );
  }

  // Future<Resource> MasterEventApi(Map body) async {
  //   return await resourceGet(ApiUrl.masterEvent, sendToken: true)
  //       .then((response) {
  //     return response;
  //   });
  // }

  Future<Resource> editProtectionApi(Map body) async {
    return await resourcePut(ApiUrl.editProtction, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> editHealthyPetWeightApi(Map body) async {
    return await resourcePut(ApiUrl.editHealthyPetWeight, body, sendToken: true)
        .then((response) {
      return response;
    });
  }

  Future<Resource> getSubScriptonDetails()async{
    return await resourceGet(ApiUrl.getinAppPurchase,sendToken: true).then((value) {
        return value;
    });
  }

  Future<Resource> getPetPremDetails()async{
    return await resourceGet(ApiUrl.chkPetPrem,sendToken: true).then((value) {
        return value;
    });
  }

  Future<Resource> contactUsApi() async {
    return await resourceGet(ApiUrl.contactUs, sendToken: true)
        .then((value) {
      return value;
    });
  }


}

// Future<Resource> logoutApi(Map body) async {
//   return await resourceGet(ApiUrl.logout, sendToken: true)
//       .then((response) {
//     return response;
//   });
// }

class ApiUrl {
  // static const baseUrl = "http://52.207.19.194:4007/api/v1/";

  // . TO DO LIST
//   Api link
// link for scan tag  (Sample Screen)
// links for web pages - faq etc
// Change chat node to "chat_prod"
// Firebase Chat Handler chatStaging and chatProduction
//sample screen production and staging url

  static const getAllPets = baseUrlP2 + "/account/getPetUserId";
  static const baseUrl = "https://api-stage.find-me.app/api/v1/";       // staging
  // static const baseUrl = "https://api.find-me.app/api/v1/";      // Production Url

  static const normalLogin = baseUrl + "account/signUp";
  static const simplogin = baseUrl + "/account/login";
  static const socialLogin = baseUrl + "/account/Sociallogin";
  static const forgetPassword = baseUrl + "account/forgot-password";
  static const signUpApi = baseUrl + "/account/signUp";
  static const updatesNameAPI = baseUrl + "/account/updateName";
  static const resetPassword = baseUrl + "/account/change-password";
  static const passwordupdate = baseUrl + "/account/change-password-old";
  static const commonUpload = baseUrl + "/common/upload-image";
  static const addPetAPI = baseUrl + "/account/AddPet";
  static const getPetAPI = baseUrl + "/account/getPetUserIdV2";
  static const editPet = baseUrl + "/account/editPet";
  static const deletePet = baseUrl + "/account/deletePet";
  static const addDoc = baseUrl + "/account/addDocument";
  // static const getDocs = baseUrl + "/account/getAllDocument";
  static const deleteDocs = baseUrl + "/account/deleteDocument";
  static const addPetPic = baseUrl + "/account/addPetPhoto";
  static const getAllPetPhoto = baseUrl + "/account/getAllPetPhoto";
  static const deletePetPic = baseUrl + "/account/deletePetPhoto";
  static const petLost = baseUrl + "/account/isLost";
  // static const petQrCode = baseUrl + "/account/AttachQrToPet";
  static const editDoc = baseUrl + "/account/editDocument";
  static const editEvent = baseUrl + "/account/editEvent";
  static const addEvent = baseUrl + "/account/addEvent";
  static const deleteEvent = baseUrl + "/account/deleteEvent";
  static const getAllPetEvents = baseUrl + "/account/getAllEventPet";
  static const deviceTokenApi = baseUrl + "/account/updateDeviceToken";
  static const updateProfile = baseUrl + "/account/updateName";
  static const deleteUser = baseUrl + "/account/DeletedUser";
  static const locationapi = baseUrl + "/common/sendPetLocationList";
  static const logout = baseUrl + "/account/logout";
  static const forceUpdate = baseUrl + "/account/forceUpdate";
 static const privacyUpdate = baseUrl + "/account/isPrivacyUpdate";
  ///phase 2

  static const baseUrlP2 = "https://api-stage.find-me.app/api/v2/"; //staging
  // static const baseUrlP2 = "https://api.find-me.app/api/v2/";          //Production

  static const masterList = baseUrlP2 + "/common/masterList";
  static const addNotes = baseUrlP2 + "/account/addNotes";
  static const getNotes = baseUrlP2 + "/account/getAllNotes";
  static const deleteNotes = baseUrlP2 + "/account/notesDeleteId";
  static const editNotes = baseUrlP2 + "/account/notesEditId";
  static const addWeight = baseUrlP2 + "/account/WeightAdd";
  static const getWeight = baseUrlP2 + "/account/getAllWeight";
  static const deleteWeight = baseUrlP2 + "/account/weightDeleteId";
  static const editWeight = baseUrlP2 + "/account/weighteditId";

  static const addDocV2 = baseUrlP2 + "/account/addDocument";
  static const getDocsCl = baseUrlP2 + "/account/CatgoryList";
  static const getDocs = baseUrlP2 + "/account/getAllDocument";  

  static const petQrCode = baseUrlP2 + "/account/AttachQrToPet";
  static const getAllQrTag = baseUrlP2 + "/account/getPetAllTag";

  static const addProtction = baseUrlP2 + "/account/AddcheckMyProtection";
  static const editProtction = baseUrlP2 + "/account/EditcheckMyProtection";
  static const getProtction = baseUrlP2 + "/account/GetcheckMyProtection";

  static const joinManagementAdd = baseUrlP2 + "/account/JointMangmentAdd";
  static const joinManagementverified =
      baseUrlP2 + "/account/JointMangmentisVerfied";
  static const joinManagementverifiedList = baseUrlP2 + "/account/JointMangmentisVerfiedList";

  static const addAchievement = baseUrlP2 + "/account/addAchievement";
  static const getAllAchievement = baseUrlP2 + "/account/getAllAchievement";
  static const getAchievementById = baseUrlP2 + "/account/getAchievementId";
  static const editAchievement = baseUrlP2 + "/account/editAchievement";
  static const deleteAchievement = baseUrlP2 + "/account/deleteAchievement";

  static const addPetHealth = baseUrlP2 + "/account/addPetHealth";
  static const editPetHealth = baseUrlP2 + "/account/editPetHealth";
  static const deletePetHealth = baseUrlP2 + "/account/deletePetHealth";
  static const getAllPetHealth = baseUrlP2 + "/account/getAllPetHealth";

  static const addPetP2 = baseUrlP2 + "/account/addPet";
  static const editPetP2 = baseUrlP2 + "/account/editPet";

  static const editHealthyPetWeight =
      baseUrlP2 + "/account/editHelthyPetWeight";

  static const editEventP2 = baseUrlP2 + "/account/editEvent";
  static const addEventP2 = baseUrlP2 + "/account/addEvent";
  static const getEventP2 = baseUrlP2 + "/account/getAllEventPet";
  static const masterEvent = baseUrlP2 + "/common/MasterEvents";

  static const downloadProfile = baseUrlP2 + "/account/PetProfileDownload";
  static const sendNotification = baseUrlP2 + "/account/isSendNotIfication";

  static const getFamilyMember = baseUrlP2 + "account/GetFamilyMemeber";
  static const deletePremiumMember = baseUrlP2 + "account/JointMangmentisVerfiedPremium";

  static const preUserInfo = baseUrlP2 + "/account/getUserInfo"; //get
  static const getAllEvents = baseUrlP2 + "/account/getAllEventPet";

  static const petLostP2 = baseUrlP2 + "/account/isLost";
  static const editProfileP2 = baseUrlP2 + "/account/editProfile";
  static const getinAppPurchase = baseUrlP2 + "/account/GetinAppPurchase";
  static const updateInAppPurchase = baseUrlP2 + "/account/inAppPurchase";



  static const contactUs = baseUrlP2 + "/account/ContactUs";
  static const setPetPrem = baseUrlP2 + "/account/petPremium";
  static const chkPetPrem = baseUrlP2 + "/account/isPetPrimieum";




  // static const preUserInfo = baseUrlP2 + "/account/getUserInfo"; //get

  // static const addPetPic = baseUrl + "/account/addPetPhoto";
  // static const getAllPetPhoto = baseUrl + "/account/getAllPetPhoto";
  // static const deletePetPic = baseUrl + "/account/deletePetPhoto";

  // static const petLost = baseUrl + "/account/isLost";
  // static const petQrCode = baseUrl + "/account/AttachQrToPet";
  // static const editDoc = baseUrl + "/account/editDocument";

  // static const addEvent = baseUrl + "/account/addEvent";
  // static const deleteEvent = baseUrl + "/account/deleteEvent";
  // static const getAllPetEvents = baseUrl + "/account/getAllEventPet";
  // static const deviceTokenApi = baseUrl + "/account/updateDeviceToken";

  /// Production

  // static const aboutUSPAGE = "https://utagsuk.s3.amazonaws.com/Pages/about.html";
  // static const faqPAGE = "https://utagsuk.s3.amazonaws.com/Pages/faq.html";
  // static const privacyPloicyPAGE = "https://utagsuk.s3.amazonaws.com/Pages/privacy-policy.html";
  // static const termsPAGE = "https://utagsuk.s3.amazonaws.com/Pages/terms-conditions.html";
  // static const howItWorks = "https://utagsuk.s3.amazonaws.com/Pages/How_its_Work.html";
  // static const visitWbsite = "https://unique-tags.com/password";

  ///staging      

  static const aboutUSPAGE ="https://find-me-content.s3.amazonaws.com/Others/Others_1711029477521.html";
  static const faqPAGE = "https://find-me-content.s3.amazonaws.com/Others/Others_1711029514252.html";
  static const privacyPloicyPAGE ="https://find-me-content.s3.amazonaws.com/Others/Others_1711029570729.html";
  static const termsPAGE ="https://find-me-content.s3.amazonaws.com/Others/Others_1711029601948.html";
  static const howItWorks ="https://find-me-content.s3.amazonaws.com/Others/Others_1711029546150.html";
  static const visitWbsite = "https://find-me.app";
}
