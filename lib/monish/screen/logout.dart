import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';


import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../components/newPreview.dart';
import '../../generated/locale_keys.g.dart';
import '../../util/app_font.dart';
import '../../util/app_images.dart';
import '../../util/app_route.dart';

import '../models/newModel.dart';
import '../provider/myProvider.dart';
import '../reUseClass/custombluebutton.dart';
import '../reUseClass/myappbar.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
   List<LogoutModel> SettingPage = [];


   @override
  void initState() {
    
    SettingPage = [
      LogoutModel(
        title: tr(LocaleKeys.additionText_chanePassword),
        image: AssetImage(AppImage.change_icon),
        type: 0,
      ),
      // LogoutModel(
      //     title: 'Language',
      //     image: AssetImage(AppImage.language),
      //     type: 1),
      // LogoutModel(
      //     title: 'Measurement Units',
      //     image: AssetImage(AppImage.measurement),
      //     type: 2),
      LogoutModel(
          title: tr(LocaleKeys.additionText_deleteOwnerProfile),
          // tr(LocaleKeys.additionText_delOnrPro),
          image: AssetImage(AppImage.deleteblue),
          type: 3),

      LogoutModel(
          title: tr(LocaleKeys.additionText_changeLanguage),
          image: AssetImage(AppImage.languageIcon),
          type: 4),
    ];
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        titlename: tr(LocaleKeys.additionText_settings),

      ),


      // MycustomAppbar(
      //   titlename: "Settings",
      //   icon: false,
      // ),


      body: Consumer<Myprovider>(builder: (context, myprovider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 13, left: 22, right: 21),
            child: Column(
              children: [
                Container(
                  width: 332,
                  height: 176,
                  decoration: BoxDecoration(
                    color: AppColor.textFieldGrey,
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount:SettingPage.length,
                      itemBuilder: (context, index) {
                        final item = SettingPage[index];

                        return InkWell(
                          onTap: () async {
                            print("type is ${item.type}");
                            if (item.type == 1) {
                              Navigator.pushNamed(
                                  context, AppScreen.ownerprofile);
                            }
                          },

                          child: ListTile(
                            horizontalTitleGap: -5,
                            leading: Container(
                                height: 18,
                                width: 18,
                                child: Image(
                                  image: item.image,
                                )
                            ),
                            title: Text(
                                item.title.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppFont.poppinsRegular,
                                    color: AppColor.textLightBlueBlack)
                            ),
                          ),

                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 360),
                  child: mycustomBlueButton(
                      height: false,
                      context: context,
                      text1: tr(LocaleKeys.moreFeatures_logout),
                      onTap1: () {},
                      border1: false,
                      putheight: 56.0,
                      width: 220.0,
                      colour: AppColor.buttonRedColor),
                )
              ],
            ),
          ),
        );
      }),
      // bottomNavigationBar: BotttomBorder(context),




    );
  }
}
