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

    //     .then((value) async {
    //   print("bodyyy>>>${body}");
    //   //  print("bodyyy>>>${h}");
    //   EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.clear);

    //   if (value.statusCode == 200) {
    //     EasyLoading.dismiss();
    //     print("======>> response ${value.body}");
    //     final parsedJson = jsonDecode(value.body);
    //     pdfUrl = parsedJson["data"];
    //     print("parsedJson==>> ${pdfUrl}");
    //     return pdfUrl;
    //   } else {
    //     pdfUrl = "";
    //   }
    // });
  }

  // Future<File> urlToImg(String imgUrl) async {
  //
  // print("imgUrl${imgUrl}");
  //   // storyProvider.updateLoader(true);
  //   http.Response responseData = await http.get(Uri.parse(imgUrl));
  //   Uint8List uint8list = responseData.bodyBytes;
  //   var dir = (await getApplicationDocumentsDirectory()).path;
  //   File imageFile = File(("$dir/" + DateTime.now().millisecondsSinceEpoch.toString())! + ".pdf");
  //   var buffer = uint8list.buffer;
  //   ByteData byteData = ByteData.view(buffer);
  //   imageFile.writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   print("path of img file ${imageFile.path}");
  //   // storyProvider.updateLoader(false);
  //   return imageFile;
  // }
}
