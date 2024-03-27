import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/app_route.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowAllPet extends StatefulWidget {
  const ShowAllPet({Key? key}) : super(key: key);

  @override
  State<ShowAllPet> createState() => _ShowAllPetState();
}

class _ShowAllPetState extends State<ShowAllPet> {
  late PetProvider provider;
  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    provider.getAllPet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomCurvedAppbar(
        title: tr(LocaleKeys.home_myPets),
        isTitleCenter: true,
      ),
      //  customAppbar(
      //   titlename: tr(LocaleKeys.home_myPets),
      // ),
      // bottomNavigationBar: BotttomBorder(context),
      body: Consumer<PetProvider>(builder: (context, data, child) {
        return data.petDetailList.isEmpty
            ? Center(
                child: Text(
                  tr(LocaleKeys.home_noPetFound),
                  style: const TextStyle(
                      fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: GridView.builder(
                    itemCount: data.petDetailList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 160,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 9,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      String userPets = "";
                      String name = data.petDetailList[index].ownerName ?? "";
                      if (name.isNotEmpty) {
                        try {
                          userPets = "${name.split(" ")[0]}'s Pet";
                        } catch (e) {
                          userPets = data.petDetailList[index].ownerName ?? "" "Pets";
                        }
                      } else {
                        userPets = "Shared pets";
                      }

                      bool isSharedPet = data.petDetailList[index].isJoinPet ?? false;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 5, right: 8, left: 8),
                        child: InkWell(
                          onTap: () {
                            data.setSelectedPetDetails(data.petDetailList[index]);
                            Navigator.pushNamed(context, AppScreen.petDashboard);
                          },
                          child: Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width * .45,
                              decoration: BoxDecoration(
                                color: AppColor.textFieldGrey,
                                borderRadius: BorderRadius.circular(4.0),
                                //  color: Colors.red
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // isSharedPet ?   Text("shared Pet"):SizedBox(),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(44),
                                        ),
                                        height: 88,
                                        width: 88,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(44),
                                          child: CachedNetworkImage(
                                            imageUrl: data.petDetailList[index].petPhoto ?? "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                AppImage.placeholderIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                AppImage.placeholderIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      isSharedPet
                                          ? Container(
                                              height: 19,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                child: Text(userPets,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xff2A3C6A),
                                                        fontFamily: AppFont.poppinsMedium)),
                                              ))
                                          : const SizedBox(),
                                      Text(
                                        data.petDetailList[index].petName ?? "",
                                        style: const TextStyle(fontSize: 15, fontFamily: AppFont.poppinSemibold),
                                      )
                                    ],
                                  )),
                                  Positioned(
                                      right: 10,
                                      top: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          // petProvider.setSelectedPetDetails(petList[index]);
                                          // Navigator.pushNamed(context, AppScreen.petDashboard);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: AppColor.buttonPink,
                                          ),
                                          // height: 22,
                                          // width: 22,
                                          child: const Icon(
                                            Icons.home_outlined,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      );
                    }),
              );
      }),
    );
  }
}
