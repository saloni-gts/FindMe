import 'package:find_me/monish/screen/Map.dart';
import 'package:find_me/monish/screen/SettingScreen.dart';
import 'package:find_me/monish/screen/aboutUsScreen.dart';
import 'package:find_me/screen/documentCategory.dart';
import 'package:find_me/screen/forgetPassword.dart';
import 'package:find_me/screen/newDocument.dart';
import 'package:find_me/screen/showallpet.dart';
import 'package:find_me/screen/splashScreen.dart';
import 'package:flutter/material.dart';


import '../monish/screen/careDiaryNewEvent.dart';
import '../monish/screen/customerCare.dart';
import '../monish/screen/customerCareChat.dart';
import '../monish/screen/myCalendar.dart';
import '../monish/screen/newEvent.dart';
import '../monish/screen/newNote.dart';
import '../monish/screen/ownerProfile.dart';
import '../screen/dashboard.dart';
import '../screen/editdocuments.dart';
import '../screen/enterNameForm.dart';
import '../screen/petdashboard.dart';
import '../screen/signIN.dart';
import '../screen/signUpScreen.dart';
import '../screen/signUpSucess.dart';

class RouteGenrator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("calling route function");
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppScreen.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppScreen.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case AppScreen.signUpSuccess:
        return MaterialPageRoute(builder: (_) => const SignUpSuccessPage());
      // case AppScreen.registername:
      //   return MaterialPageRoute(builder: (_) => const EnterNameForm());
      case AppScreen.dashboard:
        return MaterialPageRoute(builder: (_) =>  DashBoard());
      case AppScreen.enterName:
        return MaterialPageRoute(builder: (_) => const EnterNameForm());
      case AppScreen.petDashboard:
        return MaterialPageRoute(builder: (_) => PetDashboard());
      case AppScreen.forgetPass:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case AppScreen.showallpetscreen:
        return MaterialPageRoute(builder: (_) => const ShowAllPet());
      case AppScreen.newDocument:
        return MaterialPageRoute(builder: (_) => NewDocument());
      case AppScreen.documentList:
        return MaterialPageRoute(builder: (_) => const DocumentCategory());

        case AppScreen.newnote:
        return MaterialPageRoute(builder: (_) =>  NewNote());




      case AppScreen.documentEdit:
        return MaterialPageRoute(
            builder: (_) => EditDocument(
                  dateIssued: "",
                ));

      ///new routes
      ///
      //   case AppScreen.newevent:
      //     return MaterialPageRoute(builder: (_) =>  NewEvent());
      case AppScreen.customercare:
        return MaterialPageRoute(builder: (_) => const CustomerCare());

        // case AppScreen.newevent:
        // return MaterialPageRoute(builder: (_) => const NewEvent());

        case AppScreen.newevent:
        return MaterialPageRoute(builder: (_) =>  EventCalender());

      case AppScreen.ownerprofile:
        return MaterialPageRoute(builder: (_) =>  OwnerProfile());

      case AppScreen.eventcalender:
        return MaterialPageRoute(builder: (_) =>  EventCalender());

        // case AppScreen.newnote:
        // return MaterialPageRoute(builder: (_) =>  NewNote());
      // case AppScreen.customerchat:
      //   return MaterialPageRoute(builder: (_) => const Customerchat());

      case AppScreen.googlemap:
        return MaterialPageRoute(builder: (_) => const Googlemap());
      case AppScreen.aboutus:
        return MaterialPageRoute(builder: (_) => Aboutus());

      case AppScreen.setting:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Somthing went wrong"),
        ),
      );
    });
  }
}

class AppScreen {
  static const String signUpScreen = "signUpScreen";
  static const String loginPage = "LoginPage";
  static const String signIn = "signin";
  static const String registername = "registername";
  static const String dashboard = "Dashboard";
  static const String enterName = "enterName";
  static const String signUpSuccess = "signUpSuccess";
  static const String forgetPass = "forgetPass";
  static const String petDashboard = "petdashboard";
  static const String showallpetscreen = "showallpetscreen";
  static const String newDocument = "newDocument";
  static const String documentList = "documentList";
  static const String documentEdit = "documentEdit";

  ///new routes names

  static const String newevent = 'newevent';
  static const String morefeature = 'morefeature';
  static const String customercare = 'customercare';
  static const String ownerprofile = 'ownerprofile';
  static const String eventcalender = 'eventcalender';
  static const String newnote = 'newnote';
  static const String customerchat = 'customerchat';
  static const String googlemap = 'googlemap';
  static const String aboutus = 'aboutus';
  static const String setting = 'setting';
}
