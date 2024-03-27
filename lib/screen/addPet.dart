import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/shortpage.dart';
import '../generated/locale_keys.g.dart';
import '../services/hive_handler.dart';
import '../util/color.dart';

class AddPet extends StatefulWidget {
  const AddPet({Key? key}) : super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  int _currentIndex = 0;
  @override
  void initState() {
    PetProvider petProvider1 = Provider.of(context, listen: false);
    petProvider1.clearContent();
    // _tabController.addListener();
    _tabController.addListener(_handleTabSelection);
    print("_tabController--- ${_tabController.index}");
    super.initState();
  }

  var loginUser = HiveHandler.getUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BotttomBorder(context),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomCurvedAppbar(
        title: tr(LocaleKeys.addPet_addPet),
        isTitleCenter: true,
      ),
      //  customAppbar(titlename: tr(LocaleKeys.addPet_addPet)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.only(right: 3.0, top: 20),
                  child: Container(
                    child: InkWell(
                        onTap: () {
                          print("_tabController.index--   ${_tabController.index}");
                          if (_tabController.index == 0) {
                            _tabController.index = 1;
                          } else if (_tabController.index == 1) {
                            _tabController.index = 0;
                          }

                          print("_tabController.index after--   ${_tabController.index}");
                        },
                        child: _tabController.index == 0
                            ? const Text(
                                "Full Detail Form",
                                style: TextStyle(color: AppColor.buttonPink, fontFamily: AppFont.figTreeBold),
                              )
                            :  Text(
                                "Short Detail Form",
                                style: TextStyle(color: AppColor.buttonPink, fontFamily: AppFont.figTreeBold),
                              )),
                    // child: TabBar(
                    //   onTap: (vall) {
                    //     print("TAB INDEX $vall");
                    //     print("TAB INDEX Vallll ${_tabController.index}");
                    //   },
                    //   controller: _tabController,
                    //   unselectedLabelStyle: const TextStyle(fontSize: 16, fontFamily: AppFont.poppinsMedium),
                    //   labelStyle: const TextStyle(fontSize: 16, fontFamily: AppFont.poppinsMedium),
                    //   unselectedLabelColor: const Color(0xffCBC4A9),
                    //   indicatorSize: TabBarIndicatorSize.tab,
                    //   indicator: BoxDecoration(
                    //     color: AppColor.newBlueGrey,
                    //     // AppColor.textRed,
                    //     borderRadius: BorderRadius.circular(28),
                    //   ),
                    //   tabs: [
                    //     Tab(
                    //       child: Align(
                    //         alignment: Alignment.center,
                    //         child: Text(tr(LocaleKeys.addPet_shortForm)),
                    //       ),
                    //     ),
                    //     Tab(
                    //       child: Align(
                    //         alignment: Alignment.center,
                    //         child: Text(tr(LocaleKeys.addPet_fullForm)),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  PetShortPage(val: 0),
                  PetShortPage(val: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      print("this is calles");
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }
}
