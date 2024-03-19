import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../components/appbarComp.dart';
import '../components/bottomBorderComp.dart';
import '../generated/locale_keys.g.dart';
import '../models/achievement_model.dart';
import 'add_achieve.dart';

class ViewAchievements extends StatefulWidget {
  final int id;
  const ViewAchievements({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewAchievements> createState() => _ViewAchievementsState();
}

class _ViewAchievementsState extends State<ViewAchievements> {
  late AchievementProvider provider;
  late PetProvider petProvier;
  AchievementModel? achievementModel;
  String imgUrl = "";
  String description = "";

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    petProvier = Provider.of(context, listen: false);
    provider.updateFiles("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BotttomBorder(context),
      appBar: customAppbar(
          isbackbutton: true,
          titlename: tr(LocaleKeys.additionText_achievements),
          isEditIcon: true,
          tap2: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddAchieven(
                          achievementModel: achievementModel,
                        )));
            // print("achievementModel ${achievementModel?.title}");
            // print("hello tap working");
          }),
      body: FutureBuilder<AchievementModel>(
          future: provider.callGetAchievement(widget.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text(
                    tr(LocaleKeys.additionText_noDataFbd),
                    style: const TextStyle(
                        fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                  ),
                );
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  achievementModel = snapshot.data;
                  imgUrl = snapshot.data?.images ?? "";
                  String content = snapshot.data?.description ?? "";
                  description = snapshot.data?.title ?? "\n$content";
                  provider.updateFiles(imgUrl);
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          height: 170,
                          width: 240,
                          decoration:
                              BoxDecoration(color: AppColor.textFieldGrey, borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data?.images ?? "",
                              fit: BoxFit.cover,
                              height: 170,
                              width: 240,
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Image.asset(
                                  AppImage.achievePlaceholder,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              errorWidget: (context, url, error) => Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Image.asset(
                                  AppImage.achievePlaceholder,
                                  // fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            snapshot.data?.title ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xff2A3C6A), fontSize: 15, fontFamily: AppFont.poppinsMedium),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            snapshot.data?.description ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xff777777), fontSize: 10, fontFamily: AppFont.poppinsRegular),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: customBlueButton(
                              context: context,
                              text1: tr(LocaleKeys.additionText_capShare),
                              onTap1: () async {
                                await urlFileShare(imgUrl, description);
                              },
                              colour: const Color(0xff2A3C6A)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      tr(LocaleKeys.additionText_noDataFbd),
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColor.textLightBlueBlack, fontFamily: AppFont.poppinSemibold),
                    ),
                  );
                }
            }
          }),
    );
  }

  Future urlFileShare(String url, String desc) async {
    final RenderObject? box = context.findRenderObject();
    Directory? documentDirectory;
    try {
      EasyLoading.show();
      var response = await get(Uri.parse(url));
      if (Platform.isAndroid) {
        // var url = 'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg';

        documentDirectory = await getExternalStorageDirectory();
      } else {
        documentDirectory = await getApplicationDocumentsDirectory();
      }
      File imgFile = File('${documentDirectory!.path}/flutter.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      await Share.shareFiles([File('${documentDirectory.path}/flutter.png').path],
              subject: 'Achievement File Share', text: desc, sharePositionOrigin: Rect.zero)
          .whenComplete(() {
        EasyLoading.dismiss();
      });
    } catch (e) {}
  }
}
