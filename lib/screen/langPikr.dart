import 'package:find_me/common/change_lang.dart';
import 'package:find_me/components/bottomBorderComp.dart';
import 'package:find_me/components/custom_curved_appbar.dart';
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

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 85.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: widget.isFromStart
                    ? const Text("APP LANGUAGE",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: AppFont.poppinsBold))
                    : const Text("Choose a language for your want to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: AppColor.newBlueGrey, fontFamily: AppFont.poppinsBold)),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        await changeLanguage(AppLanguage.english, context: context, isFromStart: widget.isFromStart);

                        if (widget.isFromStart) {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                        }
                      },
                      child: LangContainer(context, AppImage.unitedKingdom, "English")),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        await changeLanguage(AppLanguage.french, context: context, isFromStart: widget.isFromStart);
                        if (widget.isFromStart) {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                        }
                      },
                      child: LangContainer(context, AppImage.france, "Français")),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        await changeLanguage(AppLanguage.spanish, context: context, isFromStart: widget.isFromStart);
                        if (widget.isFromStart) {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                        }
                      },
                      child: LangContainer(context, AppImage.spain, "Español")),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        await changeLanguage(AppLanguage.ukraninian, context: context, isFromStart: widget.isFromStart);
                        if (widget.isFromStart) {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                        }
                      },
                      child: LangContainer(context, AppImage.ukraine, "Deutsch")),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        await changeLanguage(AppLanguage.german, context: context, isFromStart: widget.isFromStart);
                        if (widget.isFromStart) {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.signUpScreen, (r) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, AppScreen.dashboard, (r) => false);
                        }
                      },
                      child: LangContainer(context, AppImage.germany, "Українською")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
