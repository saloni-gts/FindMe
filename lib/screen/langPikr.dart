import 'package:find_me/common/change_lang.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/langContainer.dart';
import 'package:find_me/extension/app_language.dart';
import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';

import '../components/appbarComp.dart';
import '../util/app_font.dart';
import '../util/app_route.dart';
import '../util/color.dart';

class LangPicker extends StatefulWidget {
  final bool isFromStart;
  const LangPicker({Key? key, this.isFromStart = false}) : super(key: key);

  @override
  State<LangPicker> createState() => _LangPickerState();
}

class _LangPickerState extends State<LangPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(
        titlename: "",
        isbackbutton: false,
        //icon: false,
      ),
      bottomNavigationBar: BotttomBorder(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.0,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: widget.isFromStart
                    ? Text("PLEASE CHOOSE YOUR APP LANGUAGE",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, color: AppColor.textRed, fontFamily: AppFont.poppinsBold))
                    : Text("You Can Change Your App Language",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, color: AppColor.textRed, fontFamily: AppFont.poppinsBold)),
              ),
            ),

            SizedBox(
              height: 15.0,
            ),

            Center(
              child: Container(
                height: 250,
                child: Image.asset(
                  AppImage.newDog,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
                onTap: () async {
                  await changeLanguage(AppLanguage.english, context: context, isFromStart: widget.isFromStart);

                  if (widget.isFromStart) {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                  }
                },
                child: LangContainer(context, AppImage.unitedKingdom, "Continue in English")),

            InkWell(
                onTap: () async {
                  await changeLanguage(AppLanguage.french, context: context, isFromStart: widget.isFromStart);
                  if (widget.isFromStart) {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                  }
                },
                child: LangContainer(context, AppImage.france, "Continuer en français")),
            // InkWell(
            //     onTap: () {},
            //     child: LangContainer(
            //         context, AppImage.greece, "Συνέχεια στα ελληνικά")),
            InkWell(
                onTap: () async {
                  await changeLanguage(AppLanguage.spanish, context: context, isFromStart: widget.isFromStart);
                  if (widget.isFromStart) {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                  }
                },
                child: LangContainer(context, AppImage.spain, "Continuar en español")),
            InkWell(
                onTap: () async {
                  await changeLanguage(AppLanguage.ukraninian, context: context, isFromStart: widget.isFromStart);
                  if (widget.isFromStart) {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                  }
                },
                child: LangContainer(context, AppImage.ukraine, "Weiter auf Deutsch")),
            InkWell(
                onTap: () async {
                  await changeLanguage(AppLanguage.german, context: context, isFromStart: widget.isFromStart);
                  if (widget.isFromStart) {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                  }
                },
                child: LangContainer(context, AppImage.germany, "Продовжте українською"))
          ],
        ),
      ),
    );
  }
}
