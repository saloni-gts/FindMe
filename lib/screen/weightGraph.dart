// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:unique_tags/components/appbarComp.dart';
// import 'package:unique_tags/components/bottomBorderComp.dart';
// import 'package:unique_tags/components/customBlueButton.dart';
// import 'package:unique_tags/components/customTextFeild.dart';
// import 'package:unique_tags/monish/reUseClass/myappbar.dart';
// import 'package:unique_tags/monish/screen/weightTrakrMain.dart';
// import 'package:unique_tags/screen/newRecord.dart';
// import 'package:unique_tags/util/app_images.dart';
// import 'package:unique_tags/util/color.dart';
//
// import '../components/weightContainer.dart';
// import '../util/app_font.dart';
//
// class WeightGraph extends StatefulWidget {
//   const WeightGraph({Key? key}) : super(key: key);
//
//   @override
//   State<WeightGraph> createState() => _WeightGraphState();
// }
//
// class _WeightGraphState extends State<WeightGraph> {
//   TextEditingController descWeight = new TextEditingController();
//   TextEditingController healthyWeight = new TextEditingController();
//
//
//   List<FlSpot> graphPoints=[];
//
//   final List<Color> gradientColors = [
//     AppColor.textRed.withOpacity(0.5),
//     AppColor.textFieldGrey,
//
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         bottomNavigationBar: BotttomBorder(context),
//         appBar: MycustomAppbar(
//
//           tap2: () {
//
//             print("icon tapppp");
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => WeightTrkrMain()));
//           },
//           titlename: "Weight Graph",
//           isbackbutton: true,
//           seticon: AppImage.listIcon,
//           icon: true,
//         ),
//         body: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 30.0,
//                   ),
//                   Center(
//                     child: Text(
//                       "16-Feb-2021",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: AppFont.poppinsRegular,
//                           fontSize: 14,
//                           color: Colors.black),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       "17.0kg",
//                       style: TextStyle(
//                           fontFamily: AppFont.poppinsBold,
//                           fontSize: 45,
//                           color: AppColor.textLightBlueBlack),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child:
//
//                     Container(
//                         height: 200,
//                         // width: MediaQuery.of(context).size.width*.9,
//                         child: LineChart(LineChartData(
//
//                             lineTouchData: LineTouchData(
//
//                                 touchTooltipData: LineTouchTooltipData(
//
//                               getTooltipItems: (value) {
//                                 return value
//                                     .map((e) => LineTooltipItem(
//
//                                         "${"Weight : "} ${e.y.toStringAsFixed(2)} ",
//                                         TextStyle(color: AppColor.textRed)
//                                     ,
//                                 )
//                                 )
//                                     .toList();
//
//                               },
//                               tooltipBgColor: Colors.black,
//                             )),
//
//
//
//                             gridData: FlGridData(
//                                 drawHorizontalLine: false,
//                                 drawVerticalLine: false
//                             ),
//                             borderData: FlBorderData(show: false),
//                             titlesData: FlTitlesData(
//                               bottomTitles: AxisTitles(
//                                   sideTitles: SideTitles(showTitles: false)),
//                               leftTitles: AxisTitles(
//                                   sideTitles: SideTitles(showTitles: false)),
//                               rightTitles: AxisTitles(
//                                   sideTitles: SideTitles(showTitles: false)),
//                               topTitles: AxisTitles(
//                                   sideTitles: SideTitles(showTitles: false)),
//                             ),
//                             lineBarsData: [
//                               LineChartBarData(
//                                   isCurved: true,
//                                   color: AppColor.textRed,
//                                   barWidth: 5,
//                                   dotData: FlDotData(
//                                   // checkToShowDot: true,
//                                   //   getDotPainter: ,
//
//                                       show: true
//                                   ),
//                                   belowBarData: BarAreaData(
//                                       show: true,
//                                       gradient: LinearGradient(
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                           colors: gradientColors)
//                                       // LinearGradient(
//                                       //   colors: gradientColors
//                                       // ),
//                                       //
//                                       //
//
//                                       ),
//                                   spots:
//                                   [
//                                     const FlSpot(0, 0),
//                                     const FlSpot(1, 15),
//                                     const FlSpot(2, 10),
//                                     const FlSpot(3, 20),
//                                     const FlSpot(4, 12),
//                                     const FlSpot(5, 13),
//                                     const FlSpot(6, 17),
//                                     const FlSpot(7, 15),
//                                     const FlSpot(8, 25.55),
//                                   ]
//
//                               )
//                             ]
//                         )
//                         )
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30.0,
//                   ),
//                   Text(
//                     "Describe what affects a pet's weight",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                         fontSize: 12.0,
//                         color: AppColor.textLightBlueBlack,
//                         fontFamily: AppFont.poppinsRegular),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   CustomTextFeild(
//                     textController: descWeight,
//                     hintText: "Good",
//                     textInputType: TextInputType.text,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Row(
//                     children: [
//                       WeightContainer(
//                           context, "+0.5Kg", "Since the prior weighing"),
//                       SizedBox(
//                         width: 15.0,
//                       ),
//                       WeightContainer(
//                           context, "0.0Kg", "from the healthy weight"),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Healthy weight",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                         fontSize: 12.0,
//                         color: AppColor.textLightBlueBlack,
//                         fontFamily: AppFont.poppinsRegular),
//                   ),
//                   SizedBox(
//                     height: 7.0,
//                   ),
//                   CustomTextFeild(
//                       hintText: "Set the healthy weight",
//                       textController: healthyWeight,
//                       textInputType: TextInputType.text),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   customBlueButton(
//                       context: context,
//                       text1: "ADD A NEW RECORD",
//                       onTap1: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewRecord()));
//                       },
//                       colour: AppColor.textLightBlueBlack)
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
