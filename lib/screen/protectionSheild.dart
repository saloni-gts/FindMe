import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/screen/petProfile.dart';
import 'package:find_me/screen/sampleScreen.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/scannerPermission.dart';
import '../components/sheildList.dart';
import '../generated/locale_keys.g.dart';
import '../models/usermodel.dart';
import '../monish/reUseClass/custombluebutton.dart';
import '../monish/screen/ownerProfile.dart';
import '../provider/petprovider.dart';
import '../util/app_font.dart';
import '../util/app_images.dart';

class ProtectionSheild extends StatefulWidget {
  const ProtectionSheild({Key? key}) : super(key: key);

  @override
  State<ProtectionSheild> createState() => _ProtectionSheildState();
}

class _ProtectionSheildState extends State<ProtectionSheild> {
  @override
  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;
  var i = 0;
  @override
  void initState() {
    PetProvider pet = Provider.of(context, listen: false);

    pet.SheildList = 1;
    // print("user name======${user.name}");
    // print("user mobile num======${user.mobileNumber}");
    // print("user email======${user.email}");
    // print("user gender======${user.gender}");
    // print("user country======${user.countryName}");
    pet.showGreenTickShield(pet.petDetailList[0].id ?? 0);

    pet.setSelectedPetDetails(pet.petDetailList[0]);

    pet.isShowSheild();

    pet.callGetQrTag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.newGrey,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColor.newGrey,
      body: Consumer<PetProvider>(builder: (context, petProvider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Consumer<PetProvider>(
                builder: (context, petProvider, child) {
                  var petList = petProvider.petDetailList;
                  return SizedBox(
                    height: 110.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: petList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PetProvider provider = Provider.of(context, listen: false);

                              petProvider.setSelectedPetDetails(petList[index]);
                              petProvider.callGetQrTag();

                              petProvider.isShowSheild();

                              provider.showGreenTickShield(provider.petDetailList[index].id ?? 0);
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40), color: AppColor.textFieldGrey),
                                        height: 80,
                                        width: 80,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: CachedNetworkImage(
                                            imageUrl: petList[index].petPhoto ?? "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                AppImage.placeholderIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                AppImage.placeholderIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      petProvider.petDetailList[index].id == petProvider.selectedPetIdShield
                                          ? Positioned(
                                              left: 54.0,
                                              top: 0,
                                              child: InkWell(
                                                child: ClipRRect(
                                                  child: Image.asset(AppImage.greenCheckIcon),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("IMAGE PET  ${petList[index].petPhoto}");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      petList[index].petName ?? "",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: AppColor.newBlueGrey,
                                          fontFamily: AppFont.poppinSemibold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: AppColor.newBlueGrey,
                      ),
                      child: Center(
                        child: Text(
                          tr(LocaleKeys.additionText_Protection),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: AppFont.poppinSemibold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      tr(LocaleKeys.additionText_provideBasicPetProt),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.newBlueGrey,
                        fontFamily: AppFont.poppinSemibold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // Image.asset(AppImage.ssUpLeft,),

                  petProvider.isSheildComplete == 0
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                child:
                                    Image.asset(petProvider.SheildList == 1 ? AppImage.upLeftSS : AppImage.upLefttIcon
                                        // AppImage.upLefttIcon,
                                        ),
                                onTap: () {
                                  // petProvider.updateLoader(true);
                                  petProvider.showSheildList(1);
                                  // petProvider.updateLoader(false);
                                },
                              ),
                              InkWell(
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {
                                    petProvider.showSheildList(2);
                                  },
                                  child: Image.asset(
                                      petProvider.SheildList == 2 ? AppImage.ssUpRight : AppImage.usUpRight)),
                            ],
                          ),
                        )
                      : const SizedBox(),

                  petProvider.isSheildComplete == 0
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                child: Image.asset(
                                  petProvider.SheildList == 3 ? AppImage.ssDownLeft : AppImage.usDownLeft,
                                ),
                                onTap: () {
                                  petProvider.showSheildList(3);
                                },
                              ),
                              InkWell(
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  child: Image.asset(
                                      petProvider.SheildList == 4 ? AppImage.ssDownRight : AppImage.usDownRight),
                                  onTap: () {
                                    petProvider.showSheildList(4);
                                  }),
                            ],
                          ),
                        )
                      : const SizedBox(),

                  petProvider.isSheildComplete == 1 ? Image.asset(AppImage.goldSheild) : const SizedBox(),

                  const SizedBox(
                    height: 15,
                  ),

                  petProvider.SheildList == 1
                      ? petProvider.isSheildComplete == 1
                          ? Padding(
                              padding: const EdgeInsets.only(top: 48.0),
                              child: Center(
                                child: Text(
                                  tr(LocaleKeys.additionText_yrPetProtcted),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColor.textYello,
                                    fontFamily: AppFont.poppinSemibold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * .80,
                              // height: MediaQuery.of(context).size.height * .29,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0, top: 10),
                                    child: Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                            text: tr(LocaleKeys.additionText_fillYrPetInfo),
                                            style: const TextStyle(
                                                color: AppColor.textLightBlueBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SheildListPetInfo(
                                      txt1: tr(LocaleKeys.additionText_petname),
                                      isCheck: petProvider.selectedPetDetail?.petName == "" ? 0 : 1,
                                      onTap1: () {
                                        // petProvider.callGetQrTag();

                                        Future.delayed(const Duration(milliseconds: 250), () {
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                        });
                                      }),
                                  SheildListPetInfo(
                                      txt1: tr(LocaleKeys.additionText_birthday),
                                      isCheck: petProvider.selectedPetDetail?.birthDate == "" ? 0 : 1,
                                      onTap1: () {
                                        petProvider.updateLoader(true);
                                        Future.delayed(const Duration(milliseconds: 250), () {
                                          petProvider.updateLoader(false);

                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                        });
                                      }),
                                  SheildListPetInfo(
                                      txt1: tr(LocaleKeys.additionText_color),
                                      isCheck: petProvider.selectedPetDetail?.color == "" ? 0 : 1,
                                      onTap1: () {
                                        Future.delayed(const Duration(milliseconds: 250), () {
                                          petProvider.updateLoader(false);
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                        });
                                      }),
                                  SheildListPetInfo(
                                      txt1: tr(LocaleKeys.additionText_sex),
                                      isCheck: petProvider.selectedPetDetail?.gender == "" ? 0 : 1,
                                      onTap1: () {
                                        Future.delayed(const Duration(milliseconds: 250), () {
                                          petProvider.updateLoader(false);
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                        });
                                      }),
                                  SheildListPetInfo(
                                      txt1: tr(LocaleKeys.additionText_Breed),
                                      isCheck: petProvider.selectedPetDetail?.breedName == "" ? 0 : 1,
                                      onTap1: () {
                                        Future.delayed(const Duration(milliseconds: 250), () {
                                          petProvider.updateLoader(false);
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                        });
                                      }),
                                  SheildListPetInfo(
                                      txt1: tr(LocaleKeys.addPet_sterilization),
                                      isCheck: petProvider.selectedPetDetail?.sterilization == "1" ? 1 : 0,
                                      onTap1: () {
                                        Future.delayed(const Duration(milliseconds: 250), () {
                                          petProvider.updateLoader(false);
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const PetProfile()));
                                        });
                                      }),
                                ],
                              ),
                            )
                      : const SizedBox(),

                  petProvider.SheildList == 2
                      ? Container(
                          width: MediaQuery.of(context).size.width * .80,
                          // height: MediaQuery.of(context).size.height * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 10),
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: tr(LocaleKeys.additionText_fillOnrInfo),
                                        style: const TextStyle(
                                            color: AppColor.textLightBlueBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SheildListPetInfo(
                                  txt1: tr(LocaleKeys.additionText_fstName),
                                  isCheck: user.name == "" ? 0 : 1,
                                  onTap1: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => OwnerProfile()));
                                  }),
                              SheildListPetInfo(
                                  txt1: tr(LocaleKeys.additionText_Gender),
                                  isCheck: user.gender == "1" || user.gender == "2" ? 1 : 0,
                                  onTap1: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => OwnerProfile()));
                                  }),
                              SheildListPetInfo(
                                  txt1: tr(LocaleKeys.additionText_Email),
                                  isCheck: 1,
                                  onTap1: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => OwnerProfile()));
                                  }),
                              SheildListPetInfo(
                                  txt1: tr(LocaleKeys.additionText_MainPhn),
                                  isCheck: 1,
                                  onTap1: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => OwnerProfile()));
                                  }),
                              SheildListPetInfo(
                                  txt1: tr(LocaleKeys.additionText_Country),
                                  isCheck: user.country == " " ? 0 : 1,
                                  onTap1: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => OwnerProfile()));
                                  }),
                            ],
                          ),
                        )
                      : const SizedBox(),

                  petProvider.SheildList == 3
                      ? Container(
                          width: MediaQuery.of(context).size.width * .80,
                          height: petProvider.selectedPetDetail?.isPetQrCount == 0
                              ? MediaQuery.of(context).size.height * .15
                              : MediaQuery.of(context).size.height * .10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 10),
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: petProvider.selectedPetDetail?.isPetQrCount == 0
                                            ? tr(LocaleKeys.additionText_activateqr)
                                            : tr(LocaleKeys.additionText_qractivated),
                                        style: const TextStyle(
                                            color: AppColor.textLightBlueBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              petProvider.selectedPetDetail?.isPetQrCount == 0
                                  ? Center(
                                      child: InkWell(
                                        onTap: () async {
                                          print("print");
                                          var status3 = await Permission.camera.status;
                                          print("value of status===>>> $status3");

                                          if (status3 != PermissionStatus.granted) {
                                            // print("iiiiii==>${i}");
                                            i = i + 1;
                                            print("iiiiii==>$i");
                                            if (i > 2) {
                                              scannerPermissionDialog(context);
                                              // await Permission.camera.request();
                                            }

                                            if (i == 1) {
                                              await Permission.camera.request();
                                            }
                                          }
                                          var status4 = await Permission.camera.status;
                                          print("value of status===>>> $status4");
                                          if (status4 == PermissionStatus.granted) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ScannerScreen(
                                                          isNewTag: 1,
                                                        )));
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width * .55,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(28),
                                              color: AppColor.textLightBlueBlack),
                                          child: Center(
                                            child:
                                                // Text(
                                                //   tr(LocaleKeys.additionText_activateqrpettg),
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //     color: Colors.white,
                                                //     fontFamily: AppFont.poppinsMedium,
                                                //     fontSize: 13.0,
                                                //   ),
                                                // ),

                                                RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                  text: tr(LocaleKeys.additionText_activateqrpettg),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w800),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        )
                      : const SizedBox(),

                  petProvider.SheildList == 4
                      ? Container(
                          width: MediaQuery.of(context).size.width * .80,
                          height: petProvider.selectedPetDetail?.microchip == ""
                              ? MediaQuery.of(context).size.height * .15
                              : MediaQuery.of(context).size.height * .10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 10),
                                child: Column(
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text: petProvider.selectedPetDetail?.microchip == ""
                                              ? tr(LocaleKeys.additionText_registerpetmicrochip)
                                              : tr(LocaleKeys.additionText_microchipregisterd),
                                          style: const TextStyle(
                                              color: AppColor.textLightBlueBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ]),
                                    ),
                                    const SizedBox(height: 15),
                                    petProvider.selectedPetDetail?.microchip == ""
                                        ? Center(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => const PetProfile()));
                                              },
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context).size.width * .55,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(28),
                                                    color: AppColor.textLightBlueBlack),
                                                child: Center(
                                                  child:

                                                      // Text(
                                                      //   tr(LocaleKeys.additionText_addmicrochip),
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.white,
                                                      //     fontFamily: AppFont.poppinsMedium,
                                                      //     fontSize: 13.0,
                                                      //   ),
                                                      // ),

                                                      RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: <TextSpan>[
                                                      TextSpan(
                                                        text: tr(LocaleKeys.additionText_addmicrochip),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.w800),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),

                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
