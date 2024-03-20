import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/tagContainer.dart';
import 'package:find_me/models/tagDetailModel.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/sampleScreen.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/camPermissionAlert.dart';
import '../components/commingSoonAlert.dart';
import '../components/scannerPermission.dart';
import '../generated/locale_keys.g.dart';
import '../provider/purchase_provider.dart';

class TagList extends StatefulWidget {
  const TagList({Key? key}) : super(key: key);

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  int i = 0;
  var loginUser = HiveHandler.getUserHiveRefresher().value.values.first;

  int isAddMoreTag = 0;
  @override
  void initState() {
    PurChaseProvider purChaseProvider = Provider.of(context, listen: false);
    PetProvider petProvider = Provider.of(context, listen: false);
    petProvider.openOnce = 0;
    if (purChaseProvider.plan.isNotEmpty) {
      print("purChaseProvider.plan[0]====${purChaseProvider.plan[0]}");
      isAddMoreTag = purChaseProvider.plan[0];
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurChaseProvider>(builder: (context, pur, child) {
      return Scaffold(
          appBar: customAppbar(
            isbackbutton: true,
            titlename: tr(LocaleKeys.additionText_tgs),
          ),
          bottomNavigationBar: BotttomBorder(context),
          backgroundColor: Colors.white,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton:
              // loginUser.isPremium == 1 &&
              //         (isAddMoreTag == 1 || isAddMoreTag == 2)
              //     ?
              Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                          backgroundColor: AppColor.newBlueGrey,
                          onPressed: () async {
                            PetProvider petProvider = Provider.of(context, listen: false);

                            var status3 = await Permission.camera.status;

                            print("value of status===>>> $status3");

                            if (!status3.isGranted) {
                              print("iiiiii==>$i");
                              i = i + 1;
                              if (i > 1) {
                                scannerPermissionDialog(context);
                              }

                              if (i <= 1) {
                                await Permission.camera.request();
                              }
                            }
                            var status4 = await Permission.camera.status;

                            print("value of status  4 is===>>> $status4");
                            if (status4.isGranted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScannerScreen(
                                            isNewTag: 1,
                                          )));
                            }

                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen(isNewTag: 1,)));
                          },
                          child: const Icon(Icons.add)),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Add More\n QR Tags",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )),
          // : SizedBox(),
          body: Consumer<PetProvider>(builder: (context, petProvider, child) {
            List<TagDetails> QrTagList = petProvider.qrTagList;
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                  // itemCount: 2,
                  itemCount: QrTagList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                      child: InkWell(
                          onTap: () {
                            petProvider.setSelectedQrTag(QrTagList[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScannerScreen(
                                          isNewTag: 0,
                                        )));
                          },
                          child: TagContainer(context, QrTagList[index])),
                    );
                  }),
            );
          }));
    });
  }
}
