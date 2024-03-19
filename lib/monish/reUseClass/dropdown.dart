// import 'package:flutter/material.dart';
// import 'package:unique_tags/util/color.dart';
//
// class myCustomDropDown<T> extends StatelessWidget {
//   myCustomDropDown({
//     Key? key,
//     required this.onChange,
//     required this.value,
//     required this.itemList,
//     required this.title,
//     this.mandatoryField = false,
//     required this.isEnable,
//     this.selectText = "Select",
//     this.isGrey = true,
//     this.color,
//     this.selecttextcolor,
//     this.fontfamily,
//     this.width,
//   }) : super(key: key);
//   final Function(T value) onChange;
//   final T? value;
//   final List<T> itemList;
//   final String title;
//   final bool mandatoryField;
//   final bool isEnable;
//   bool isGrey;
//   String selectText;
//   final color;
//   final selecttextcolor;
//   final fontfamily;
//   final width;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           margin: const EdgeInsets.only(top: 16),
//           decoration: BoxDecoration(
//               boxShadow: const [
//                 BoxSh
//
//
//        adow(color: Colors.black26, offset: Offset(0, 0))
//               ],
//               color: AppColor.textFieldGrey,
//               borderRadius: BorderRadius.circular(28)),
//           height: 56,
//           width: width,
//           child: Center(
//             child: DropdownButton<T>(
//               focusColor: AppColor.textFieldGrey,
//               value: value,
//               //elevation: 5,
//               style: const TextStyle(color: Colors.white),
//               items: itemList.map<DropdownMenuItem<T>>((T value) {
//                 return DropdownMenuItem<T>(
//                   value: value,
//                   child: Text(
//                     (value as DropDownModel).getOptionName()!,
//                     style: TextStyle(
//                         color: color,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 );
//               }).toList(),
//               isExpanded: true,
//               underline: const SizedBox(),
//               hint: Text(
//                 selectText,
//                 style: TextStyle(
//                     color: selecttextcolor,
//                     fontSize: 15,
//                     fontFamily: fontfamily),
//               ),
//               dropdownColor: Colors.white,
//
//               onChanged: !isEnable
//                   ? null
//                   : (T? value) {
//                       // setState(() {
//                       onChange(value!);
//
//                       // });
//                     },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class DropDownModel {
//   String? getOptionName() {}
// }
//
// class PetTypeModl implements DropDownModel {
//   late final String title;
//   late final String typeId;
//
//   PetTypeModl({
//     required this.title,
//     required this.typeId,
//   });
//
//   @override
//   String? getOptionName() {
//     return title;
//   }
// }
