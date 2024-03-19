// import 'package:flutter/material.dart';
//
// class LoadingScreen {
//   LoadingScreen._sharedInstance();
//   static final LoadingScreen _shared = LoadingScreen._sharedInstance();
//   factory LoadingScreen.instance() => _shared;
//
//   // LoadingScreenController? controller;
//
//   void show({
//     required BuildContext context,
//     String text = "Loading",
//   })
//   {
//     if (controller?.update(text) ?? false) {
//       return;
//     } else {
//       controller = showOverlay(
//         context: context,
//         text: text,
//       );
//     }
//   }
//
//   void hide() {
//     controller?.close();
//     controller = null;
//   }
//
//   LoadingScreenController? showOverlay({
//     required BuildContext context,
//     required String text,
//   }) {
//     final textController = StreamController<String>();
//     textController.add(text);
//
//     final state = Overlay.of(context);
//     if (state == null) {
//       return null;
//     }
//     // final renderBox = context.findRenderObject() as RenderBox;
//
//     final overlay = OverlayEntry(
//       builder: (context) {
//         return Material(
//           color: Colors.black.withAlpha(150),
//           child: Center(
//             child: Container(
//               height: 100,
//               width: 100,
//               constraints: const BoxConstraints(),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 10),
//                       const CircularProgressIndicator.adaptive(),
//                       const SizedBox(height: 20),
//                       StreamBuilder(
//                         stream: textController.stream,
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             return Text(
//                               snapshot.data as String,
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium
//                                   ?.copyWith(color: Colors.black),
//                             );
//                           } else {
//                             return Container();
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//
//     state.insert(overlay);
//
//     return LoadingScreenController(
//       close: () {
//         textController.close();
//         overlay.remove();
//         return true;
//       },
//       update: (text) {
//         textController.add(text);
//         return true;
//       },
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
