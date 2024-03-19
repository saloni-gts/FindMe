import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';


import '../components/globalnavigatorkey.dart';
import '../provider/authprovider.dart';
import '../services/hive_handler.dart';

final client = Client();

class NetworkCalls {

  Future<String> get(String url, Map<String, String>? header) async {


// initConnectivity();

   bool checkConn= await checkInternet();
   print("checking connectionnnn${checkConn}");



   // var _user = HiveHandler.getUserLanguage();
   //      if (_user != null) {
   //        var langList = _user.split("-");
   //        if (langList.last == "US") {
   //         header?.putIfAbsent("language", () => "en");
   //        } else if (langList.last == "NOR") {
   //        header?.putIfAbsent("language", () => "nor");
   //        } else {
   //
   //        }}

if(checkConn){
  return await client.get(Uri.parse(url), headers: header).then((response) async {
    print("checking status code===== ${response.statusCode }");
    // if(response.statusCode==Status.forceLogout){
    //   AuthProvider authprovider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
    //   await authprovider.logoutApiCall(GlobalVariable.navState.currentContext!);
    // }
    return response.body;






  });
}
else {
  return "";
}
    // return await client.get(Uri.parse(url), headers: header).then((response) {
    //   return response.body;
    // });

    // .onError((error, stackTrace) {
    //   print(">>>>>>>>> error >>>>> ${error}");
    //   return "{}";
    // });
  }

  Future<String> post(String url, var body, Map<String, String>? header) async {
   bool checkConn= await checkInternet();
   print("checking connectionnnn${checkConn}");
    // var _user = HiveHandler.getUserLanguage();
    //     if (_user != null) {
    //       var langList = _user.split("-");
    //       if (langList.last == "US") {
    //        header?.putIfAbsent("language", () => "en");
    //       } else if (langList.last == "NOR") {
    //       header?.putIfAbsent("language", () => "nor");
    //       } else {
         
    //       }}
    print("inside post ->>>>>> header >>>>>. $header");
    if(checkConn){
      var response =
      await client.post(Uri.parse(url), body: body, headers: header);
      print("checking status code===== ${response.statusCode }");
      // if(response.statusCode==Status.forceLogout){
      //   AuthProvider authprovider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
      //   await authprovider.logoutApiCall(GlobalVariable.navState.currentContext!);
      // }

      // checkAndThrowError(response);
      return response.body;
    }

    else {
      return "";
    }

    // var response =
    //     await client.post(Uri.parse(url), body: body, headers: header);
    //
    // // checkAndThrowError(response);
    // return response.body;
  }

  Future<String> put(String url, var body, Map<String, String>? header) async {
  bool checkConn= await checkInternet();
  print("checking connectionnnn${checkConn}");
//  var _user = HiveHandler.getUserLanguage();
//         if (_user != null) {
//           var langList = _user.split("-");
//           if (langList.last == "US") {
//            header?.putIfAbsent("language", () => "en");
//           } else if (langList.last == "NOR") {
//           header?.putIfAbsent("language", () => "nor");
//           } else {
         
//           }}
if(checkConn){
  var response = await client.put(Uri.parse(url), body: body, headers: header);
  print("checking status code===== ${response.statusCode }");
  // if(response.statusCode==Status.forceLogout){
  //   AuthProvider authprovider = Provider.of(GlobalVariable.navState.currentContext!, listen: false);
  //   await authprovider.logoutApiCall(GlobalVariable.navState.currentContext!);
  // }
  checkAndThrowError(response);
  return response.body;
}
else{
  return "";
}

    // var response =
    //     await client.put(Uri.parse(url), body: body, headers: header);
    // checkAndThrowError(response);
    // return response.body;
  }

  static void checkAndThrowError(Response response) {
    if (response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }

}


Future checkInternet() async {
  bool result = await InternetConnectionChecker().hasConnection;
  print("result while call fun ${result}");
  if (result == false) {
   Future.delayed(Duration(seconds: 1),()async{
     await EasyLoading.showToast("Internet Not Connected",toastPosition: EasyLoadingToastPosition.bottom);
   });
   return result;
    // Future.delayed(Duration(seconds: 1), () {
    //   print("Looks like you are not connected to the internet");
    //   showToast("Internet Not Connected!!");
    //
    //  // EasyLoading.showToast(tr(LocaleKeys.showToast_netNotConn
    //  //  showToast("Looks like you are not connected to the internet");
    //
    // });
  }else{}
  return result;
}


showToast(String message) {
  if (message.isNotEmpty) {
    EasyLoading.showToast(message);
  }
}


