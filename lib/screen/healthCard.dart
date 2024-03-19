import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/generated/locale_keys.g.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/createHealthCard.dart';
import 'package:find_me/screen/viewHealthCard.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';

class HealthCard extends StatefulWidget {
  int? selPage;
   HealthCard({Key? key,this.selPage}) : super(key: key);

  @override
  State<HealthCard> createState() => _HealthCardState();
}

class _HealthCardState extends State<HealthCard>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    PetProvider petProvider=Provider.of(context,listen: false);
    petProvider.setTabController(_tabController);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
floatingActionButton: BotttomBorder(context),

      appBar: customAppbar(
        isbackbutton: true,
        titlename: tr(LocaleKeys.additionText_hlthCrd),
      ),
      // bottomNavigationBar: BotttomBorder(context),Create tr(LocaleKeys.additionText_View)

      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(


              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,

              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    height: 120,
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
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(tr(LocaleKeys.additionText_Create)),
                                  ),
                                ),
                            Tab(
                              child: Align(
                              alignment: Alignment.center,
                              child: Text(tr(LocaleKeys.additionText_View)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              body:TabBarView(
                controller: _tabController,
                children: [
                  CreateHealthCard(),
                  ViewHealthCard(),
                ],
              ) ,

            ),
          ),
        ),
      ),

    );


  }
}
