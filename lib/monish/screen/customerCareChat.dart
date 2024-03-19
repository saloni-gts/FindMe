// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:provider/provider.dart';
// import 'package:unique_tags/chat_controller/firebase_chat_handler.dart';
// import 'package:unique_tags/chat_controller/firebase_provider.dart';
// import 'package:unique_tags/components/appbarComp.dart';
// import 'package:unique_tags/components/camraOption.dart';
// import 'package:unique_tags/util/app_font.dart';
// import 'package:unique_tags/util/app_images.dart';
// import 'package:unique_tags/util/appstrings.dart';
//
// import '../../chat_controller/chat_model.dart';
// import '../../components/shortpage.dart';
// import '../../generated/locale_keys.g.dart';
// import '../../services/hive_handler.dart';
//
// class Customerchat extends StatefulWidget {
//   const Customerchat({Key? key}) : super(key: key);
//
//   @override
//   State<Customerchat> createState() => _CustomerchatState();
// }
//
// class _CustomerchatState extends State<Customerchat> {
//   TextEditingController chatController = TextEditingController();
//   late FirebaseChatProvider chatProvider;
//    ScrollController chatListController=ScrollController();
//
//   @override
//   void initState() {
//     chatProvider = Provider.of(context, listen: false);
//     chatListController = ScrollController();
//     chatProvider.updateUploadIcon(true);
//    // _scrolDown();
//     chatProvider.callUpdateStatusFun(1);
//
//     super.initState();
//   }
//
//   void _scrolDown() {
//     chatListController.addListener(() {
//       chatListController.position.maxScrollExtent;
//     });
//
//   }
//
//   @override
//   void dispose() {
//     chatProvider.callUpdateStatusFun(0);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration(milliseconds: 600),(){
//       // chatListController.jumpTo(chatListController.position.maxScrollExtent);
//     });
//     return Scaffold(
//         appBar: customAppbar(
//           titlename:  tr(LocaleKeys.additionText_customerchat),
//           isbackbutton: true,
//         ),
//         body: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: SizedBox()
//
//           // Column(
//           //   children: [
//           //     Expanded(
//           //         flex: 8,
//           //         // child: Consumer<FirebaseChatProvider>(
//           //         //     builder: (context, dataa, child) {
//           //         //   return
//           //         child:
//           //             // !context.watch<FirebaseChatProvider>().loader
//           //             //      ?
//           //             StreamBuilder<QuerySnapshot>(
//           //           stream: FirebaseChatHandler().getAllMessages(),
//           //           builder: (context, snapshot) {
//           //             switch (snapshot.connectionState) {
//           //               case ConnectionState.none:
//           //                 return const Center(child: Text(AppStrings.error));
//           //
//           //               case ConnectionState.waiting:
//           //                 return const Center(
//           //                     child: CircularProgressIndicator.adaptive()
//           //                 );
//           //
//           //               case ConnectionState.active:
//           //               case ConnectionState.done:
//           //                 if (snapshot.hasData) {
//           //                   int length = snapshot.data?.docs.length ?? 0;
//           //                   return length > 0
//           //                       ? ListView.builder(
//           //                     reverse: true,
//           //                           controller: chatListController,
//           //                           itemCount: snapshot.data?.docs.length,
//           //                           itemBuilder: (context, index) {
//           //                             ChatModel chatModel = ChatModel.fromJson(
//           //                                 snapshot.data?.docs[index].data()
//           //                                     as Map<String, dynamic>);
//           //                             return Align(
//           //                                 alignment: (chatModel.sendBy == 1
//           //                                     ? Alignment.topLeft
//           //                                     : Alignment.topRight),
//           //                                 child: chatModel.sendBy == 2
//           //                                     ? senderChatWidget(chatModel)
//           //                                     : receiverChatWidget(chatModel));
//           //                           },
//           //                         )
//           //                       : const Center(
//           //                           child: Text(
//           //                             AppStrings.msgNotFound,
//           //                             style: TextStyle(fontSize: 20),
//           //                           ),
//           //                         );
//           //                 } else {
//           //                   return const Center(
//           //                     child: Text(AppStrings.msgNotFound),
//           //                   );
//           //                 }
//           //             }
//           //           },
//           //         )
//           //         // : const Center(child: CircularProgressIndicator.adaptive())
//           //         // }),
//           //         ),
//           //     Container(
//           //       height: 90,
//           //       decoration: const BoxDecoration(
//           //         color: Colors.white,
//           //         boxShadow: [
//           //           BoxShadow(
//           //             color: Color.fromRGBO(0, 0, 0, 0.06),
//           //             offset: Offset(0.2, 0.6), //(x,y)
//           //             blurRadius: 6.0,
//           //           )
//           //         ],
//           //       ),
//           //       child: Center(
//           //         child: Consumer<FirebaseChatProvider>(
//           //             builder: (context, data, child) {
//           //               print("data.showUploadIcon ${data.showUploadIcon}");
//           //           return Row(
//           //             crossAxisAlignment: CrossAxisAlignment.center,
//           //             children: [
//           //               data.showUploadIcon
//           //                   ? InkWell(
//           //                       onTap: () async {
//           //                         showAlertForImage(
//           //                             context: context,
//           //                             callBack: (val) async {
//           //                               if (val) {
//           //                                 File? pickedFile =
//           //                                     await getDirectImage(
//           //                                             ImageSource.camera,circleCropStyle: false)
//           //                                         .then((value) {
//           //                                   chatProvider.updatePickedFile(
//           //                                       value, context);
//           //                                   chatProvider
//           //                                       .saveImageToStorage(context)
//           //                                       .then((value) {});
//           //                                   return null;
//           //                                 });
//           //                               } else {
//           //                                 File? pickedFile =
//           //                                     await getDirectImage(
//           //                                             ImageSource.gallery,circleCropStyle: false)
//           //                                         .then((value) {
//           //                                   chatProvider.updatePickedFile(
//           //                                       value, context);
//           //                                   chatProvider
//           //                                       .saveImageToStorage(context)
//           //                                       .then((value) {});
//           //                                   return null;
//           //                                 });
//           //                               }
//           //                             },
//           //                             headText: "Choose Image");
//           //                       },
//           //                       child: Padding(
//           //                         padding: const EdgeInsets.only(left: 15),
//           //                         child: Image.asset(
//           //                           AppImage.imagebox,
//           //                           height: 24,
//           //                           width: 24,
//           //                         ),
//           //                       ),
//           //                     )
//           //                   : SizedBox(),
//           //
//           //               SizedBox(width: 5.0,),
//           //
//           //               Expanded(
//           //                   flex: 8,
//           //                   child: SizedBox(
//           //                     height: 90,
//           //                     child: Padding(
//           //                       padding: const EdgeInsets.only(top: 20),
//           //                       child: TextField(
//           //                         controller: chatController,
//           //                         enabled: true,
//           //                         maxLines: 5,
//           //                         minLines: 1,
//           //                         onChanged: (val) {
//           //                           if (val.isNotEmpty) {
//           //                             data.updateUploadIcon(false);
//           //                           } else {
//           //                             data.updateUploadIcon(true);
//           //                           }
//           //                         },
//           //                         decoration: InputDecoration(
//           //                             contentPadding: EdgeInsets.only(
//           //                                 top: 5,
//           //                                 bottom: 5,
//           //                                 left: data.showUploadIcon ? 0 : 20,
//           //                                 right: data.showUploadIcon ? 0 : 20),
//           //                             hintText: "Type Something",
//           //                             enabledBorder: OutlineInputBorder(
//           //                                 borderRadius: BorderRadius.zero,
//           //                                 borderSide: BorderSide(
//           //                                     color: Colors.transparent)),
//           //                             focusedBorder: OutlineInputBorder(
//           //                                 borderRadius: BorderRadius.zero,
//           //                                 borderSide: BorderSide(
//           //                                     color: Colors.transparent)),
//           //                             hintStyle: TextStyle(
//           //                                 color: Color(0xff2A3C6A),
//           //                                 fontSize: 12)),
//           //                       ),
//           //                     ),
//           //                   )
//           //               ),
//           //               Expanded(
//           //                   flex: 2,
//           //                   child: Consumer<FirebaseChatProvider>(
//           //                       builder: (context, data, child) {
//           //                     return InkWell(
//           //                       onTap: () {
//           //
//           //                         // chatListController.jumpTo(chatListController.position.maxScrollExtent);
//           //                        var v1=chatController.text;
//           //                         chatController.clear();
//           //                        data.updateUploadIcon(true);
//           //                         // chatProvider.callSendMessage(chatController.text.toString(), 1).whenComplete(() {
//           //                         chatProvider.callSendMessage(v1.toString(), 1).whenComplete(() {
//           //
//           //
//           //                            // chatController.clear();
//           //                           // if(chatController.text.isEmpty){
//           //                           //   data.updateUploadIcon(true);
//           //                           // }
//           //                           // chatListController.jumpTo(chatListController.position.maxScrollExtent);
//           //
//           //                         });
//           //                       },
//           //                       child: Image.asset(
//           //                         AppImage.sendarrow,
//           //                         height: 22,
//           //                         width: 22,
//           //                       ),
//           //                     );
//           //                   })
//           //
//           //                   //   child:
//           //                   // InkWell(
//           //                   //     onTap: () {
//           //                   //       chatProvider
//           //                   //           .callSendMessage(
//           //                   //               chatController.text.toString(), 1)
//           //                   //           .whenComplete(() {
//           //                   //         context.read<FirebaseChatProvider>().updateUploadIcon(false);
//           //                   //         chatController.clear();
//           //                   //       });
//           //                   //     },
//           //                   //     child: Image.asset(
//           //                   //       AppImage.sendarrow,
//           //                   //       height: 22,
//           //                   //       width: 22,
//           //                   //     ),
//           //                   //   ),
//           //
//           //                   )
//           //             ],
//           //           );
//           //         }),
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         ));
//   }
//
//   Widget senderChatWidget(ChatModel chatModel) {
//     var user = HiveHandler.getUser();
//     var d = DateTime.fromMillisecondsSinceEpoch(chatModel.messageDate ?? 0);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         chatModel.messageType == 1
//             ? Container(
//                 width: 230,
//                 height: 66,
//                 margin: const EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: const DecorationImage(
//                       image: AssetImage(
//                         AppImage.chatbox,
//                       ),
//                       fit: BoxFit.cover),
//                 ),
//                 padding: const EdgeInsets.only(
//                     top: 15, left: 15, bottom: 15, right: 24.85),
//                 child: Text(chatModel.message ?? "",
//                     style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                         fontFamily: AppFont.poppinsLight)),
//               )
//             : SizedBox(
//                 height: 100,
//                 width: 100,
//                 child: CachedNetworkImage(
//                   imageUrl: chatModel.message ?? '',
//                   placeholder: (widget, child) => Center(
//                     child: SizedBox(
//                         height: 30,
//                         width: 30,
//                         child: const Center(
//                             child: CircularProgressIndicator.adaptive())),
//                   ),
//                 ),
//               ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 Jiffy(d).format("hh:mm"),
//                 style: const TextStyle(fontSize: 12, color: Color(0xff63697B)),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Image.asset(AppImage.photo),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget receiverChatWidget(ChatModel chatModel) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16, top: 21),
//       child: chatModel.messageType == 1
//           ? Container(
//               height: 36,
//               width: 190,
//               decoration: const BoxDecoration(
//                 color: Color(0xffF7F7F7),
//               ),
//               padding: const EdgeInsets.only(
//                   top: 8, left: 25, bottom: 15, right: 15),
//               child: Text(
//                 chatModel.message ?? "",
//                 style: const TextStyle(fontSize: 12, color: Color(0xff63697B)),
//               ),
//             )
//           : SizedBox(
//               height: 100,
//               width: 500,
//               child: CachedNetworkImage(
//                 imageUrl: chatModel.message ?? '',
//                 placeholder: (widget, child) => Center(
//                   child: SizedBox(
//                       height: 30,
//                       width: 30,
//                       child: const Center(
//                           child: CircularProgressIndicator.adaptive())),
//                 ),
//               ),
//             ),
//     );
//   }
// }
