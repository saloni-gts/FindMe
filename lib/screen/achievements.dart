import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/models/achievement_model.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/view_achievements.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../components/appbarComp.dart';
import '../components/bottomBorderComp.dart';
import '../generated/locale_keys.g.dart';
import '../util/color.dart';
import 'add_achieve.dart';

class Achievement extends StatefulWidget {
  bool isNavigate = false;
  Achievement({Key? key, required this.isNavigate}) : super(key: key);

  @override
  State<Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  late AchievementProvider provider;
  late PetProvider petProvider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    petProvider = Provider.of(context, listen: false);
    provider.getAllAchievement(petProvider.selectedPetDetail?.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isNavigate) {
          Navigator.pop(context);
        }
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddAchieven(),
                            ));
                      },
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.buttonPink,
                        ),
                        child: Image.asset(
                          AppImage.plusIcon,
                          color: Colors.white,
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                // child: BotttomBorder(context),
              )
              // Text("Add \n Achievement"),
            ],
          ),
          backgroundColor: Colors.white,
          // bottomNavigationBar: BotttomBorder(context),
          appBar: CustomCurvedAppbar(
            title: tr(LocaleKeys.additionText_achievements),
            isTitleCenter: true,
          ),
          // customAppbar(
          //     customBack: (() {
          //       if (widget.isNavigate) {
          //         Navigator.pop(context);
          //       }
          //       Navigator.pop(context);
          //     }),
          //     isbackbutton: true,
          //     titlename: tr(LocaleKeys.additionText_achievements)) ,
          body: Consumer<AchievementProvider>(builder: (context, value, child) {
            print("list loader ${value.listLoader}");
            return value.listLoader
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : value.list.isNotEmpty
                    ? ListView.builder(
                        itemCount: value.list.length,
                        itemBuilder: (context, index) {
                          return view(value.list[index]);
                        },
                      )
                    : Center(
                        child: Text(
                          tr(LocaleKeys.additionText_noAcheveFnd),
                          style: const TextStyle(
                              fontSize: 18.0, color: AppColor.buttonPink, fontFamily: AppFont.poppinSemibold),
                        ),
                      );
          })),
    );
  }

  Widget view(AchievementModel achievement) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewAchievements(id: achievement.id ?? 0),
            ));
      },
      child: Container(
          height: 72,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), color: const Color(0xffF8EBED)),
          child: Center(
            child: ListTile(
              horizontalTitleGap: 0.0,
              visualDensity: const VisualDensity(horizontal: 0.0),
              minLeadingWidth: 38,
              leading: Image.asset(
                AppImage.achievements,
                height: 32,
                width: 32,
              ),
              title: Text(
                "${achievement.title}",
                maxLines: 1,
                style: const TextStyle(color: Color(0xff2A3C6A), fontSize: 15, fontFamily: AppFont.poppinsMedium),
              ),
              subtitle: Text(
                "${achievement.description}",
                maxLines: 1,
                style: const TextStyle(color: Color(0xff777777), fontSize: 10, fontFamily: AppFont.poppinsRegular),
              ),
              trailing: Image.asset(AppImage.nextArrow),
            ),
          )),
    );
  }
}
