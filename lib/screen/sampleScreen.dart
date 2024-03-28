import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/addPet.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/app_route.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../components/customTextFeild.dart';

import '../util/app_font.dart';

class ScannerScreen extends StatefulWidget {
  int? isNewTag;
  ScannerScreen({Key? key, required this.isNewTag}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  void initState() {
    widget.isNewTag == 1 ? print("*******new tag") : print("====***===== old tag0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: QRViewScreen(
          isShowNewTag: widget.isNewTag == 1 ? 1 : 0,
        ));
  }
}

// for flash on or off
//await controller?.toggleFlash();

class QRViewScreen extends StatefulWidget {
  int isShowNewTag;
  QRViewScreen({Key? key, required this.isShowNewTag}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> with SingleTickerProviderStateMixin {
  Barcode? result;
  bool scanned = false;
  bool scannedFailed = false;
  bool showScanner = true;
  int validTg = 0;
  QRViewController? controllerQR;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int petIdSelect = -1;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controllerQR!.resumeCamera();
      // controllerQR!.pauseCamera();
    }
    controllerQR?.resumeCamera();
  }

  final bool _animationStopped = false;
  String scanText = "Scan";
  bool scanning = false;
  //for web
  String? code;
  bool isOpenCamera = false;

  TextEditingController tagNumberController = TextEditingController();
  TextEditingController activationCodeController = TextEditingController();
  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);

    if (widget.isShowNewTag == 1) {
      print("*************------******");
      showScanner = true;
      print("===$showScanner");
      result = null;
      tagNumberController.clear();
      activationCodeController.clear();
    } else {
      tagNumberController.text = petProvider.selectedTag?.qrTagNumber ?? "";
      activationCodeController.text = petProvider.selectedTag?.qrActivationCode ?? "";
    }

    var petDetail = petProvider.selectedPetDetail;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PetProvider petProvider = Provider.of(context, listen: false);
    var petDetail = petProvider.selectedPetDetail;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: widget.isShowNewTag == 0
          // petDetail?.isQrAttached == 1
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(bottom: 40.0, left: 30),
              child: CustomButton(
                  text: activationCodeController.text.isEmpty
                      ? tr(LocaleKeys.additionText_activate)
                      : tr(LocaleKeys.additionText_activate),
                  onPressed: () {
                    if (petIdSelect == -1) {
                      EasyLoading.showToast("Select Pet To Continue ");
                    } else {
                      if (activationCodeController.text.isEmpty) {
                        print("feild is empty......");
                      } else {
                        Map<String, dynamic> bodyyy = {
                          "activationCode": activationCodeController.text,
                          "tagName": tagNumberController.text,
                          "petId": petProvider.selectedPetDetail?.id ?? "",
                        };
                        petProvider.qrCodeActivatinTag(bodyyy, context: context);
                      }
                    }
                  })

              // customBlueButton(
              //     context: context,
              //     text1: activationCodeController.text.isEmpty
              //         ? tr(LocaleKeys.additionText_activate)
              //         : tr(LocaleKeys.additionText_activate),
              //     onTap1: () {
              //       if (activationCodeController.text.isEmpty) {
              //         print("feild is empty......");
              //       } else {
              //         Map<String, dynamic> bodyyy = {
              //           "activationCode": activationCodeController.text,
              //           "tagName": tagNumberController.text,
              //           "petId": petProvider.selectedPetDetail?.id ?? "",
              //         };
              //         petProvider.qrCodeActivatinTag(bodyyy, context: context);
              //       }
              //     },
              //     colour: activationCodeController.text.isEmpty ? const Color(0xffAEB4C6) : AppColor.newBlueGrey

              //     ),
              ),
      resizeToAvoidBottomInset: false,
      appBar: CustomCurvedAppbar(
        title: tr(LocaleKeys.additionText_QrCode),
        isTitleCenter: true,
      ),
      // customAppbar(titlename: tr(LocaleKeys.additionText_QrCode)),
      backgroundColor: Colors.white,
      // bottomNavigationBar: BotttomBorder(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                // height: MediaQuery.of(context).size.height * .40,
                // width: MediaQuery.of(context).size.width * .85,
                child:
                    // petDetail?.isQrAttached == 1
                    widget.isShowNewTag == 0
                        ? SizedBox(
                            height: 250,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: (Image.asset(
                                  AppImage.findmeQR,
                                  fit: BoxFit.fitHeight,
                                ))))
                        : Center(child: (_buildQrView(context))),
                // Padding(
                //   padding: const EdgeInsets.only(top: 350),
                //   child: Align(
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Scan QR Code to start session",
                //         style: Theme.of(context)
                //             .textTheme
                //             .headline6
                //             ?.copyWith(color: Colors.white),
                //       )),
                // ),
                // Padding(
                //     padding: const EdgeInsets.only(top: 440),
                //     child: Consumer(
                //       builder: (context, value, child) {
                //         return true
                //             ? Align(
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   "Still searching for a valid QR Code",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .headline6
                //                       ?.copyWith(color: Colors.white),
                //                 ))
                //             : const SizedBox();
                //       },
                // //     )),
                // Padding(
                //   padding: const EdgeInsets.only(top: 280.0),
                //   child: buildResult(),
                // )
              ),
              buildResult(context),
              Text(
                tr(LocaleKeys.additionText_tagNumber),
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 12.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsRegular),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFeild(isEnabled: false, textInputType: TextInputType.none, textController: tagNumberController),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                tr(LocaleKeys.additionText_activationCode),
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 12.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsRegular),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFeild(
                  isEnabled: false,
                  //cursorColor: Colors.transparent,
                  textInputType: TextInputType.none,
                  textController: activationCodeController),
              const SizedBox(
                height: 20.0,
              ),
              petProvider.petDetailList.isEmpty
                  ? InkWell(
                      onTap: () {
                        petProvider.callPetPremDetailsAddPet();
                        // switchonNotification();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPet()));
                      },
                      child: const Text(
                        "Add Pet",
                        style: TextStyle(color: AppColor.buttonPink, fontFamily: AppFont.figTreeBold, fontSize: 15),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,

                          // barrierColor: Colors.amber,
                          builder: (context) {
                            return SelectPetBottomSheet();
                          },
                        );
                      },
                      child: Text(
                        petIdSelect != -1 ? "Pet Seleted" : "Select Pet",
                        style:
                            const TextStyle(color: AppColor.buttonPink, fontFamily: AppFont.figTreeBold, fontSize: 15),
                      ),
                    ),
              const SizedBox(
                height: 80.0,
              )
            ],
          ),
        ),
      ),

      // Positioned(
      //   bottom: 0.0,
      //   left: 18.0,
      //   child:
      // Center(
      //     child:(petDetail?.isQrAttached==1)?SizedBox() : customBlueButton(
      //         context: context,
      //         text1: AppStrings.buyNewQR,
      //         onTap1: () {
      //
      //           Map<String,dynamic> bodyyy={
      //
      //             "activationCode": activationCode.text,
      //             "tagName": tagNumber.text,
      //             "petId": petProvider.selectedPetDetail?.id??"",
      //
      //           };
      //           petProvider.qrCodeActivatinTag(bodyyy,  context: context);
      //        //   Navigator.pop(context);
      //
      //
      //         },
      //
      //         colour: AppColor.textLightBlueBlack)
      //
      // ),

      //    ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return showScanner
        ? SizedBox(
            height: 250,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: AppColor.textLightBlueBlack,
                  borderRadius: 10,
                  // borderLength: 120,
                  borderWidth: 10,
                  cutOutHeight: 200,
                  cutOutWidth: 200),
              // onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          )
        : Stack(
            children: [
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.grey.shade300),
                  height: 250,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        AppImage.findmeQR,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      scanned = false;
                      scannedFailed = false;
                      showScanner = true;
                      result = null;
                      tagNumberController.clear();
                      activationCodeController.clear();
                    });
                  },
                  child: activationCodeController.text.isEmpty
                      ? Center(
                          child: Text(
                          tr(LocaleKeys.additionText_scanAgain),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColor.buttonPink,
                              fontFamily: AppFont.poppinSemibold,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ))
                      : const SizedBox())
            ],
          );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      controllerQR = controller;
      reassemble();
    });

    controller.scannedDataStream.listen((Barcode scanData) {
      Future.delayed(Duration.zero, () {
        setState(() {
          result = scanData;
          if (result != null && !scanned && scanData.code != null) {
            int lengths = result?.code?.length ?? 0;
            showScanner = false;

            scanned = true;

            print(">>>>>>>>> scan >>>>>>> 1");
          } else {}
          print("here");
        });
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Please enable camera permissions"
                    ""),
                actions: <Widget>[
                  InkWell(
                    child: const Text(
                      "Dismiss",
                      style: TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppScreen.petDashboard);
                    },
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    child: const Text(
                      "Allow",
                      style: TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                    ),
                    onTap: () {
                      AppSettings.openAppSettings();
                      Future.delayed(const Duration(milliseconds: 500), () => exit(0));
                      Navigator.pushNamed(context, AppScreen.petDashboard);
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ));

      // camPermissionDialog(context);
      // Navigator.pop(context1);
      // Navigator.pushNamed(context, AppScreen.petDashboard);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
      // ScaffoldMessenger.of(context).showSnackBar(
      //    SnackBar(content: Text('no Permission')
      //   ),
      // );
    }
  }

  // showAlert(BuildContext context, String invalid) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("AppStrings.ticketStatus"),
  //       content: Text("$invalid"),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 scanned = false;
  //               });
  //               Navigator.pop(context);
  //             },
  //             child: Text("AppStrings.close"))
  //       ],
  //     ),

  //   );
  // }

  @override
  void dispose() {
    tagNumberController.clear();
    activationCodeController.clear();
    controllerQR?.dispose();
    // _animationController!.dispose();
    super.dispose();
  }

  Widget buildResult(BuildContext context) {
    if (result != null) {
      print("result  ${result?.code ?? ""}");
      print("resultlength  ${result?.code?.split("/")}");
      int length = result?.code?.split("/").length ?? 0;
      if (length > 4) {
        var staging = "u.find-me.app";
        var prod = "dashboardstage.find-me.app";
        // var prod = "u-tags.uk/pet/:tagNumber";
        //    https://dashboardstage.find-me.app/INGT000007/NXB1
        //https://find-me.uk/pet/INGT000001/WKF7
        if (result?.code?.split("/")[2] == staging && result?.code?.split("/")[3] == "pet") {
          print("result  ${result?.code ?? ""}");
          print("resultlength  ${result?.code?.split("/")}");
          tagNumberController.text = result?.code?.split("/")[4] ?? "";
          activationCodeController.text = result?.code?.split("/")[5] ?? "";

          if (tagNumberController.text.isEmpty || activationCodeController.text.isEmpty) {
            setState(() {
              showScanner = true;
            });
          } else {
            Future.delayed(Duration.zero, () {
              setState(() {
                showScanner = false;
              });
            });
          }

          // controllerQR?.dispose();
          //  _animationController!.dispose();
        } else {
          // showDialog(context: GlobalVariable.navState.currentContext!, builder: (context){
          //   return  AlertDialog(
          //     title: Center(child: const Text('WARNING:')),
          //     content:Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Center(
          //             child:
          //             Text("Wrong QR Code ...\n Click on try again and start scaning",
          //               textAlign: TextAlign.center,)),],),
          //     actions: [
          //       ElevatedButton(
          //         onPressed: () {
          //           Navigator.pop(GlobalVariable.navState.currentContext!);
          //           setState((){
          //             showScanner=true;
          //             // _buildQrView;
          //             // Navigator.of(context).pop();
          //           });
          //
          //         },
          //         child: const Text('TRY AGAIN!'),
          //       ),
          //
          //     ],
          //   );
          // });
        }
      }
    } else {
      // showDialog(context: GlobalVariable.navState.currentContext!, builder: (context){
      //   return  AlertDialog(
      //     title: Center(child: const Text('WARNING:')),
      //     content:Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Center(
      //             child:
      //             Text("Wrong QR Code ...\n Click on try again and start scaning",
      //               textAlign: TextAlign.center,)),],),
      //     actions: [
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.pop(GlobalVariable.navState.currentContext!);
      //           setState((){
      //             showScanner=true;
      //             // _buildQrView;
      //             // Navigator.of(context).pop();
      //           });
      //
      //         },
      //         child: const Text('TRY AGAIN!'),
      //       ),
      //
      //     ],
      //   );
      // });
    }
    //
    //  if(result!=null){
    //   if(result?.code?.split("/")[2]=="gtsinfosoft.com"){
    //     print("result  ${result?.code??""}");
    //     print("resultlength  ${result?.code?.split("/")[2]}");
    //     print("TESTT 1 ${result?.code?.split("/").last.split("?").first}");
    //     print("TESTT 2 ${result?.code?.split("/").last.split("?").last}");
    //     tagNumber.text=result?.code?.split("/")?.last?.split("?")?.first??"";
    //     activationCode.text=result?.code?.split("/")?.last?.split("?")?.last??"";
    //     controllerQR?.dispose();
    //     _animationController!.dispose();
    //   }else{
    //     return AlertDialog(
    //       title: const Text('WRONG QR CODE:'),
    //       actions: [
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('TRY AGAIN!'),
    //         ),
    //
    //       ],
    //     );
    //   }
    //
    // }
    return Container(
      child: const Text(

        
        "",
        // result != null ? 'result :${result!.code}' : "",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.green),
      ),
    );
  }

  getSubstring(Barcode? str) {
    String str1 = str.toString();
    print("${str1.split('/')}*************************************");
  }

  Widget SelectPetBottomSheet() {
    return SingleChildScrollView(
      child: SizedBox(
        // height: MediaQuery.of(context).size.height * .45,
        child: Card(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Consumer<PetProvider>(builder: (context, petProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 120, crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 10),
                    itemCount: petProvider.petDetailList.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          petProvider.setSelectedPetDetails(petProvider.petDetailList[index]);
                          petIdSelect = petProvider.petDetailList[index].id ?? 0;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40), border: Border.all(color: Colors.black26)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: CachedNetworkImage(
                                  imageUrl: petProvider.petDetailList[index].petPhoto ?? "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Image.asset(
                                      AppImage.placeholderIcon,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Image.asset(
                                      AppImage.placeholderIcon,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              petProvider.petDetailList[index].petName ?? "",
                              style: const TextStyle(
                                  fontFamily: AppFont.figTreeBold, fontSize: 16, color: AppColor.buttonPink),
                            )
                          ],
                        ),
                      );
                    })),
              );
            })),
      ),
    );
  }
}

class AnimationButttonCustom extends StatefulWidget {
  const AnimationButttonCustom({Key? key, required this.callBack}) : super(key: key);
  final Function callBack;
  @override
  _AnimationButttonCustomState createState() => _AnimationButttonCustomState();
}

class _AnimationButttonCustomState extends State<AnimationButttonCustom> with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation? _arrowAnimation;
  AnimationController? _arrowAnimationController;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _arrowAnimation = Tween(begin: 0.0, end: pi).animate(_arrowAnimationController!);
  }

  @override
  void dispose() {
    super.dispose();
    _arrowAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: firstChild(),
    );
  }

  Widget firstChild() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          isTapped = value;
        });
      },
      onTap: () {
        setState(
          () {
            _arrowAnimationController!.isCompleted
                ? _arrowAnimationController!.reverse()
                : _arrowAnimationController!.forward();
            widget.callBack();
            Future.delayed(const Duration(seconds: 2), () {
              _arrowAnimationController!.reverse();
            });
          },
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        height: isTapped ? 40 : 45,
        width: isTapped ? 40 : 45,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(5, 5),
            )
          ],
        ),
        child: AnimatedBuilder(
          animation: _arrowAnimationController!,
          builder: (context, child) => Transform.rotate(
            angle: _arrowAnimation!.value,
            child: const Icon(
              Icons.expand_more,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
