import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/components/customBlueButton.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:open_mail_app/open_mail_app.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/bottomBorderComp.dart';
import '../../generated/locale_keys.g.dart';

class CustomerCare extends StatefulWidget {
  const CustomerCare({Key? key}) : super(key: key);

  @override
  State<CustomerCare> createState() => _CustomerCareState();
}

class _CustomerCareState extends State<CustomerCare> {
  @override
  int showinsta = 0;
  int showWhatsapp = 0;
  int showImsg = 0;
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    petProvider.callContactApi = 0;
    // petProvider.contactUsApiCall(context);
    print("petProvider.iMsgNo=${petProvider.iMsgNo}");
    petProvider.whatsap.toString().isNotEmpty ? showWhatsapp = 1 : showWhatsapp = 0;
    petProvider.insta.toString().isNotEmpty ? showinsta = 1 : showinsta = 0;
    petProvider.iMsgNo.toString().isNotEmpty ? showImsg = 1 : showImsg = 0;

    print("showImsg====${showImsg}");

    print("showImsg====${showImsg}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        titlename: tr(LocaleKeys.additionText_cntactUs), 
      ),
      bottomNavigationBar: BotttomBorder(context), 
      body: Container( 
        // color: Colors.amber,
        height: MediaQuery.of(context).size.height * .42,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 208,
                  width: 179,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AppImage.dogcat,
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Center( 
                child: Container( 
                  height: 90, 
                  width: 336, 
                  child: Text( 
                    tr(LocaleKeys.additionText_customerchatfeedbaxk), 
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontFamily: AppFont.poppinsRegular, color: Colors.black, fontSize: 12), 
                  ), 
                ), 
              ), 
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          showImsg == 1 && Platform.isIOS
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: customBlueButton(
                      context: context,
                      text1: "iMessages ",
                      onTap1: () {
                        PetProvider petProvider = Provider.of(context, listen: false);
                        // _sendSMS(["${petProvider.iMsgNo}"]);
                      },
                      colour: AppColor.newBlueGrey),
                )
              : SizedBox(),
          showWhatsapp == 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: customBlueButton(
                      context: context,
                      text1: "WhatsApp ",
                      onTap1: () {
                        PetProvider petProvider = Provider.of(context, listen: false);
                        sendWhatsappMsg(petProvider.finalNum);
                      },
                      colour: AppColor.newBlueGrey),
                )
              : SizedBox(),
          showinsta == 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: customBlueButton(
                      context: context,
                      text1: "Instagram ",
                      onTap1: () {
                        PetProvider petProvider = Provider.of(context, listen: false);
                        launchInsta(petProvider.insta);
                      },
                      colour: AppColor.newBlueGrey),
                )
              : SizedBox(),
          customBlueButton(
            context: context,
            text1: tr(LocaleKeys.additionText_emailUs),
            onTap1: () {
              print("email button pressed....");

              Platform.isIOS ? sendIosMail() : sendEmail("", "contact@unique-tags.com");
            },
            colour: AppColor.newBlueGrey,
          ),
        ],
      ),
    );
  }

  sendWhatsappMsg(String whtsAppNum) async {
    print("whtsAppNum${whtsAppNum}");
    whtsAppNum = whtsAppNum.replaceFirst(" ", "");
    print("=====${whtsAppNum}");

    var whatsappUrl = "whatsapp://send?phone=${whtsAppNum}";
    var iosUrl = "https://wa.me/$whtsAppNum?text=hi";

    // var whatsappUrl = "whatsapp://send?phone=${123456789}";
    try {
      print("*******");
      if (Platform.isAndroid) {
        await launch(whatsappUrl);
      } else {
        print(whatsappUrl);
        if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
          await launch(whatsappUrl);
        } else {
          EasyLoading.showToast(tr(LocaleKeys.additionText_installWhtsApp),
              toastPosition: EasyLoadingToastPosition.center);
          //  additionText_installWhtsApp
        }
      }
    } catch (e) {
      print("*******");
      EasyLoading.showToast("Try Again!", toastPosition: EasyLoadingToastPosition.bottom);
      print("========${e}");
      //To handle error and display error message
    }
  }

  // sendIMsg(String iMsgNum) async {
  //   print("iMsgNum${iMsgNum}");
  //   var iMgsUrl = 'sms:${"navratan.soni@gmail.com"}?body=hello%20there';
  //   try {
  //    await launch(iMgsUrl);
  //   } catch (e) {
  //     print("========${e}");
  //     //To handle error and display error message
  //
  //   }
  // }

  // _sendSMS(List<String> recipents) async {
  //   print("InstaUsrName${recipents[0]}");

  //   //  recipents=["s2gmail.com"];
  //   String _result = await sendSMS(message: "", recipients: recipents).catchError((onError) {
  //     EasyLoading.showToast("Try Again!", toastPosition: EasyLoadingToastPosition.bottom);

  //     print("========${onError}");
  //   });
  //   print(_result);
  // }

  launchInsta(String InstaUsrName) async {
    print("InstaUsrName${InstaUsrName}");
    var nativeUrl = InstaUsrName;
    var webUrl = "https://www.instagram.com/youTube";

    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
      EasyLoading.showToast(tr(LocaleKeys.additionText_instaUsrNtFnd), toastPosition: EasyLoadingToastPosition.bottom);

      Future.delayed(const Duration(seconds: 2), () async {
        await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
      });
    }
  }

  sendIosMail() async {
    print("printing ios email test");
    String Recp = "contact@unique-tags.com";
    final Uri iosemail = Uri(
      scheme: 'mailto',
      path: Recp,
    );
    if (await canLaunchUrl(iosemail)) {
      await launchUrl(iosemail);
    } else {
      print("errorr");
    }
  }

  Future sendEmail(String sendrMail, String recMail) async {
    final Email email = Email(
      recipients: [recMail],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
      print("platformResponse======${platformResponse}");
    } catch (error) {
      platformResponse = error.toString();

      print("platformResponse======${platformResponse}");
    }

    if (!mounted) return;
  }

  iosMail() async {
    print("ios mail");
    var result = await OpenMailApp.openMailApp();
    if (!result.didOpen && !result.canOpen) {
      showNoMailAppsDialog(context);
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            mailApps: result.options,
          );
        },
      );
    }
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),  
          actions: <Widget>[
            InkWell(
              child: Text(
                "OK",
                style: TextStyle(fontSize: 17.0, fontFamily: AppFont.poppinsMedium),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
