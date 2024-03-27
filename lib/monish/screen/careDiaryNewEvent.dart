import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/notesContainer.dart';
import 'package:find_me/monish/screen/newNote.dart';
import 'package:find_me/screen/deleteNotes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/commingSoonAlert.dart';
import '../../components/customBlueButton.dart';
import '../../components/shortpage.dart';
import '../../generated/locale_keys.g.dart';
import '../../provider/petprovider.dart';
import '../../screen/LogoutPage.dart';
import '../../screen/calenderPage.dart';
import '../../screen/dashboard.dart';
import '../../screen/home.dart';
import '../../util/app_font.dart';
import '../../util/app_route.dart';
import '../../util/appstrings.dart';
import '../../util/color.dart';
import '../reUseClass/myappbar.dart';
import 'myCalendar.dart';

class EventCalender extends StatefulWidget {
  bool isShowBackIcon;
  bool isBottomBorder;
  bool isFromPet;
  EventCalender({Key? key, this.isShowBackIcon = true, this.isBottomBorder = true, this.isFromPet = true})
      : super(key: key);

  @override
  State<EventCalender> createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    print("frompet==== ? = ${widget.isFromPet}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MycustomAppbar(
        tap2: () {
          PetProvider petProvider = Provider.of(context, listen: false);

          // petProvider.greenTickList.clear();

          // petProvider.greenTickList=petProvider.petIdList;
          // fliterPetDailog(context: context);
        },
        icon: false,
        titlename: tr(LocaleKeys.home_careDiary),
        isbackbutton: widget.isShowBackIcon ? true : false,
        // seticon: AppImage.filtericon,
      ),

      // bottomNavigationBar: widget.isBottomBorder ? BotttomBorder(context) : const SizedBox(),

      // bottomNavigationBar: BotttomBorder(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 21, left: 15, right: 15),
        child: Scaffold(
          // bottomNavigationBar: widget.isBottomBorder ? BotttomBorder(context) : SizedBox(),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(color: AppColor.textFieldGrey, borderRadius: BorderRadius.circular(28)),
              height: 56,
              child: TabBar(
                onTap: (vall) {
                  print("TAB INDEX $vall");
                  print("TAB INDEX Vallll ${_tabController.index}");
                },
                controller: _tabController,
                unselectedLabelStyle: const TextStyle(fontSize: 16, fontFamily: AppFont.poppinsMedium),
                labelStyle: const TextStyle(fontSize: 16, fontFamily: AppFont.poppinsMedium),
                unselectedLabelColor: AppColor.textLightBlueBlack,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColor.newBlueGrey,
                  borderRadius: BorderRadius.circular(28),
                ),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(tr(LocaleKeys.petCare_events)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(tr(LocaleKeys.petCare_notes)),
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
                Calender(val: 0, frmpet: widget.isFromPet ? true : false),
                Notes(val: 1, fromPet: widget.isFromPet ? 1 : 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Notes extends StatefulWidget {
  int? fromPet;
  Notes({Key? key, required int val, required this.fromPet}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    petProvider.callGetNotes();
    print("==>>==>>==>> ${widget.fromPet}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(builder: (context, petProvider, child) {
      List petNoteLst = petProvider.notesList;
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton:
            // petProvider.notesList.length>=2 && petProvider.isUserPremium==0 ? SizedBox():
            Padding(
                padding: const EdgeInsets.only(bottom: 17.0, right: 2),
                child: FloatingActionButton(
                    backgroundColor: AppColor.newBlueGrey,
                    onPressed: () {
                      PetProvider petProvider = Provider.of(context, listen: false);

                      if (petProvider.petDetailList.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                    child: ConnectivityResult == ConnectivityResult.none
                                        ? Text(tr(LocaleKeys.additionText_chkNet))
                                        : Text(tr(LocaleKeys.home_noPetFound))),
                                actions: <Widget>[
                                  InkWell(
                                    child: Text(
                                      tr(LocaleKeys.additionText_dismiss),
                                      style: const TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
                                    ),
                                    onTap: () {
                                      print("connectivity status:::::::$ConnectivityResult");
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        if (petProvider.notesList.length >= 2 && petProvider.isUserPremium == 0) {
                          commingSoonDialog(context, isFullAccess: 1);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewNote(isFromPet: widget.fromPet == 1 ? true : false)));
                        }
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ))),
        backgroundColor: Colors.white,
        body: Center(
          // child: Text(AppStrings.preFeSoon,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 16.0,
          //     color: AppColor.textLightBlueBlack,
          //     fontFamily: AppFont.poppinsBold,
          //   ),
          // ),

          child: petNoteLst.isEmpty
              ? Text(
                  tr(LocaleKeys.additionText_noNotesFnd),
                  style:
                      const TextStyle(fontSize: 18.0, color: AppColor.newBlueGrey, fontFamily: AppFont.poppinSemibold),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: ListView.builder(
                      itemCount: petNoteLst.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              PetProvider petProvider = Provider.of(context, listen: false);
                              petProvider.setSelectedNotes(petNoteLst[index]);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteNotes()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: NotesContainer(context, petNoteLst[index]),
                            ));
                      },
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
