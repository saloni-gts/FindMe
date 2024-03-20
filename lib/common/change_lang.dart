import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/provider/purchase_provider.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


import '../components/globalnavigatorkey.dart';
import '../generated/locale_keys.g.dart';
import '../monish/models/newModel.dart';
import '../util/app_images.dart';

Future changeLanguage(Locale locale,{required BuildContext context,bool isFromStart=false}) async {
print("local is  >>>> ${locale.toString()}");

  bool isSelected(BuildContext context) => locale == context.locale; 

  await GlobalVariable.navState.currentContext!.setLocale(locale); 
   HiveHandler.updateIsLanguageSelected(true); 
   if(!isFromStart){
    await CoolAlert.show(context: context, type: CoolAlertType.success, 
                  text: "Language Changed Successfully",); 

    PurChaseProvider purChaseProvider=Provider.of(context, listen: false); 
    List<Choice> c1= [
      Choice(
          title: tr(LocaleKeys.additionText_premiumSubscription),
          image: AssetImage(AppImage.premiumIcon),
          type: 13),

      Choice(
          title:tr(LocaleKeys.additionText_AddFamMember), 
          image: AssetImage(AppImage.familyplanIcon), 
          type: 1),


      Choice(
          title: tr(LocaleKeys.additionText_AddJointOnr),
          image: AssetImage(AppImage.addjoint),
          type: 4),


      Choice(
          title: tr(LocaleKeys.additionText_PndingReq),
          image: AssetImage(AppImage.pendinReq),
          type: 20),

      Choice(
          title: tr(LocaleKeys.moreFeatures_aboutUs), 
          image: AssetImage(AppImage.aboutus), 
          type: 2),
      Choice(
          title:tr(LocaleKeys.additionText_howitWrks), 
          image: AssetImage(AppImage.howItWoks), 
          type: 9),
      Choice(
          title: tr(LocaleKeys.moreFeatures_faq), 
          image: AssetImage(AppImage.faqicon), 
          type: 3),

      Choice(
          title: tr(LocaleKeys.moreFeatures_customerCare),
          image: AssetImage(AppImage.customer),
          type: 5),
      Choice(
          title: tr(LocaleKeys.additionText_RateUss),
          image: AssetImage(AppImage.rateus),
          type: 6),
      Choice(
        title: tr(LocaleKeys.additionText_ShareDApp),
        image: AssetImage(AppImage.shareicon1),
        type: 7,
      ),
      Choice(
          title: tr(LocaleKeys.moreFeatures_settings),
          image: AssetImage(AppImage.setting1),
          type: 8),
    ];

    List<Choice> c2= [
      Choice(
          title: tr(LocaleKeys.additionText_premiumSubscription),
          image: AssetImage(AppImage.premiumIcon),
          type: 13),

      Choice(
          title: tr(LocaleKeys.additionText_PndingReq),
          image: AssetImage(AppImage.pendinReq),
          type: 20),

      Choice(
          title: tr(LocaleKeys.moreFeatures_aboutUs),
          image: AssetImage(AppImage.aboutus),
          type: 2),
      Choice(
          title: tr(LocaleKeys.additionText_howitWrks),
          image: AssetImage(AppImage.howItWoks),
          type: 9),
      Choice(
          title: tr(LocaleKeys.moreFeatures_faq),
          image: AssetImage(AppImage.faqicon),
          type: 3),

      Choice(
          title: tr(LocaleKeys.moreFeatures_customerCare),
          image: AssetImage(AppImage.customer),
          type: 5),
      Choice(
          title: tr(LocaleKeys.additionText_RateUss),
          image: AssetImage(AppImage.rateus),
          type: 6),
      Choice(
        title: tr(LocaleKeys.additionText_ShareDApp),
        image: AssetImage(AppImage.shareicon1),
        type: 7,
      ),
      Choice(
          title: tr(LocaleKeys.moreFeatures_settings),
          image: AssetImage(AppImage.setting1),
          type: 8),
    ];
    print("************");
    purChaseProvider.choices1=c1;
    purChaseProvider.choices2=c2;
    print("************");


   }
    
}


