import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:find_me/screen/add_managment.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../components/bottomBorderComp.dart';
import '../../generated/locale_keys.g.dart';
import '../../models/family_member_model.dart';
import '../../screen/viewPremium.dart';
import '../../services/hive_handler.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import 'buyPremium.dart';

class FamilyPlan extends StatefulWidget {
  const FamilyPlan({Key? key}) : super(key: key);

  @override
  State<FamilyPlan> createState() => _FamilyPlanState();
}

class _FamilyPlanState extends State<FamilyPlan> {
  late AchievementProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    provider.getPremiumUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotttomBorder(context),
      backgroundColor: Colors.white,
      appBar: customAppbar(
        isbackbutton: true,
        titlename: tr(LocaleKeys.additionText_famMember),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: customBlueButton(
            context: context,
            text1: tr(LocaleKeys.additionText_viewPln),
            onTap1: () {

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ViewPremium();
                },
              ));
            },
            colour: AppColor.newBlueGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${HiveHandler.getUser()?.name ?? ""} ${tr(LocaleKeys.additionText_family)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    color: AppColor.textLightBlueBlack,
                    fontFamily: AppFont.poppinsBold),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Expanded(
              child: Consumer<AchievementProvider>(
                  builder: (context, data, child) {
                print("data.premiumUser ${data.premiumUser.length}");
                return data.listLoader
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : data.premiumUser.isNotEmpty
                        ? GridView.builder(
                            itemCount: data.premiumUser.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 160,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 9,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              print("index is ${index}");
                              print(
                                  " manualIndex is ${data.premiumUser.length}");
                              int manualIndex = 0;
                              if (index >= 0 &&
                                  data.premiumUser.length > index) {
                                manualIndex = index;
                              }
                              print("premium user ${manualIndex}");
                              // print("index value ${index}");
                              // print("last index ${data.premiumUser.length}");
                              int lastIndex = data.premiumUser.length;
                              Premium premium = data.premiumUser[manualIndex];
                              return !(index < lastIndex)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 22.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print(
                                                  "tap isFormAddFamilyMember");
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return AddJoinManagement(
                                                    isFormAddFamilyMember: true,
                                                  );
                                                },
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColor.textFieldGrey,
                                                  shape: BoxShape.circle
                                                  // borderRadius: BorderRadius.circular(40)
                                                  ),
                                              height: 80,
                                              width: 80,
                                              child: Image.asset(
                                                  AppImage.plusIcon),
                                            ),
                                          ),
                                          Text(
                                            "",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black,
                                                fontFamily:
                                                    AppFont.poppinSemibold),
                                          )
                                        ],
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        print(
                                            " premium.isNotJoint ==  ${premium.isNotJoint == "1"}");
                                        shoowSureDeleteDialog(
                                            isJoinMangemnt:
                                                premium.isNotJoint == "1",
                                            id: premium.id ?? 0,
                                            index: manualIndex);
                                      },
                                      child: Container(
                                        height: 140,
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: CachedNetworkImage(
                                                        imageUrl: premium
                                                                .profileImage ??
                                                            "",
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Image.asset(
                                                          AppImage.jamesImage,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          AppImage.jamesImage,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 70.0,
                                                    top: 5,
                                                    child: InkWell(
                                                      child: ClipRRect(
                                                        child: Image.asset(
                                                            AppImage
                                                                .premiumIcon),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: 100,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${premium.name}",
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: AppColor
                                                            .textLightBlueBlack,
                                                        fontFamily: AppFont
                                                            .poppinSemibold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                            },
                          )
                        : Column(
                            children: [
                              Image.asset(
                                AppImage.planPlaceHolder,
                                height: 200,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   "You can share premium membership with your family member",
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.w800,
                              //       fontFamily: AppFont.poppinsRegular),
                              // ),

                              RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:  tr(LocaleKeys.additionText_cnShrPreWithFamMem),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.poppinsRegular,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,


                                      ),

                                    ),
                                    TextSpan(
                                      //additionText_max4Mem
                                      text: tr(LocaleKeys.additionText_max4Mem),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),

                                    ),

                                  ]

                              )
                              ),








                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  print("tap isFormAddFamilyMember");
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return AddJoinManagement(
                                        isFormAddFamilyMember: true,
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.textFieldGrey,
                                      shape: BoxShape.circle
                                      // borderRadius: BorderRadius.circular(40)
                                      ),
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(AppImage.plusIcon),
                                ),
                              ),
                              Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontFamily: AppFont.poppinSemibold),
                              )
                            ],
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shoowSureDeleteDialog(
      {bool isJoinMangemnt = false, int id = 0, int index = 0}) async {
    print("delete user");
    return showDialog(
        context: context,
        builder: (ctx) {
          return Container(
            width: MediaQuery.of(context).size.height * 0.2,
            child: AlertDialog(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.transparent)),
              titlePadding: EdgeInsets.zero,
              actionsAlignment: MainAxisAlignment.start,
              actionsPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  isJoinMangemnt
                      ? Text(
                    tr(LocaleKeys.additionText_wntDeleUrsFrmFamMemJntMgt),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: AppColor.textLightBlueBlack,
                              fontFamily: AppFont.poppinSemibold),
                        )
                      : Text(
                      tr(LocaleKeys.additionText_wntDeleUrsFrmFamMem),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: AppColor.textLightBlueBlack,
                              fontFamily: AppFont.poppinSemibold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customBlueButton(
                            context: context,
                            text1:  tr(LocaleKeys.additionText_cancel),
                            onTap1: () {
                              Navigator.pop(context);
                            },
                            colour: AppColor.newGrey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customBlueButton(
                            context: context,
                            text1: tr(LocaleKeys.additionText_Delete),
                            onTap1: () {
                              context
                                  .read<AchievementProvider>()
                                  .respondpremiumUser(
                                    id,
                                      3,
                                    // 4,
                                    context,
                                    index,
                                  ).then((value) {
                                 
                                  });
                            },
                            colour: AppColor.newGrey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
