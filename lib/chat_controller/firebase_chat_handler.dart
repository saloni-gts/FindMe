// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:unique_tags/chat_controller/firebase_constant.dart';
//
// import '../services/hive_handler.dart';
// import 'dart:io' show Platform;
//
// class FirebaseChatHandler {
//   static CollectionReference chatStagingCollection = FirebaseFirestore.instance
//       .collection(FirebaseConstant.chatProductionCollection);
//
//   static DocumentReference userDocumentReference = chatStagingCollection
//       .doc("${FirebaseConstant.userDocument}${user?.id ?? 0}");
//
//   static CollectionReference messageCollection = chatStagingCollection
//       .doc("${FirebaseConstant.userDocument}${user?.id ?? 0}")
//       .collection(FirebaseConstant.messageCollection);
//
//   static var user = HiveHandler.getUser();
//
//   static Future createChatRoom() async {
//     bool isExit = await checkIfDocExists(
//         "${FirebaseConstant.userDocument}${user?.id ?? 0}");
//
//     if (!isExit) {
//       Map<String, dynamic> mapData = {
//         FirebaseConstant.firstName: user?.name ?? "",
//         FirebaseConstant.userId: user?.id ?? 0,
//         FirebaseConstant.chatStartDate: DateTime.now().millisecondsSinceEpoch
//       };
//       chatStagingCollection
//           .doc("${FirebaseConstant.userDocument}${user?.id ?? 0}")
//           .set(mapData)
//           .then((value) {
//         print("success");
//       });
//     }
//   }
//
//   static Future<bool> checkIfDocExists(String docId) async {
//     try {
//       DocumentSnapshot documentReference =
//           await chatStagingCollection.doc(docId).get();
//       return documentReference.exists;
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   static Future sendMessage(String msg, int messageType) async {
//     Map<String, dynamic> msgBody = {};
//     msgBody = {
//       FirebaseConstant.message: msg,
//       FirebaseConstant.userId: user?.id ?? 0,
//       FirebaseConstant.sendBy: 2,
//       FirebaseConstant.platForm: Platform.operatingSystem,
//       FirebaseConstant.date: DateTime.now().millisecondsSinceEpoch,
//       FirebaseConstant.msgType: messageType,
//       FirebaseConstant.firstName: user?.name ?? ""
//     };
//     await userDocumentReference
//         .collection(FirebaseConstant.messageCollection)
//         .add(msgBody)
//         .then((val) async {
//       await userDocumentReference
//           .update({FirebaseConstant.lastMessage: msgBody}).then(
//               (value) => checkAdminOnline(userDocumentReference.id));
//     });
//   }
//
//   Stream<QuerySnapshot> getAllMessages() async* {
//     yield* userDocumentReference
//         .collection(FirebaseConstant.messageCollection)
//         .orderBy("messageDate", descending: true)
//         .snapshots();
//   }
//
//   static Future updateOnlineStatus(int status) async {
//     await userDocumentReference.update({FirebaseConstant.isOnline: status});
//   }
//
//   ///retrive the firebase data which comes in key value pair format
//
//   static Future checkAdminOnline(String docId) async {
//     print("function calling..");
//     DocumentSnapshot docsnap = await userDocumentReference.get();
//     Map<String, dynamic> map1 = docsnap.data() as Map<String, dynamic>;
//     print("value of map======${map1}");
//
//     ///reading the value of a particular key of the firebase firestore map
//
//     int i1 = map1["isAdminOnline"] ?? 0;
//     print("printing value...${i1}");
//
//     ///set the value of the key
//
//     if (i1 == 1) {
//       userDocumentReference.set({"adminUnreadBadge": FieldValue.increment(1)},
//           SetOptions(merge: true));
//     } else {
//       userDocumentReference
//           .set({"adminUnreadBadge": 0}, SetOptions(merge: true));
//     }
//   }
// }
