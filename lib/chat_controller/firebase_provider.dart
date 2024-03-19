// import 'dart:io';
// import 'package:path/path.dart' as Path;
//
// import 'package:flutter/material.dart';
// import 'package:unique_tags/chat_controller/firebase_chat_handler.dart';
//
// class FirebaseChatProvider extends ChangeNotifier {
//   File? pickedFile;
//   int fileType = 1;
//   String? fileUrl;
//   bool loader=false;
//   bool showUploadIcon=false;
//
//
//   updateUploadIcon(bool val){
//     showUploadIcon=val;
//     print("call ");
//     Future.delayed(Duration(milliseconds: 10),(){
//       notifyListeners();
//     });
//
//   }
//
//   updateLoader(bool val){
//     loader=val;
//     notifyListeners();
//   }
//
//   updatePickedFile(File? val,BuildContext context) {
//     pickedFile = val;
//     if (val != null) {
//       fileType = 2;
//     }
//     Navigator.pop(context);
//     notifyListeners();
//   }
//
//   Future callCreateRoom() async {
//     await FirebaseChatHandler.createChatRoom();
//     notifyListeners();
//   }
//
//   Future callSendMessage(String title,int fileType) async {
//     if (pickedFile != null) {}
//
//     if (title.isNotEmpty) {
//       await FirebaseChatHandler.sendMessage(title, fileType);
//     }
//
//     notifyListeners();
//   }
//
//   // Future saveImageToStorage(BuildContext context) async {
//   //     updateLoader(true);
//   //   Reference _reference = FirebaseStorage.instance
//   //       .ref()
//   //       .child('sendFile/${Path.basename(pickedFile!.path)}');
//   //   await _reference
//   //       .putData(
//   //     await pickedFile!.readAsBytes(),
//   //     SettableMetadata(contentType: 'image/jpeg'),
//   //   )
//   //       .whenComplete(() async {
//   //     await _reference.getDownloadURL().then((value) async {
//   //       fileUrl = value;
//   //      await  callSendMessage(value,2).then((value) {
//
//   //        updateLoader(false);
//   //      }).onError((error, stackTrace) {
//   //        updateLoader(false);
//   //      });
//   //     });
//   //   });
//   //   notifyListeners();
//   // }
//
//   Future callUpdateStatusFun(int status) async{
//     await FirebaseChatHandler.updateOnlineStatus(status);
//     notifyListeners();
//   }
// }
