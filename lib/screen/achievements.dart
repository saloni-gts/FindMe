import 'package:easy_localization/easy_localization.dart';
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
        return await true;
      },
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAchieven(),
                          ));
                    },
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff2A3C6A),
                      ),
                      child: Image.asset(
                        AppImage.plusIcon,
                        color: Colors.white,
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),
              
              BotttomBorder(context)
              // Text("Add \n Achievement"),
            ],
          ),
          backgroundColor: Colors.white,
          // bottomNavigationBar: BotttomBorder(context),
          appBar: customAppbar(
              customBack: (() {
                if (widget.isNavigate) {
                  Navigator.pop(context);
                }
                Navigator.pop(context);
              }),
              isbackbutton: true,
              titlename: tr(LocaleKeys.additionText_achievements)),
          body: Consumer<AchievementProvider>(builder: (context, value, child) {
            print("list loader ${value.listLoader}");
            return value.listLoader
                ? Center(
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
                        child:Text(
                        tr(LocaleKeys.additionText_noAcheveFnd),
                        style: TextStyle(
                            fontSize: 18.0,
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinSemibold),
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
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              color: Color(0xffF7F7F7)),
          child: Center(
            child: ListTile(
              horizontalTitleGap: 0.0,
              visualDensity: VisualDensity(horizontal: 0.0),
              minLeadingWidth: 38,
              leading: Image.asset(
                AppImage.achievements,
                height: 32,
                width: 32,
              ),
              title: Text(
                "${achievement.title}",
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff2A3C6A),
                    fontSize: 15,
                    fontFamily: AppFont.poppinsMedium),
              ),
              subtitle: Text(
                "${achievement.description}",
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff777777),
                    fontSize: 10,
                    fontFamily: AppFont.poppinsRegular),
              ),
              trailing: Image.asset(AppImage.nextArrow),
            ),
          )
      ),
    );
  }
}
