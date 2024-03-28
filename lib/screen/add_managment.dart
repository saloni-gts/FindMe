import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/components/custom_button.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../components/bottomBorderComp.dart';
import '../components/cntryyPikrrComp.dart';
import '../components/jntMgtCntrPikr.dart';
import '../generated/locale_keys.g.dart';
import '../provider/authprovider.dart';
import '../util/color.dart';

class AddJoinManagement extends StatefulWidget {
  final bool isFormAddFamilyMember;

  const AddJoinManagement({Key? key, this.isFormAddFamilyMember = false})
      : super(key: key);

  @override
  State<AddJoinManagement> createState() => _AddJoinManagementState();
}

class _AddJoinManagementState extends State<AddJoinManagement> {
  late AchievementProvider provider;
  late AuthProvider authProvider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    authProvider = Provider.of(context, listen: false);
    authProvider.jntMgtphncod="44";


    provider.updateAsFamilyMember(widget.isFormAddFamilyMember ? true : false,
        widget.isFormAddFamilyMember ? false : true);
    super.initState();
  }

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: BotttomBorder(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: customAppbar(
        isbackbutton: true,
        titlename: widget.isFormAddFamilyMember
            ? tr(LocaleKeys.additionText_invteFamMem)
            : tr(LocaleKeys.additionText_addJntMgt),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                 tr(LocaleKeys.additionText_mobNum),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: AppFont.poppinsMedium,
                      color: Color(0xff2A3C6A)),
                ),
              ),
              SizedBox(
                height: 10,
              ),



              // CntrePikr(phoneNumController: phoneController),
              JntMgtCntrePikr(phoneNumController: phoneController,),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                 tr(LocaleKeys.additionText_thisMobAlrdyReg),
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: AppFont.poppinsMedium,
                      color: Color(0xff2A3C6A)),
                ),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Consumer<AchievementProvider>(
                            builder: (context, data, child) {
                          return widget.isFormAddFamilyMember
                              ? Checkbox(
                                  activeColor: AppColor.textLightBlueBlack,
                                  // toggleable: true,
                                  value: data.isAsJoinManagment,
                                  // groupValue: ,
                                  onChanged: (value) {
                                    print("values is ${value}");

                                    data.updateAsFamilyMember(true,
                                        value != null ? value as bool : false);
                                    //selected value
                                  })
                              : Checkbox(
                                  activeColor: AppColor.textLightBlueBlack,
                                  // toggleable: true,
                                  value: data.isAsFamilyMember,
                                  // groupValue: ,
                                  onChanged: (value) {
                                    print("values is ${value}");

                                    data.updateAsFamilyMember(
                                        value != null ? value as bool : false,
                                        true);
                                    //selected value
                                  });
                        }),
                      ),
                      Expanded(
                        flex: 9,
                        child: widget.isFormAddFamilyMember
                            ? Text(
                          tr(LocaleKeys.additionText_disPerMngYrPet),
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff2A3C6A),
                                    fontFamily: AppFont.poppinSemibold),
                              )
                            : Text(
                          tr(LocaleKeys.additionText_wntToAddAsFamMeb),
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff2A3C6A),
                                    fontFamily: AppFont.poppinSemibold),
                              ),
                      )
                    ],
                  ),
                  Consumer<AuthProvider>(
                    builder: (context,authPro,child) {
                      return CustomButton(
                          // context: context,
                          text:   tr(LocaleKeys.additionText_capReq),
                          onPressed: () {
                            print("tab working");
                            // print("ph code val new ===>>${authProvider.jntMgtphncode}");
                            print("ph code val old ===>>${authProvider.jntMgtphncod}");

                            provider.callSendRequest(authPro.jntMgtphncod, phoneController.text.toString(), context);
                            // authProvider.jntMgtphncod="44";

                            // phoneController.clear();


                          },
                         );
                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
