import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/models/verified_list_api_model.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../components/appbarComp.dart';
import '../components/bottomBorderComp.dart';
import '../generated/locale_keys.g.dart';
import '../monish/reUseClass/myappbar.dart';
import '../util/app_font.dart';
import '../util/color.dart';
import 'add_managment.dart';

class JoinManagement extends StatefulWidget {
  bool navigateToSecondPage;
  bool isNavigate;
  JoinManagement(
      {Key? key, this.navigateToSecondPage = false, this.isNavigate = false})
      : super(key: key);

  @override
  State<JoinManagement> createState() => _JoinManagmentState();
}

class _JoinManagmentState extends State<JoinManagement>
    with SingleTickerProviderStateMixin {
  late AchievementProvider provide;
  late final _tabController = TabController(length: 2, vsync: this);
  @override
  void initState() {
    provide = Provider.of(context, listen: false);
    provide.callVerifiedList();
    if (widget.navigateToSecondPage) {
      _tabController.animateTo(1);
    }


    // provide.setTabContAch()

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("value of isNavigate ${widget.isNavigate}");
    return WillPopScope(
      onWillPop: () async {
        if (widget.isNavigate) {
          Navigator.pop(context);
        }
        Navigator.pop(context);
        return await true;
      },
      child: Scaffold(
        bottomNavigationBar: BotttomBorder(context),
        appBar: MycustomAppbar(
          customBack: (() {
            if (widget.isNavigate) {
              Navigator.pop(context);
            }
            Navigator.pop(context);
          }),
          tap2: () {
            print("tap called");
          },
          icon: false,
          //additionText_PndingReq
          titlename: tr(LocaleKeys.additionText_PndingReq),
          isbackbutton: true,

          // seticon: AppImage.filtericon,
        ),
        body: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          // floatingActionButton:
          // Consumer<PurChaseProvider>(
          //   builder: (context,data,child) {
          //     return data.userIsPremium ?
          //     InkWell(
          //       onTap: () {
          //         Navigator.push(context, MaterialPageRoute(
          //           builder: (context) {
          //             return AddJoinManagement();
          //           },
          //         ));
          //       },
          //       child: Container(
          //         height: 56,
          //         width: 56,
          //         decoration: BoxDecoration(
          //             color: Color(0xff2A3C6A), shape: BoxShape.circle),
          //         child: Center(
          //           child: Image.asset(
          //             AppImage.plusIcon,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ):SizedBox();
          //   }
          // ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 56,
                    child: TabBar(
                      onTap: (vall) {
                        print("TAB INDEX $vall");
                        print("TAB INDEX Vallll ${_tabController.index}");
                      },
                      controller: _tabController,
                      unselectedLabelStyle: TextStyle(
                          fontSize: 16, fontFamily: AppFont.poppinsMedium),
                      labelStyle: TextStyle(
                          fontSize: 16, fontFamily: AppFont.poppinsMedium),
                      unselectedLabelColor: AppColor.textLightBlueBlack,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: AppColor.textRed,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      tabs: [
                        // Tab(
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: Center(child: Text(tr(LocaleKeys.additionText_ppl))),
                        //   ),
                        // ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(child: Text(tr(LocaleKeys.additionText_pndin))),
                          ),
                        ),

                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(child: Text(tr(LocaleKeys.additionText_ppl))),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 2,
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                // acceptedView(),
                pendingView(),
                acceptedView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget acceptedView() {
    return Consumer<AchievementProvider>(builder: (context, data, child) {
      List<Verified> verifiedList = data.peopleList;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: verifiedList.isNotEmpty
            ? ListView.builder(
                itemCount: verifiedList.length,
                itemBuilder: (context, index) {
                  String subTitle = "";
                  print("type values ${verifiedList[index].typeValues}");
                  if (verifiedList[index].isPremium == 1 &&
                      verifiedList[index].isNotJoint == "1") {
                    if (verifiedList[index].typeValues == 4) {
                      subTitle =

                         tr(LocaleKeys.additionText_UMngTrPetAddAsFamMem);
                    } else {
                      subTitle =
                          tr(LocaleKeys.additionText_CnMngYrPetShrPreReq);
                    }
                  } else if (verifiedList[index].isPremium == 1) {
                    subTitle =  tr(LocaleKeys.additionText_ShrPreReq);
                  } else if (verifiedList[index].isNotJoint == "1") {
                    if (verifiedList[index].typeValues == 4) {
                      subTitle =tr(LocaleKeys.additionText_uMngTrePets);
                    } else {
                      subTitle = tr(LocaleKeys.additionText_cnMngYrPets);
                    }
                  }
                  return Container(
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF7F7F7)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: AppColor.textFieldGrey),
                              // height: 42,
                              // width: 42,
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      verifiedList[index].profileImage ?? "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.account_circle),
                                  ),
                                  errorWidget: (context, url, error) => Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(Icons.account_circle)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    verifiedList[index].name ?? "",
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Color(0xff2A3C6A),
                                        fontSize: 15,
                                        fontFamily: AppFont.poppinsMedium),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    subTitle,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Color(0xff2A3C6A),
                                        fontSize: 10,
                                        fontFamily: AppFont.poppinsMedium),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () async {
                              /// 1
                              await data.callRequestFunction(
                                  verifiedList[index].id ?? 0,
                                  verifiedList[index].typeValues == 4 ? 5 : 3,
                                  index);
                            },
                            child: Container(
                              height: 32,
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: AppColor.textRed,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: verifiedList[index].typeValues == 4
                                    ? Text(
                                     tr(LocaleKeys.additionText_leave),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: AppFont.poppinSemibold),
                                      )
                                    : Text(
                                       tr(LocaleKeys.additionText_remove),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: AppFont.poppinSemibold),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text(tr(LocaleKeys.additionText_noAccAttatch),
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: AppColor.textLightBlueBlack,
                      fontFamily: AppFont.poppinSemibold),

                ),
              ),
      );
    });
  }

  Widget pendingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<AchievementProvider>(builder: (context, data, child) {
        return data.finalList.isNotEmpty
            ? ListView.builder(
                itemCount: data.finalList.length,
                itemBuilder: (context, index) {
                  String subTitle = "";
                  Verified verified = data.finalList[index];
                  print("type values ${verified.typeValues}");
                  if (verified.isPremium == 1 && verified.isNotJoint == "1") {
                    subTitle =
                        "Joint managment and share premium membership request";
                  } else if (verified.isPremium == 1) {
                    subTitle = "Share premium membership request";
                  } else if (verified.isNotJoint == "1") {
                    subTitle = "Joint Managment request";
                  }
                  return Container(
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF7F7F7)),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: AppColor.textFieldGrey),
                                  // height: 42,
                                  // width: 42,
                                  //
                                  height: 50,
                                  width: 50,

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      imageUrl: verified.profileImage ?? "",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Icon(Icons.account_circle),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child:
                                                  Icon(Icons.account_circle)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${verified.name} ",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color(0xff2A3C6A),
                                            fontSize: 15,
                                            fontFamily: AppFont.poppinsMedium),
                                      ),
                                      Text(
                                        "$subTitle ",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color(0xff2A3C6A),
                                            fontSize: 10,
                                            fontFamily: AppFont.poppinsMedium),






                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                verified.typeValues != 3
                                    ? InkWell(
                                        onTap: () async {
                                          await data.callRequestFunction(
                                              verified.id ?? 0, 2, index,
                                              isNavigateToPet: verified.isPremium == 1 && verified.isNotJoint == "0");
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff941C1B)),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          await data.callRequestFunction(
                                              verified.id ?? 0, 4, index,isNavigateToPet: verified.isPremium == 1 && verified.isNotJoint == "0");
                                        },
                                        child: Container(
                                            height: 32,
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: AppColor.textRed,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Center(
                                              child: Text(
                                         tr(LocaleKeys.additionText_cancel),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily:
                                                        AppFont.poppinSemibold),
                                              ),
                                            )),
                                      ),
                                SizedBox(
                                    width: verified.typeValues == 1 &&
                                            verified.typeValues != 3
                                        ? 10
                                        : 0),
                                verified.typeValues == 1 &&
                                        verified.typeValues != 3
                                    ? InkWell(
                                        onTap: () async {
                                          await data.callRequestFunction(
                                              verified.id ?? 0, 1, index,isNavigateToPet: verified.isPremium == 1 && verified.isNotJoint == "0");
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff2A3C6A)),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            )),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text( tr(LocaleKeys.additionText_noPendReqFnd),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: AppColor.textLightBlueBlack,
                      fontFamily: AppFont.poppinSemibold),

                ),
              );
      }),
    );
  }
}
