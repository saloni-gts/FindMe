import 'dart:convert';

import 'package:find_me/api/call_api.dart';
import 'package:http/http.dart' as http;

import '../services/hive_handler.dart';

class CallAPi {
  String pdfUrl = "";
  AppApi api = AppApi();
  Future<String> login({required int petId}) async {
    print("petid===>>$petId");
    Map<String, dynamic> body = {"petId": petId};
    var user = HiveHandler.getUser();
    //   'https://testapi.unique-tags.com/api/v2//account/PetProfileDownload'   //staging https://api-stage.find-me.app/api/v2/
    try {
      var response = await http.post(
        Uri.parse('https://api-stage.find-me.app/api/v2//account/PetProfileDownload'),
        headers: {"Content-Type": "application/json", 'Authorization': user?.token ?? ""},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        print("bodyyy>>>$body");
        final parsedJson = jsonDecode(response.body);
        pdfUrl = parsedJson["data"];
      } else {
        pdfUrl = "";
      }
    } catch (e) {
      pdfUrl = "";
    }
    return pdfUrl;

    
  }

 
}
