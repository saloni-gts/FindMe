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
  @override
  void initState() {
    PetProvider petProvider1 = Provider.of(context, listen: false);
    petProvider1.clearContent();
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
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(color: AppColor.textFieldGrey, borderRadius: BorderRadius.circular(28)),
                    child: TabBar(
                      onTap: (vall) {
                        print("TAB INDEX $vall");
                        print("TAB INDEX Vallll ${_tabController.index}");
                      },
                      controller: _tabController,
                      unselectedLabelStyle: const TextStyle(fontSize: 16, fontFamily: AppFont.poppinsMedium),
                      labelStyle: const TextStyle(fontSize: 16, fontFamily: AppFont.poppinsMedium),
                      unselectedLabelColor: const Color(0xffCBC4A9),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: AppColor.newBlueGrey,
                        // AppColor.textRed,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(tr(LocaleKeys.addPet_shortForm)),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(tr(LocaleKeys.addPet_fullForm)),
                          ),
                        ),
                      ],
                    ),
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
}
