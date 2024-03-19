import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';

//
// class  extends StatefulWidget {
//   const ({Key? key}) : super(key: key);
//
//   @override
//   State<> createState() => _State();
// }
//
// class _State extends State<> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

Widget BotttomBorder(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0, left: 30, right: 30),
    child: Container(
      height: 10,
      width: double.infinity,
      color: const Color(0xffCBC4A9),

      //  color: Colors.white,

      //  width: MediaQuery.of(context).size.width,
      //  child: Padding(
      //    padding: const EdgeInsets.only(bottom: 10,top: 10),
      //    child: Image.asset(
      //      AppImage.topBorder,
      //      fit: BoxFit.cover,
      //    ),
      //  ),
    ),
  );
}
