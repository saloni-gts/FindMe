import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/globalnavigatorkey.dart';
import 'package:find_me/components/scannerPermission.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/monish/screen/weightTrakrMain.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/provider/purchase_provider.dart';
import 'package:find_me/screen/categories.dart';
import 'package:find_me/screen/dioDownload.dart';
import 'package:find_me/screen/healthCard.dart';
import 'package:find_me/screen/petProfile.dart';
import 'package:find_me/screen/sampleScreen.dart';
import 'package:find_me/screen/tagListing.dart';
import 'package:find_me/screen/viewPremium.dart';
import 'package:find_me/util/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/commingSoonAlert.dart';
import '../components/greyContinerWidCircle.dart';
import '../components/iosLocPerm.dart';
import '../components/locPermission.dart';
import '../components/makePetprem.dart';
import '../generated/downloadApi.dart';
import '../models/usermodel.dart';
import '../monish/provider/myProvider.dart';
import '../monish/screen/careDiaryNewEvent.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';
import '../util/color.dart';
import 'achievements.dart';

class PetDashboard extends StatefulWidget {
  const PetDashboard({Key? key}) : super(key: key);

  @override
  State<PetDashboard> createState() => _PetDashboardState();
}

class _PetDashboardState extends State<PetDashboard> {
  var i = 0;
  var isShowPetWeight;
  late PermissionStatus _permissionStatus;

  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;
  @override
  void initState() {
    PetProvider petProvider1 = Provider.of(context, listen: false);
    petProvider1.openOnce = 0;
    PurChaseProvider purChaseProvider = Provider.of(context, listen: false);
    purChaseProvider.getSubScriptionDetails();
    // print("purChaseProvider.plan[0]====${purChaseProvider.plan[0]}");

    print("isPet Premuim==${petProvider1.selectedPetDetail?.isPremium}");

    if (purChaseProvider.plan.isNotEmpty) {
      isShowPetWeight = purChaseProvider.plan[0];

      print("isShowPetWeight==$isShowPetWeight");
    }
    petProvider1.callGetQrTag();
    petProvider1.x = 0.0;
    print("Value of x====>>> ${petProvider1.x}");
    petProvider1.graphSpotData.clear();
    print("spot data list values===>>> ${petProvider1.graphSpotData}");
    print("api called");

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(onLayoutDone);
  }

  void onLayoutDone(Duration timeStamp) async {
    _permissionStatus = await Permission.camera.status;
    print("__permissionStatus$_permissionStatus");
    setState(() {});
  }

  int x = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent
        // statusBarIconBrightness: Brightness.dark,
        ));

    PetProvider provider = Provider.of(context, listen: false);
    // print("CHECK IMG URL ${provider.selectedPetDetail?.petPhoto??""}");
    var petDetail = provider.selectedPetDetail;
    print("printing pet details===?/ ${petDetail?.isPetQrCount}");

    return Scaffold(
        backgroundColor: Colors.white,

        // appBar:
        //     customAppbar(isbackbutton: true, titlename: context.watch<PetProvider>().selectedPetDetail?.petName ?? ""),
        body: SingleChildScrollView(
          child: Consumer<PetProvider>(builder: (context, petProvider1, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    // height: 20.0,
                    ),

                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: MediaQuery.of(context).size.height * .33,
                      decoration: const BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .40,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: petProvider1.selectedPetDetail?.petPhoto ?? "",
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
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12, top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await petProvider1.callGetQrTag();

                                    Future.delayed(const Duration(milliseconds: 100), () {
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(18)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                petProvider1.selectedPetDetail?.petName ?? "",
                                style: const TextStyle(
                                    color: AppColor.buttonPink, fontSize: 16, fontFamily: AppFont.figTreeBold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    height: 100,
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await petProvider1.callGetQrTag();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TagList()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImage.viewQR),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "View Activated QR",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontFamily: AppFont.figTreeBold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 80,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              // if (petDetail?.isPetQrCount == 0)
                              {
                                var status3 = await Permission.camera.status;

                                print("value of status===>>> $status3");
                                if (!status3.isGranted) {
                                  print("iiiiii==>$i");
                                  i = i + 1;

                                  if (i > 1) {
                                    scannerPermissionDialog(context);
                                  }

                                  if (i <= 1) {
                                    await Permission.camera.request();
                                  }
                                }
                                var status4 = await Permission.camera.status;
                                print("status 4 value-=====$status4");
                                if (status4.isGranted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScannerScreen(
                                                isNewTag: 1,
                                              )));
                                }
                              }
                              //else {
                              //   if (petProvider1.openOnce == 0) {
                              //     print("******inside this****");
                              //     petProvider1.openOnce = 1;
                              //     PurChaseProvider pur = Provider.of(context, listen: false);
                              //     await pur.getSubScriptionDetails();
                              //     // petProvider1.callGetQrTag();
                              //     // Navigator.push(context, MaterialPageRoute(builder: (context) => const TagList()));
                              //   }
                              // }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImage.addQR),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Add A QR Code",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontFamily: AppFont.figTreeBold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 80,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              if (petDetail?.isPetQrCount == 0) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text: tr(LocaleKeys.additionText_qrTgNotActivated),
                                );
                              } else {
                                PermissionStatus status3;
                                LocationPermission status4;

                                print("location locIocPer===>>${petProvider1.locIocPer}");

                                if (Platform.isAndroid) {
                                  status3 = await Permission.location.status;
                                  print("location status===>>$status3");

                                  // if(status3.isGranted)
                                  if (status3 == PermissionStatus.granted) {
                                    onNotification();

                                    petProvider1.updateLoader(true);

                                    try {
                                      petProvider1.updateLoader(true);
                                      Position posti = await _determineCurPosition();

                                      petProvider1.lati = posti.latitude;
                                      petProvider1.longi = posti.longitude;
                                      petProvider1.updateLoader(false);

                                      petProvider1.updateLoader(false);

                                      petProvider1.lati = posti.latitude;
                                      petProvider1.longi = posti.longitude;
                                    } catch (e) {
                                      petProvider1.updateLoader(false);

                                      print("error========$e");
                                    }

                                    if (petProvider1.selectedPetDetail?.isLost == 1) {
                                      provider.petMarkAsLostP2(context: context);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(tr(LocaleKeys.additionText_uSurePetLost)),
                                                actions: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_cancel),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_yes),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await petProvider1.petMarkAsLostP2(
                                                          context: GlobalVariable.navState.currentContext!);
                                                      petProvider1.calleditProfileP2Api(context: context);
                                                    },
                                                  )
                                                ],
                                              ));
                                    }
                                  }

                                  if (status3 != PermissionStatus.granted) {
                                    locPermissionDialog(context);
                                  }
                                }

                                if (Platform.isIOS) {
                                  status4 = await Geolocator.checkPermission();
                                  print(
                                      "petProvider1.selectedPetDetail?.isLost ${petProvider1.selectedPetDetail?.isLost}");

                                  print("location status ios===>>$status4");

                                  if (status4 == LocationPermission.whileInUse ||
                                      status4 == LocationPermission.always) {
                                    onNotification();

                                    print("after loc func over");
                                    petProvider1.updateLoader(true);

                                    try {
                                      petProvider1.updateLoader(true);
                                      Position posti = await _determineCurPosition();

                                      petProvider1.lati = posti.latitude;
                                      petProvider1.longi = posti.longitude;
                                      petProvider1.updateLoader(false);

                                      petProvider1.updateLoader(false);

                                      petProvider1.lati = posti.latitude;
                                      petProvider1.longi = posti.longitude;
                                    } catch (e) {
                                      petProvider1.updateLoader(false);

                                      EasyLoading.showToast("Something went wrong! \nTry Again Later");
                                      print("error========$e");

                                      // petProvider.updateLoader(false);
                                    }

                                    if (petProvider1.selectedPetDetail?.isLost == 1) {
                                      provider.petMarkAsLostP2(context: context);
                                    } else if (petProvider1.selectedPetDetail?.isLost == 0) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(tr(LocaleKeys.additionText_uSurePetLost)),
                                                actions: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_cancel),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  InkWell(
                                                    child: Text(
                                                      tr(LocaleKeys.additionText_yes),
                                                      style: const TextStyle(
                                                          fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                                    ),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await petProvider1.petMarkAsLostP2(
                                                          context: GlobalVariable.navState.currentContext!);

                                                      petProvider1.calleditProfileP2Api(context: context);
                                                    },
                                                  )
                                                ],
                                              ));
                                    }
                                  }

                                  if (status4 == LocationPermission.denied ||
                                      status4 == LocationPermission.deniedForever) {
                                    iosLocPermiDialog(context);
                                    petProvider1.locIocPer = 1;
                                  }
                                }
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImage.loudSpeaker),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Mark Pet As Lost",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black, fontFamily: AppFont.figTreeBold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      provider.mySelectedEvents = {};
                      print("is map empty==>>${provider.mySelectedEvents}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EventCalender(isShowBackIcon: true, isBottomBorder: true, isFromPet: true)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkCal),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.home_careDiary),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      PetProvider petProvider = Provider.of(context, listen: false);
                      petProvider.cateId = "";
                      petProvider.GetDocV2();
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkDoc),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.petProfile_documents),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      provider.getPetPhotoCall(context: context, isNavigate: true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkPic),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.petProfile_photos),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      PetProvider petProvider = Provider.of(context, listen: false);

                      print("helth controler valsue==>> ${petProvider.petHealtweightCntrolr.text}");

                      print("user.isPremium=${petProvider.isUserPremium}===");

                      if ((petProvider.isUserPremium == 1 && petProvider.selectedPetDetail?.isPremium == 1) ||
                          (petProvider.sharedPremIds.contains(petProvider.selectedPetDetail?.id))) {
                        PetProvider petProvider = Provider.of(context, listen: false);
                        petProvider.graphSpotData.clear();
                        petProvider.callGetWeight();

                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const WeightTrkrMain()));
                        }).onError((error, stackTrace) {
                          print("eroorroror===>>> $error");
                        });
                      } else if (petProvider.isUserPremium == 1 && petProvider.selectedPetDetail?.isPremium == 0) {
                        makePetPremDialog(context);
                      } else if (petProvider.isUserPremium == 0) {
                        commingSoonDialog(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkWgt),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.petProfile_weightTraker),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppScreen.googlemap);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkQr),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.petProfile_qrScanned),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      if (Platform.isIOS) {
                        showDialog(
                            context: context,
                            builder: (context1) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                title: Text(tr(LocaleKeys.additionText_uSureWannaDownlod)),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context1);
                                    },
                                    child: Text(
                                      tr(LocaleKeys.additionText_no),
                                      style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      Navigator.pop(context1);
                                      EasyLoading.showToast(tr(LocaleKeys.additionText_downloadStarted),
                                          duration: const Duration(seconds: 7));

                                      PetProvider petProvider = Provider.of(context, listen: false);

                                      petProvider.updateLoader(true);
                                      CallAPi apiii = CallAPi();
                                      String pdfurlfinal = await apiii.login(petId: petProvider.setselectedPetId);

                                      petProvider.updateLoader(false);
                                      print("apiii url===>>> ${apiii.pdfUrl}");

                                      if (pdfurlfinal.isEmpty) {
                                        petProvider.updateLoader(false);
                                        EasyLoading.showToast("try again later");
                                      }
                                      if (pdfurlfinal.isNotEmpty) {
                                        petProvider.updateLoader(false);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => DownloadingDailog(uri: apiii.pdfUrl));
                                      }
                                    },
                                    child: Text(
                                      tr(LocaleKeys.additionText_yes),
                                      style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                      if (Platform.isAndroid) {
                        {
                          showDialog(
                              context: context,
                              builder: (context1) {
                                return Container(
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    title: Text(tr(LocaleKeys.additionText_uSureWannaDownlod)),
                                    actions: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context1);
                                        },
                                        child: Text(
                                          tr(LocaleKeys.additionText_no),
                                          style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context1);
                                          EasyLoading.showToast(tr(LocaleKeys.additionText_downloadStarted),
                                              duration: const Duration(seconds: 7));

                                          PetProvider petProvider = Provider.of(context, listen: false);
                                          petProvider.updateLoader(true);
                                          CallAPi apiii = CallAPi();
                                          String pdfurlfinal = await apiii.login(petId: petProvider.setselectedPetId);

                                          petProvider.updateLoader(false);
                                          print("apiii url===>>> ${apiii.pdfUrl}");

                                          if (pdfurlfinal.isEmpty) {
                                            petProvider.updateLoader(false);
                                            EasyLoading.showToast("try again later");
                                          }
                                          if (pdfurlfinal.isNotEmpty) {
                                            petProvider.updateLoader(false);
                                            print("apiii url===>>> ${apiii.pdfUrl}");
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) =>
                                                    DownloadingDailog(uri: apiii.pdfUrl));
                                          }
                                        },
                                        child: Text(
                                          tr(LocaleKeys.additionText_yes),
                                          style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkDown),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.petProfile_downloadpetProfile),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HealthCard()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkHlth),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.additionText_hlthCard),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Achievement(
                                    isNavigate: false,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xffFBF5F6)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Image.asset(AppImage.pinkAch),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            tr(LocaleKeys.additionText_achievements),
                            style: const TextStyle(fontFamily: AppFont.figTreeBold, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.arrow_forward),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
                //     child: Consumer<PetProvider>(
                //       builder: (context, petProvider1, child) {
                //         return Center(
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               InkWell(
                //                 child: Image.asset(AppImage.petDash1),
                //                 onTap: () async {
                //                   if (petDetail?.isPetQrCount == 0) {
                //                     var status3 = await Permission.camera.status;

                //                     print("value of status===>>> $status3");
                //                     if (!status3.isGranted) {
                //                       print("iiiiii==>$i");
                //                       i = i + 1;

                //                       if (i > 1) {
                //                         scannerPermissionDialog(context);
                //                       }

                //                       if (i <= 1) {
                //                         await Permission.camera.request();
                //                       }
                //                     }
                //                     var status4 = await Permission.camera.status;
                //                     print("status 4 value-=====$status4");
                //                     if (status4.isGranted) {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                               builder: (context) => ScannerScreen(
                //                                     isNewTag: 1,
                //                                   )));
                //                     }
                //                   } else {
                //                     if (petProvider1.openOnce == 0) {
                //                       print("******inside this****");
                //                       petProvider1.openOnce = 1;
                //                       PurChaseProvider pur = Provider.of(context, listen: false);
                //                       await pur.getSubScriptionDetails();
                //                       petProvider1.callGetQrTag();
                //                       Navigator.push(context, MaterialPageRoute(builder: (context) => const TagList()));
                //                     }
                //                   }

                //                   // petProvider1.callGetQrTag();
                //                   // Navigator.push(context, MaterialPageRoute(builder: (context) => TagList()));
                //                   // Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen()));
                //                 },
                //               ),
                //               Center(
                //                 child: Stack(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.only(left: 12.0),
                //                       child: Container(
                //                         height: 125,
                //                         width: 125,
                //                         decoration: BoxDecoration(
                //                           borderRadius: BorderRadius.circular(65),
                //                           color: AppColor.textFieldGrey,
                //                         ),
                //                         child: ClipRRect(
                //                           borderRadius: BorderRadius.circular(65),
                //                           // radius: 50,
                //                           child: CachedNetworkImage(
                //                             imageUrl: petProvider1.selectedPetDetail?.petPhoto ?? "",
                //                             fit: BoxFit.cover,
                //                             placeholder: (context, url) => Padding(
                //                               padding: const EdgeInsets.all(18.0),
                //                               child: Image.asset(
                //                                 AppImage.placeholderIcon,
                //                                 fit: BoxFit.cover,
                //                               ),
                //                             ),
                //                             errorWidget: (context, url, error) => Padding(
                //                               padding: const EdgeInsets.all(18.0),
                //                               child: Image.asset(
                //                                 AppImage.placeholderIcon,
                //                                 fit: BoxFit.cover,
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                     Positioned(
                //                       left: 95,
                //                       child: SizedBox(
                //                         height: 40,
                //                         width: 40,
                //                         child: InkWell(
                //                           onTap: () async {
                //                             await petProvider1.callGetQrTag();

                //                             Future.delayed(const Duration(milliseconds: 100), () {
                //                               Navigator.push(
                //                                   context, MaterialPageRoute(builder: (context) => const PetProfile()));
                //                             });

                //                             // Navigator.push(
                //                             //     context,
                //                             //     MaterialPageRoute(
                //                             //         builder: (context) =>
                //                             //             PetProfile()));
                //                           },
                //                           child: ClipRRect(
                //                             child: Image.asset(AppImage.pencil, height: 40),
                //                           ),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //               Consumer<PetProvider>(builder: (context, petProvider, child) {
                //                 return InkWell(
                //                     child: Image.asset(AppImage.petDash2),
                //                     onTap: () async {
                //                       if (petDetail?.isPetQrCount == 0) {
                //                         CoolAlert.show(
                //                           context: context,
                //                           type: CoolAlertType.warning,
                //                           text: tr(LocaleKeys.additionText_qrTgNotActivated),
                //                         );
                //                       } else {
                //                         PermissionStatus status3;
                //                         LocationPermission status4;

                //                         print("location locIocPer===>>${petProvider.locIocPer}");

                //                         if (Platform.isAndroid) {
                //                           status3 = await Permission.location.status;
                //                           print("location status===>>$status3");

                //                           // if(status3.isGranted)
                //                           if (status3 == PermissionStatus.granted) {
                //                             onNotification();

                //                             petProvider.updateLoader(true);

                //                             try {
                //                               petProvider.updateLoader(true);
                //                               Position posti = await _determineCurPosition();

                //                               petProvider1.lati = posti.latitude;
                //                               petProvider1.longi = posti.longitude;
                //                               petProvider.updateLoader(false);

                //                               petProvider.updateLoader(false);

                //                               petProvider.lati = posti.latitude;
                //                               petProvider.longi = posti.longitude;
                //                             } catch (e) {
                //                               petProvider.updateLoader(false);

                //                               print("error========$e");
                //                             }

                //                             if (petProvider1.selectedPetDetail?.isLost == 1) {
                //                               provider.petMarkAsLostP2(context: context);
                //                             } else {
                //                               showDialog(
                //                                   context: context,
                //                                   builder: (context) => AlertDialog(
                //                                         title: Text(tr(LocaleKeys.additionText_uSurePetLost)),
                //                                         actions: <Widget>[
                //                                           InkWell(
                //                                             child: Text(
                //                                               tr(LocaleKeys.additionText_cancel),
                //                                               style: const TextStyle(
                //                                                   fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                                             ),
                //                                             onTap: () {
                //                                               Navigator.pop(context);
                //                                             },
                //                                           ),
                //                                           const SizedBox(width: 5),
                //                                           InkWell(
                //                                             child: Text(
                //                                               tr(LocaleKeys.additionText_yes),
                //                                               style: const TextStyle(
                //                                                   fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                                             ),
                //                                             onTap: () async {
                //                                               Navigator.pop(context);
                //                                               await petProvider1.petMarkAsLostP2(
                //                                                   context: GlobalVariable.navState.currentContext!);
                //                                               petProvider.calleditProfileP2Api(context: context);
                //                                             },
                //                                           )
                //                                         ],
                //                                       ));
                //                             }
                //                           }

                //                           if (status3 != PermissionStatus.granted) {
                //                             locPermissionDialog(context);
                //                           }
                //                         }

                //                         if (Platform.isIOS) {
                //                           status4 = await Geolocator.checkPermission();
                //                           print(
                //                               "petProvider1.selectedPetDetail?.isLost ${petProvider1.selectedPetDetail?.isLost}");

                //                           print("location status ios===>>$status4");

                //                           if (status4 == LocationPermission.whileInUse ||
                //                               status4 == LocationPermission.always) {
                //                             onNotification();

                //                             print("after loc func over");
                //                             petProvider.updateLoader(true);

                //                             try {
                //                               petProvider.updateLoader(true);
                //                               Position posti = await _determineCurPosition();

                //                               petProvider1.lati = posti.latitude;
                //                               petProvider1.longi = posti.longitude;
                //                               petProvider.updateLoader(false);

                //                               petProvider.updateLoader(false);

                //                               petProvider.lati = posti.latitude;
                //                               petProvider.longi = posti.longitude;
                //                             } catch (e) {
                //                               petProvider.updateLoader(false);

                //                               EasyLoading.showToast("Something went wrong! \nTry Again Later");
                //                               print("error========$e");

                //                               // petProvider.updateLoader(false);
                //                             }

                //                             if (petProvider1.selectedPetDetail?.isLost == 1) {
                //                               provider.petMarkAsLostP2(context: context);
                //                             } else if (petProvider1.selectedPetDetail?.isLost == 0) {
                //                               showDialog(
                //                                   context: context,
                //                                   builder: (context) => AlertDialog(
                //                                         title: Text(tr(LocaleKeys.additionText_uSurePetLost)),
                //                                         actions: <Widget>[
                //                                           InkWell(
                //                                             child: Text(
                //                                               tr(LocaleKeys.additionText_cancel),
                //                                               style: const TextStyle(
                //                                                   fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                                             ),
                //                                             onTap: () {
                //                                               Navigator.pop(context);
                //                                             },
                //                                           ),
                //                                           const SizedBox(width: 5),
                //                                           InkWell(
                //                                             child: Text(
                //                                               tr(LocaleKeys.additionText_yes),
                //                                               style: const TextStyle(
                //                                                   fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                                             ),
                //                                             onTap: () async {
                //                                               Navigator.pop(context);
                //                                               await petProvider1.petMarkAsLostP2(
                //                                                   context: GlobalVariable.navState.currentContext!);

                //                                               petProvider.calleditProfileP2Api(context: context);
                //                                             },
                //                                           )
                //                                         ],
                //                                       ));
                //                             }
                //                           }

                //                           if (status4 == LocationPermission.denied ||
                //                               status4 == LocationPermission.deniedForever) {
                //                             iosLocPermiDialog(context);
                //                             petProvider.locIocPer = 1;
                //                           }
                //                         }
                //                       }
                //                     });
                //               })
                //             ],
                //           ),
                //         );
                //       },
                //     )),
                // const SizedBox(
                //   height: 10.0,
                // ),

                // Center(
                //   child: petDetail?.isPetQrCount != 0
                //       ? InkWell(
                //           onTap: () async {
                //             PetProvider petProvider = Provider.of(context, listen: false);

                //             print("print");
                //             var status3 = await Permission.camera.status;
                //             print("value of status===>>> $status3");

                //             if (status3 != PermissionStatus.granted) {
                //               // print("iiiiii==>${i}");
                //               i = i + 1;
                //               print("iiiiii==>$i");
                //               if (i > 2) {
                //                 scannerPermissionDialog(context);
                //                 // await Permission.camera.request();
                //               }

                //               if (i == 1) {
                //                 await Permission.camera.request();
                //               }
                //             }
                //             var status4 = await Permission.camera.status;
                //             print("value of status===>>> $status4");

                //             if (status4 == PermissionStatus.granted) {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => ScannerScreen(
                //                             isNewTag: 1,
                //                           )));
                //             }
                //           },
                //           child: Container(
                //             height: 40,
                //             width: MediaQuery.of(context).size.width * .55,
                //             decoration:
                //                 BoxDecoration(borderRadius: BorderRadius.circular(28), color: AppColor.newBlueGrey),
                //             child: Center(
                //               child:
                //                   // Text(
                //                   //   tr(LocaleKeys.additionText_addMoreQR),
                //                   //   textAlign: TextAlign.center,
                //                   //   style: TextStyle(
                //                   //     color: Colors.white,
                //                   //     fontFamily: AppFont.poppinsMedium,
                //                   //     fontSize: 13.0,
                //                   //   ),
                //                   // ),

                //                   RichText(
                //                 textAlign: TextAlign.center,
                //                 text: TextSpan(children: <TextSpan>[
                //                   TextSpan(
                //                     text: tr(LocaleKeys.additionText_addMoreQR),
                //                     style: const TextStyle(
                //                         color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w800),
                //                   ),
                //                 ]),
                //               ),
                //             ),
                //           ),
                //         )
                //       : const SizedBox(height: 40),
                // ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0),
                //   child: Text(
                //     tr(LocaleKeys.petProfile_protection),
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //         fontSize: 16.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinsBold),
                //   ),
                // ),
                // const SizedBox(
                //   height: 12.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //   child: Row(
                //     children: [
                //       GreyContainerWidCircle(
                //           context: context,
                //           crl: AppColor.newLightBlue,
                //           text1: tr(LocaleKeys.home_careDiary),
                //           image1: AppImage.newCal,
                //           onTap1: () {
                //             provider.mySelectedEvents = {};
                //             print("is map empty==>>${provider.mySelectedEvents}");
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         EventCalender(isShowBackIcon: true, isBottomBorder: true, isFromPet: true)));

                //             //   Navigator.push(context, MaterialPageRoute(builder: (context)=>NewEvent()));
                //           }),
                //       const SizedBox(
                //         width: 12.0,
                //       ),
                //       GreyContainerWidCircle(
                //           context: context,
                //           text1: tr(LocaleKeys.petProfile_documents),
                //           image1: AppImage.newDocs,
                //           crl: AppColor.newLightBlue,
                //           onTap1: () {
                //             // Navigator.pushNamed(context, AppScreen.documentList);
                //             PetProvider petProvider = Provider.of(context, listen: false);
                //             petProvider.cateId = "";
                //             petProvider.GetDocV2();
                //             Future.delayed(const Duration(milliseconds: 1000), () {
                //               Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
                //             });
                //           })
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 12.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //   child: Row(
                //     children: [
                //       GreyContainerWidCircle(
                //           context: context,
                //           crl: AppColor.newLightBlue,
                //           text1: tr(LocaleKeys.petProfile_photos),
                //           image1: AppImage.newPics,
                //           onTap1: () {
                //             provider.getPetPhotoCall(context: context, isNavigate: true);
                //           }),
                //       const SizedBox(
                //         width: 12.0,
                //       ),
                //       GreyContainerWidCircle(
                //           context: context,
                //           text1: tr(LocaleKeys.petProfile_weightTraker),
                //           crl: AppColor.newLightBlue,
                //           image1: AppImage.newWeight,
                //           onTap1: () {
                //             PetProvider petProvider = Provider.of(context, listen: false);

                //             print("helth controler valsue==>> ${petProvider.petHealtweightCntrolr.text}");

                //             print("user.isPremium=${petProvider.isUserPremium}===");

                //             if ((petProvider.isUserPremium == 1 && petProvider.selectedPetDetail?.isPremium == 1) ||
                //                 (petProvider.sharedPremIds.contains(petProvider.selectedPetDetail?.id))) {
                //               PetProvider petProvider = Provider.of(context, listen: false);
                //               petProvider.graphSpotData.clear();
                //               petProvider.callGetWeight();

                //               Future.delayed(const Duration(milliseconds: 1000), () {
                //                 Navigator.push(context, MaterialPageRoute(builder: (context) => WeightTrkrMain()));
                //               }).onError((error, stackTrace) {
                //                 print("eroorroror===>>> $error");
                //               });
                //             } else if (petProvider.isUserPremium == 1 &&
                //                 petProvider.selectedPetDetail?.isPremium == 0) {
                //               makePetPremDialog(context);
                //             } else if (petProvider.isUserPremium == 0) {
                //               commingSoonDialog(context);
                //             }

                //             // commingSoonDialog(context);
                //           })
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0),
                //   child: Text(
                //     tr(LocaleKeys.petProfile_moreOption),
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //       fontSize: 16.0,
                //       color: AppColor.textLightBlueBlack,
                //       fontFamily: AppFont.poppinsBold,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //   child: Row(
                //     children: [
                //       GreyContainerWidCircle(
                //           context: context,
                //           crl: AppColor.newLightBlue,
                //           text1: tr(LocaleKeys.petProfile_qrScanned),
                //           image1: AppImage.newQR,
                //           onTap1: () {
                //             Navigator.pushNamed(context, AppScreen.googlemap);
                //           }),
                //       const SizedBox(
                //         width: 12.0,
                //       ),
                //       Consumer<PetProvider>(builder: (context, petProvider, child) {
                //         return GreyContainerWidCircle(
                //             context: context,
                //             text1: tr(LocaleKeys.petProfile_downloadpetProfile),
                //             crl: AppColor.newLightBlue,
                //             image1: AppImage.newDown,
                //             onTap1: () async {
                //               if (Platform.isIOS) {
                //                 showDialog(
                //                     context: context,
                //                     builder: (context1) {
                //                       return AlertDialog(
                //                         title: Text(tr(LocaleKeys.additionText_uSureWannaDownlod)),
                //                         actions: [
                //                           InkWell(
                //                             onTap: () {
                //                               Navigator.pop(context1);
                //                             },
                //                             child: Text(
                //                               tr(LocaleKeys.additionText_no),
                //                               style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                             ),
                //                           ),
                //                           const SizedBox(
                //                             width: 5,
                //                           ),
                //                           InkWell(
                //                             onTap: () async {
                //                               Navigator.pop(context1);
                //                               EasyLoading.showToast(tr(LocaleKeys.additionText_downloadStarted),
                //                                   duration: const Duration(seconds: 7));

                //                               PetProvider petProvider = Provider.of(context, listen: false);

                //                               petProvider.updateLoader(true);
                //                               CallAPi apiii = CallAPi();
                //                               String pdfurlfinal =
                //                                   await apiii.login(petId: petProvider.setselectedPetId);

                //                               petProvider.updateLoader(false);
                //                               print("apiii url===>>> ${apiii.pdfUrl}");

                //                               if (pdfurlfinal.isEmpty) {
                //                                 petProvider.updateLoader(false);
                //                                 EasyLoading.showToast("try again later");
                //                               }
                //                               if (pdfurlfinal.isNotEmpty) {
                //                                 petProvider.updateLoader(false);
                //                                 showDialog(
                //                                     context: context,
                //                                     builder: (BuildContext context) =>
                //                                         DownloadingDailog(uri: apiii.pdfUrl));
                //                               }
                //                             },
                //                             child: Text(
                //                               tr(LocaleKeys.additionText_yes),
                //                               style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                             ),
                //                           )
                //                         ],
                //                       );
                //                     });
                //               }
                //               if (Platform.isAndroid) {
                //                 {
                //                   showDialog(
                //                       context: context,
                //                       builder: (context1) {
                //                         return AlertDialog(
                //                           title: Text(tr(LocaleKeys.additionText_uSureWannaDownlod)),
                //                           actions: [
                //                             InkWell(
                //                               onTap: () {
                //                                 Navigator.pop(context1);
                //                               },
                //                               child: Text(
                //                                 tr(LocaleKeys.additionText_no),
                //                                 style:
                //                                     const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                               ),
                //                             ),
                //                             const SizedBox(
                //                               width: 5,
                //                             ),
                //                             InkWell(
                //                               onTap: () async {
                //                                 Navigator.pop(context1);
                //                                 EasyLoading.showToast(tr(LocaleKeys.additionText_downloadStarted),
                //                                     duration: const Duration(seconds: 7));

                //                                 PetProvider petProvider = Provider.of(context, listen: false);
                //                                 petProvider.updateLoader(true);
                //                                 CallAPi apiii = CallAPi();
                //                                 String pdfurlfinal =
                //                                     await apiii.login(petId: petProvider.setselectedPetId);

                //                                 petProvider.updateLoader(false);
                //                                 print("apiii url===>>> ${apiii.pdfUrl}");

                //                                 if (pdfurlfinal.isEmpty) {
                //                                   petProvider.updateLoader(false);
                //                                   EasyLoading.showToast("try again later");
                //                                 }
                //                                 if (pdfurlfinal.isNotEmpty) {
                //                                   petProvider.updateLoader(false);
                //                                   print("apiii url===>>> ${apiii.pdfUrl}");
                //                                   showDialog(
                //                                       context: context,
                //                                       builder: (BuildContext context) =>
                //                                           DownloadingDailog(uri: apiii.pdfUrl));
                //                                 }
                //                               },
                //                               child: Text(
                //                                 tr(LocaleKeys.additionText_yes),
                //                                 style:
                //                                     const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                //                               ),
                //                             )
                //                           ],
                //                         );
                //                       });
                //                 }
                //               }
                //             });
                //       })
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //   child: Row(
                //     children: [
                //       GreyContainerWidCircle(
                //           context: context,
                //           crl: AppColor.newLightBlue,
                //           text1: tr(LocaleKeys.additionText_hlthCard),
                //           // tr(LocaleKeys.petProfile_healthCare),
                //           image1: AppImage.newHCard,
                //           onTap1: () {
                //             Navigator.push(context, MaterialPageRoute(builder: (context) => HealthCard()));
                //             // commingSoonDialog(context);
                //           }),
                //       const SizedBox(
                //         width: 12.0,
                //       ),
                //       GreyContainerWidCircle(
                //           context: context,
                //           crl: AppColor.newLightBlue,
                //           text1: tr(LocaleKeys.additionText_achievements),
                //           image1: AppImage.newAchi,
                //           onTap1: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => Achievement(
                //                           isNavigate: false,
                //                         )));
                //             // commingSoonDialog(context);
                //           }),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Container(
                //     height: 15,
                //     width: double.infinity,
                //     color: AppColor.newGrey,
                //   ),
                // ),

                const SizedBox(
                  height: 10.0,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ViewPremium();
                        },
                      ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      // padding: const EdgeInsets.symmetric(vertical: 85),
                      width: double.infinity,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(18), color: const Color(0xffFEF393)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Tap Now To Unlock All The PREMIUM BENIFITS ",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xff5B5200), fontFamily: AppFont.figTreeBold, fontSize: 18),
                            ),
                          ),
                          Image.asset(AppImage.buyPrem)
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(context, MaterialPageRoute(
                //         builder: (context) {
                //           return const ViewPremium();
                //         },
                //       ));
                //     },
                //     child: Container(
                //       height: 100,
                //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: AppColor.textFieldGrey),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //         child: Row(children: [
                //           Image.asset(AppImage.bigRibbon, height: 80, width: 40),
                //           const Expanded(
                //             child: Text(
                //               "Tap Now To Unlock All The \nPREMIUM BENIFITS",
                //               textAlign: TextAlign.center,
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(
                //                 color: Color(0xff585357),
                //                 fontFamily: AppFont.poppinsBold,
                //                 fontSize: 16,
                //               ),
                //             ),
                //           )
                //         ]),
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(
                  height: 20.0,
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //   child: Row(
                //     children: [
                //       GreyContainerWidCircle(
                //           context: context,
                //           text1: "Achievements",
                //           image1: AppImage.achievements,
                //           onTap1: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => Achievement()));
                //             // commingSoonDialog(context);
                //           }),
                //       SizedBox(
                //         width: 12.0,
                //       ),
                //       // GreyContainerWidCircle(
                //       //     context: context,
                //       //     text1: "Joint management",
                //       //     image1: AppImage.joiManagement,
                //       //     onTap1: () {
                //       //       //Navigator.push(context, MaterialPageRoute(builder: (context)=>WeightTracker()));
                //       //       // commingSoonDialog(context);
                //       //     })
                //     ],
                //   ),
                // ),
              ],
            );
          }),
        ));
  }

  void _askCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      print("granted");
      var permissionStatus = await Permission.camera.status;
      setState(() {});
    }
  }

  Future<Position> _determineCurPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.low,
        // timeLimit: Duration(seconds: 10)
        );
  }

  Future<void> onNotification() async {
    Myprovider myProvider = Provider.of(context, listen: false);

    if (Platform.isAndroid) {
      var status3 = await Permission.location.status;
      print("help pet lost noti status=>$status3");
      if (status3 == PermissionStatus.granted) {
        myProvider.callsendNotificationApi(iddd: 1, status: 1);
        HiveHandler.updateNotiButton(true);
        var v1 = HiveHandler.isChekLostNoti();
        print("value of v1====$v1");
        myProvider.chngSetButton();
      }
    }

    if (Platform.isIOS) {
      var status4 = await Geolocator.checkPermission();
      print("help pet lost noti status=>$status4");
      if (status4 == LocationPermission.whileInUse || status4 == LocationPermission.always) {
        myProvider.callsendNotificationApi(iddd: 1, status: 1);
        HiveHandler.updateNotiButton(true);
        var v1 = HiveHandler.isChekLostNoti();
        print("value of v1====$v1");
        myProvider.chngSetButton();
      }
    }
  }
}
