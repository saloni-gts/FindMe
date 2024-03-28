import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/customTextFeild.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/components/weightContainer.dart';
import 'package:find_me/components/weightFeild.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/newRecord.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../components/bottomBorderComp.dart';
import '../../components/pushBackAppbar.dart';
import '../../generated/locale_keys.g.dart';
import '../../util/app_font.dart';
import '../provider/myProvider.dart';
import '../reUseClass/myappbar.dart';

class WeightTrkrMain extends StatefulWidget {
  const WeightTrkrMain({
    Key? key,
  }) : super(key: key);

  @override
  State<WeightTrkrMain> createState() => _WeightTrkrMainState();
}

class _WeightTrkrMainState extends State<WeightTrkrMain> {
  TextEditingController petWeightController = TextEditingController();
  TextEditingController healthWehtController = TextEditingController();

  final List<Color> gradientColors = [
    AppColor.textRed.withOpacity(0.5),
    AppColor.textFieldGrey,
  ];

  //
  // int isUpdate=1;
  // int xCor = 0;
  // var v1 = 0.0;
  // var v2 = 0.0;

  int lstIndxxl = 0;

  int setIndexVal = 0;

  // List<FlSpot> graphData = [];
  // double x = 0;

  List<FlSpot> ConstGraphData = [];
  List<FlSpot> NoGraphData = [
    const FlSpot(0, 0),
  ];
  @override
  void initState() {
    Myprovider Pro = Provider.of(context, listen: false);
    PetProvider petProvider = Provider.of(context, listen: false);

    Pro.tapIndex = 0;
    double dt = 0;
    print("tapIndextapIndex ${Pro.tapIndex}");

    print("helth controler valsue==>> ${petProvider.petHealtweightCntrolr.text}");

    dt = double.parse(petProvider.petHealtweightCntrolr.text);
    print("value of dt===>>> $dt");

    ConstGraphData = [
      FlSpot(0, dt),
      FlSpot(1, dt),
      // FlSpot(2, dt),
    ];

    if (petProvider.healthyWghtValSet == "-1") {
      healthWehtController.text = tr(LocaleKeys.additionText_setHltyWgt);
    } else {
      healthWehtController.text = petProvider.healthyWghtValSet;
      print("healthWehtController.text${healthWehtController.text}");
    }

    print("value of isUpdate===>>> ${petProvider.isUpdate}");

    // petProvider.petHealtweightCntrolr.clear();

    healthWehtController.text = petProvider.petHealtweightCntrolr.text;

    print("initial weight====>> ${petProvider.weightPetWeight}");

    Pro.showGraph = 1;
    lstIndxxl = 0;

    petProvider.priorWeight ??= 0.0;

    petProvider.healthyWeight ??= 0.0;

    var v1 = Pro.weightOfPet.length;

    super.initState();
  }

  @override
  // void dispose() {
  //
  //   print("---------");
  //
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Myprovider Pro = Provider.of(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // bottomNavigationBar: BotttomBorder(context),
      body: Consumer<Myprovider>(
        builder: (context, Pro, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar:

                // custAppbarFrPop(
                //     tap2: () {
                //       PetProvider petProvider = Provider.of(context, listen: false);
                //       // print("value of ispop===>>${isPopB}");
                //
                //       petProvider.callGetWeight();
                //       // setSpotList();
                //       Pro.showGraph == 0 ? Pro.displayGraph(1) : Pro.displayGraph(0);
                //
                //       print("value of show graph=== ${Pro.showGraph}");
                //       // Navigator.push(context, MaterialPageRoute(builder: (context) => WeightGraph()));
                //     },
                //     titlename: tr(LocaleKeys.petProfile_weightTraker),
                //     isbackbutton: true,
                //
                //
                //     icon: true,
                //     seticon:
                //         Pro.showGraph == 0 ? AppImage.graphIcon : AppImage.listIcon,
                // ),

                CustomCurvedAppbar(
              title: tr(LocaleKeys.petProfile_weightTraker),
              isTitleCenter: true,
              showIcon: true,
              onTap1: () {
                PetProvider petProvider = Provider.of(context, listen: false);
                // print("value of ispop===>>${isPopB}");

                petProvider.callGetWeight();
                // setSpotList();
                Pro.showGraph == 0 ? Pro.displayGraph(1) : Pro.displayGraph(0);

                print("value of show graph=== ${Pro.showGraph}");
                // Navigator.push(context, MaterialPageRoute(builder: (context) => WeightGraph()));
              },
              icn: Pro.showGraph == 0
                  ? Image.asset(
                      AppImage.graphIcon,
                      color: Colors.white,
                    )
                  : Image.asset(
                      AppImage.listIcon,
                      color: Colors.white,
                    ),
            ),

            // MycustomAppbar(
            //   tap2: () {
            //     PetProvider petProvider = Provider.of(context, listen: false);
            //     // print("value of ispop===>>${isPopB}");

            //     petProvider.callGetWeight();
            //     // setSpotList();
            //     Pro.showGraph == 0 ? Pro.displayGraph(1) : Pro.displayGraph(0);

            //     print("value of show graph=== ${Pro.showGraph}");
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) => WeightGraph()));
            //   },
            //   titlename: tr(LocaleKeys.petProfile_weightTraker),
            //   isbackbutton: true,

            //   icon: true,
            //   seticon:
            //       Pro.showGraph == 0 ? AppImage.graphIcon : AppImage.listIcon,
            // ),
            body: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.80,
                minChildSize: 0.76,
                maxChildSize: 0.9,
                builder: (BuildContext context, ScrollController scrollController) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Consumer<PetProvider>(builder: (context, petProvider, child) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 25.0,
                              ),
                              Consumer2<Myprovider, PetProvider>(builder: (context, Pro, petProvider, child) {
                                return Pro.showGraph == 0
                                    ? SizedBox(
                                        height: 265,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: petProvider.weightList.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    tr(LocaleKeys.additionText_noNtreFnd),
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        color: AppColor.buttonPink,
                                                        fontFamily: AppFont.poppinSemibold),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: petProvider.weightList.length,
                                                  // Pro.weightOfPet.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(top: 12.0),
                                                      child: InkWell(
                                                          onTap: () {
                                                            setIndexVal = index;

                                                            petProvider
                                                                .showContBorder(petProvider.weightList[index].id ?? 0);

                                                            print("index of the weight list=== $index");

                                                            // if(petProvider.weightList.)

                                                            lstIndxxl = index;

                                                            petProvider
                                                                .setSelectedWeight(petProvider.weightList[index]);
                                                            petProvider.petweightCntrolr.text =
                                                                petProvider.selectedWeight?.description ?? "";
                                                            petWeightController.text =
                                                                petProvider.selectedWeight?.description ?? "";
                                                            print("weight healthy===>>> ${healthWehtController.text}");

                                                            petProvider.setChangeWeight(
                                                                petProvider.weightList[index],
                                                                index,
                                                                double.parse(petProvider.petHealtweightCntrolr.text));
                                                          },
                                                          child: Stack(
                                                            children: [
                                                              // WeightFeild(context, petProvider.weightList[index].weight ?? 0,
                                                              //     petProvider.weightList[index].date.toString(), index,
                                                              //     petProvider.weightList[index].id ?? 0),

                                                              petProvider.weightList[index].id ==
                                                                      petProvider.selectedWeightCont
                                                                  ? Center(
                                                                      child: Container(
                                                                        height: 60,
                                                                        width: MediaQuery.of(context).size.width * .95,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(36),
                                                                          border: Border.all(
                                                                              color: AppColor.textLightBlueBlack),
                                                                          color: AppColor.textLightBlueBlack,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),

                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 2.0, top: 2),
                                                                child: Center(
                                                                  child: WeightFeild(
                                                                      context,
                                                                      petProvider.weightList[index].weight ?? 0,
                                                                      petProvider.weightList[index].date.toString(),
                                                                      index,
                                                                      petProvider.weightList[index].id ?? 0),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    );
                                                  }),
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child:
                                                  // petProvider.weightList.isNotEmpty ?
                                                  Text(
                                            petProvider.weightPetDate,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: AppFont.poppinsRegular, fontSize: 14, color: Colors.black),
                                          )
                                              // : SizedBox()
                                              ),
                                          Center(
                                            child: petProvider.weightList.isNotEmpty
                                                ? Text(
                                                    "${(petProvider.weightPetWeight).toString()} ${"Kg"}",
                                                    style: const TextStyle(
                                                        fontFamily: AppFont.poppinsBold,
                                                        fontSize: 45,
                                                        color: AppColor.textLightBlueBlack),
                                                  )
                                                : const Center(
                                                    child: Text(
                                                      "0.0Kg",
                                                      style: TextStyle(
                                                          fontFamily: AppFont.poppinsBold,
                                                          fontSize: 45,
                                                          color: AppColor.buttonPink),
                                                    ),
                                                  ),
                                          ),
                                          petProvider.weightList.isEmpty
                                              ? Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.99,
                                                      // color:Colors.amber,
                                                      child: Image.asset(AppImage.graph)),
                                                )
                                              : Consumer<PetProvider>(builder: (context, petProvider, child) {
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                                    child: SizedBox(
                                                        height: 180,
                                                        // width: MediaQuery.of(context).size.width*.9,
                                                        child: Consumer<PetProvider>(
                                                            builder: (context, petProvider, child) {
                                                          return LineChart(LineChartData(
                                                              borderData: FlBorderData(show: false),
                                                              lineTouchData: LineTouchData(
                                                                  getTouchedSpotIndicator: (LineChartBarData barData,
                                                                      List<int> spotIndexes) {
                                                                    return spotIndexes.map((spotIndex) {
                                                                      FlSpot spot = barData.spots[spotIndex];
                                                                      print("sport index $spotIndex");
                                                                      print("**************");
                                                                      Pro.updateTapIndex(spotIndex);

                                                                      lstIndxxl = spotIndex;

                                                                      setIndexVal = spotIndex;

                                                                      // petProvider.setSelectedWeight(petProvider.weightList[spotIndex]);

                                                                      print(
                                                                          "heathyyyyyy weight===>>> ${petProvider.petHealtweightCntrolr.text}");
                                                                      petProvider.isCheckNext(
                                                                          petProvider.weightList[spotIndex],
                                                                          spotIndex,
                                                                          double.parse(
                                                                              petProvider.petHealtweightCntrolr.text));
                                                                      // petProvider.isCheckNext(petProvider.weightList[spotIndex],spotIndex,double.parse(healthWehtController.text));

                                                                      // petWeightController.text=petProvider.we;
                                                                      // petWeightController.text=petProvider.petweightCntrolr.text;

                                                                      print("------******------*******-------******");
                                                                    }).toList();
                                                                  },
                                                                  touchTooltipData: LineTouchTooltipData(
                                                                    getTooltipItems: (value) {
                                                                      // print("${AppStrings.value} ${value.first}");
                                                                      return value.map((e) {
                                                                        Pro.updateItem(e.y.toStringAsFixed(2));

                                                                        //
                                                                        // return LineTooltipItem(
                                                                        //   "${"Weight : "} ${e.y.toStringAsFixed(2)} ",
                                                                        //   TextStyle(
                                                                        //       color: Colors.transparent
                                                                        //   ),
                                                                        // );
                                                                        //
                                                                      }).toList();
                                                                    },
                                                                    tooltipBgColor: Colors.transparent,
                                                                  )),
                                                              gridData: FlGridData(
                                                                  drawHorizontalLine: false, drawVerticalLine: false),
                                                              titlesData: FlTitlesData(
                                                                bottomTitles: AxisTitles(
                                                                    sideTitles: SideTitles(showTitles: false)),
                                                                leftTitles: AxisTitles(
                                                                    sideTitles: SideTitles(showTitles: false)),
                                                                rightTitles: AxisTitles(
                                                                    sideTitles: SideTitles(showTitles: false)),
                                                                topTitles: AxisTitles(
                                                                    sideTitles: SideTitles(showTitles: false)),
                                                              ),
                                                              lineBarsData: [
                                                                LineChartBarData(
                                                                    show: true,
                                                                    isCurved: false,
                                                                    color: AppColor.newBlueGrey,
                                                                    barWidth: 5,
                                                                    dotData: FlDotData(
                                                                        show: true,
                                                                        getDotPainter: (spot, percent, barData, index) {
                                                                          print("index $index");
                                                                          Color color = Colors.transparent;
                                                                          if (Pro.tapIndex == index) {
                                                                            // color = AppColor.textRed;
                                                                            color = AppColor.textLightBlueBlack;
                                                                          } else {
                                                                            // color = Colors.transparent;
                                                                            // color=AppColor.textLightBlueBlack;
                                                                            color = AppColor.textRed;
                                                                          }

                                                                          return FlDotCirclePainter(
                                                                              radius: 10,
                                                                              strokeColor: Colors.transparent,
                                                                              color: color);
                                                                        }),
                                                                    belowBarData: BarAreaData(
                                                                        show: true,
                                                                        gradient: LinearGradient(
                                                                            begin: Alignment.topCenter,
                                                                            end: Alignment.bottomCenter,
                                                                            colors: gradientColors)),
                                                                    spots: petProvider.graphSpotData),
                                                                petProvider.weightList.length > 1
                                                                    ? LineChartBarData(
                                                                        color: AppColor.newBlueGrey,
                                                                        barWidth: 2,
                                                                        spots: petProvider.healthyGraphData,
                                                                        dotData: FlDotData(show: false))
                                                                    : LineChartBarData(
                                                                        color: Colors.transparent,
                                                                        barWidth: 1,
                                                                        spots: petProvider.healthyGraphData),
                                                              ]));
                                                        })),
                                                  );
                                                })
                                        ],
                                      );
                              }),
                              const SizedBox(
                                height: 35.0,
                              ),

                              petProvider.weightList.isNotEmpty
                                  ? Text(
                                      tr(LocaleKeys.additionText_decsPetWgt),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColor.newBlueGrey,
                                          fontFamily: AppFont.poppinsRegular),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 7.0,
                              ),

                              Consumer<PetProvider>(builder: (context, petProvider, child) {
                                return Consumer<PetProvider>(builder: (context, petProvider, child) {
                                  return CustomTextFeild(
                                      hintText: tr(LocaleKeys.additionText_noWghtNtrFnd),
                                      isEnabled: false,
                                      textController: petProvider.petweightCntrolr,
                                      // petWeightController,
                                      textInputType: TextInputType.text);
                                });
                              }),

                              const SizedBox(
                                height: 20.0,
                              ),
                              Consumer<PetProvider>(builder: (context, petProvider, child) {
                                return Row(
                                  children: [
                                    WeightContainer(
                                        context,
                                        "${petProvider.priorWeight}"
                                        "${tr(LocaleKeys.additionText_kg)}",
                                        tr(LocaleKeys.additionText_sincPrior)),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    WeightContainer(
                                        context,
                                        "${petProvider.healthyWeight}"
                                        "${tr(LocaleKeys.additionText_kg)}",
                                        tr(LocaleKeys.additionText_frmHltyWgt)),
                                  ],
                                );
                              }),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                tr(LocaleKeys.additionText_hlthyWgt),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12.0, color: AppColor.newBlueGrey, fontFamily: AppFont.poppinsRegular),
                              ),
                              const SizedBox(
                                height: 7.0,
                              ),

                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28.0),
                                    color: AppColor.textFieldGrey,
                                    border: Border.all(color: Colors.transparent)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                  child: Row(
                                    children: [
                                      Consumer<PetProvider>(builder: (context, petProvider, child) {
                                        return SizedBox(
                                          width: 200,
                                          // color: Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              showCursor: true,
                                              maxLength: 4,
                                              controller:
                                                  // healthWehtController,
                                                  petProvider.petHealtweightCntrolr,
                                              //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                              autofocus: false,
                                              scrollPadding: const EdgeInsets.all(20.0),
                                              style: const TextStyle(
                                                color: AppColor.textLightBlueBlack,
                                                fontFamily: AppFont.poppinsMedium,
                                                fontSize: 18.0,
                                              ),
                                              decoration: InputDecoration(
                                                counterText: "",
                                                hintText: tr(LocaleKeys.additionText_setHltyWgt),
                                                hintStyle: const TextStyle(
                                                  color: AppColor.textGreyColor,
                                                  fontFamily: AppFont.poppinsMedium,
                                                  fontSize: 15.0,
                                                ),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          print("value of cntroler=>${petProvider.petHealtweightCntrolr.text}");

                                          if (petProvider.petHealtweightCntrolr.text.isNotEmpty) {
                                            petProvider.callEditHealthyPetWeight(
                                                context: context,
                                                healthyWeight: petProvider.petHealtweightCntrolr.text,
                                                isUpdateeee: petProvider.isUpdate);

                                            print("value of set indexx===> >$setIndexVal");

                                            // petProvider.callGetWeight();
                                            petProvider.setHealthyWeightLine();
                                            petProvider.setChangeWeight(petProvider.weightList[setIndexVal],
                                                setIndexVal, double.parse(petProvider.petHealtweightCntrolr.text));

                                            petProvider.isCheckNext(petProvider.weightList[setIndexVal], setIndexVal,
                                                double.parse(petProvider.petHealtweightCntrolr.text));

                                            // EasyLoading.showToast("Success",
                                            //     toastPosition: EasyLoadingToastPosition.center);

                                            // Navigator.pop(context);
                                          }

                                          if (petProvider.petHealtweightCntrolr.text == "0" ||
                                              petProvider.petHealtweightCntrolr.text == "0.0" ||
                                              petProvider.petHealtweightCntrolr.text == "0.00" ||
                                              petProvider.petHealtweightCntrolr.text == "0000" ||
                                              petProvider.petHealtweightCntrolr.text == "00.0" ||
                                              petProvider.petHealtweightCntrolr.text == "00" ||
                                              petProvider.petHealtweightCntrolr.text == "000") {
                                            CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.error,
                                                text: tr(LocaleKeys.additionText_plsNtrVldWght));
                                          }

                                          print("print==== value of isUpload====> ${petProvider.isUpdate}");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(28.0),
                                              color: petProvider.petHealtweightCntrolr.text == "0.0" &&
                                                      petProvider.petHealtweightCntrolr.text.isEmpty
                                                  ? const Color(0xff2A3C6A).withOpacity(0.5)
                                                  : AppColor.buttonPink,
                                            ),
                                            width: 70,
                                            child: Center(
                                              child: Text(
                                                  petProvider.showSaveButon == 1
                                                      ? tr(LocaleKeys.additionText_capSave)
                                                      : tr(LocaleKeys.additionText_capUpdte),
                                                  style: const TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 7.0,
                              ),

                              const Text("   ", style: TextStyle(color: Colors.white)),

                              const Text("   ", style: TextStyle(color: Colors.white)),

                              ///**************************
//
//                                 CustomTextFeild(
//                                     hintText: AppStrings.setHltyWgt,
//                                     textController: healthWehtController,
//                                     textInputType: TextInputType.number),

                              // Padding(
                              //   padding: const EdgeInsets.only(top: 4.0,right: 5.0),
                              //   child: Consumer<PetProvider>(
                              //     builder: (context,petProvider,child) {
                              //       return Row(
                              //         mainAxisAlignment: MainAxisAlignment.end,
                              //         children: [
                              //
                              //           InkWell(
                              //
                              //               child: Text("Save"),
                              //             onTap: (){
                              //
                              //
                              //               // petProvider.healthyWeight=healthWehtController;
                              //               petProvider.petHealtweightCntrolr.text=healthWehtController.text;
                              //
                              //
                              //
                              //             },
                              //           ),
                              //
                              //           SizedBox(width: 10.0,),
                              //           InkWell(child: Text("Update"),
                              //             onTap: (){
                              //               petProvider.petHealtweightCntrolr.text=healthWehtController.text;
                              //             },
                              //
                              //
                              //           )
                              //
                              //
                              //
                              //         ],
                              //       );
                              //     }
                              //   ),
                              // )

                              // Consumer<PetProvider>(
                              //     builder: (context, petProvider, child) {
                              //   return Container(
                              //     height: 50,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(28.0),
                              //         color: AppColor.textFieldGrey,
                              //         border:
                              //             Border.all(color: Colors.transparent)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(
                              //           left: 12.0, right: 12.0),
                              //       child: TextField(
                              //         keyboardType: TextInputType.number,
                              //         maxLength: 4,
                              //         controller:
                              //             petProvider.petHealtweightCntrolr,
                              //         //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              //         autofocus: false,
                              //         scrollPadding: EdgeInsets.all(20.0),
                              //         style: TextStyle(
                              //           color: AppColor.textLightBlueBlack,
                              //           fontFamily: AppFont.poppinsMedium,
                              //           fontSize: 18.0,
                              //         ),
                              //         decoration: InputDecoration(
                              //           counterText: "",
                              //           hintStyle: TextStyle(
                              //             color: AppColor.textGreyColor,
                              //             fontFamily: AppFont.poppinsMedium,
                              //             fontSize: 15.0,
                              //           ),
                              //
                              //           border: InputBorder.none,
                              //           focusedBorder: InputBorder.none,
                              //         ),
                              //       ),
                              //     ),
                              //   );
                              // }),

                              const SizedBox(
                                height: 40.0,
                                child: Text(""),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                }),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 30),
        child: CustomButton(
            // context: context,
            text: tr(LocaleKeys.additionText_addNewRecCap),
            // tr(LocaleKeys.additionText_addNewRec),
            // colour: AppColor.newBlueGrey,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewRecord()));
            }),
      ),
    );
  }
}
