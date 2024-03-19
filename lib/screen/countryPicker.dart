// import 'package:flutter/material.dart';
// import 'package:country_picker/country_picker.dart';
//
// class CountryPicker extends StatefulWidget {
//   const CountryPicker({Key? key}) : super(key: key);
//
//   @override
//   State<CountryPicker> createState() => _CountryPickerState();
// }
//
// class _CountryPickerState extends State<CountryPicker> {
//   String CountryCode = "";
//   String PhoneCode = "";
//   String flag = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("country picker"),
//         ),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 15.0,
//             ),
//             Container(
//               height: 40,
//               width: 250,
//               decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(10.0)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(flag, style: TextStyle(fontSize: 20.0)),
//                   ),
//
//                   TextButton(
//                     onPressed: () {
//                       showCountryPicker(
//                           context: context,
//                           onSelect: (Country cntry) {
//                             print("==========${cntry.countryCode}");
//                             print("======${cntry.phoneCode}");
//                             print(cntry.flagEmoji);
//                             CountryCode = cntry.countryCode.toString();
//                             PhoneCode = cntry.phoneCode.toString();
//                             flag = cntry.flagEmoji.toString();
//                             setState(() {});
//                           });
//                     },
//                     child: Text(PhoneCode, style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0)),
//                   )
//                 ],
//               ),
//             )z
//           ],
//         )));
//   }
// }
