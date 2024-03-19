// import 'dart:io';
//
// import 'package:cool_alert/cool_alert.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
//
//
// import 'package:http/http.dart' as http;
// import 'package:unique_tags/api/network_calls.dart';
//
//
//
// class LocationDailog extends StatefulWidget {
//
//
//   LocationDailog({
//
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<LocationDailog> createState() => _LocationDailogState();
// }
//
// class _LocationDailogState extends State<LocationDailog> {
//
//
// Position? pos;
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//
//
//   @override
//   void initState() {
//
//
//     super.initState();
//     getLoc();
//
//   }
//
//
// getLoc() async {
//    posti= await _determinePosition();
// }
//
//    Position? posti;
//   @override
//   Widget build(BuildContext context) {
//
//
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Current Location',
//             style: TextStyle(fontSize: 20),
//           ),
//
//
//           SizedBox(
//             height: 20,
//           ),
//
//
//           Center(
//               child: Column(
//                 children: [
//
//                   Text("Latitude : ${posti?.latitude}"),
//                   SizedBox(height: 10,),
//                   Text("Longitude : ${posti?.longitude}"),
//
//                 ],
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }