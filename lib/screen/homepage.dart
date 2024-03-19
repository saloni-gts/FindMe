// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:unique_tags/provider/authprovider.dart';
// import 'package:unique_tags/screen/signIN.dart';
// import 'package:unique_tags/screen/signUpScreen.dart';
// import 'package:unique_tags/screen/signUpSucess.dart';
// import 'package:unique_tags/screen/splashScreen.dart';
// import 'package:unique_tags/util/app_font.dart';
// import 'package:unique_tags/util/color.dart';

// import '../components/cntryyPikrrComp.dart';
// import '../components/customBlueButton.dart';
// import '../services/firebase_handler.dart';
// import '../util/app_images.dart';

// import 'addPet.dart';
// import 'calenderPage.dart';
// import 'changePassword.dart';
// import 'countryPicker.dart';
// import 'dashboard.dart';
// import 'enterNameForm.dart';
// import 'resetPassword.dart';
// import 'forgetPassword.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     AuthProvider authProvider = Provider.of(context, listen: false);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("PET ID"),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     authProvider.googleLogin(context);
//                   },
//                   child: Text("Google"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await FirebaseHandler.facebookLogin();
//                   },
//                   child: Text("FaceBook"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => CalenderPage()));
//                   },
//                   child: Text("Apple"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ForgetPassword()));
//                   },
//                   child: Text("forget password"),
//                 ),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //             builder: (context) => CreatePassword()));
//                 //   },
//                 //   child: Text("reset password"),
//                 // ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SignInPage()));
//                   },
//                   child: Text("sign in screen"),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SplashScreen()));
//                   },
//                   child: Text("splash screen"),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SignUpPage()));
//                   },
//                   child: Text("sign up screen"),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                     //    Navigator.of(context)
//                     //      .push(MaterialPageRoute(builder: (context) => cngPasswordDialog(context: context)));
//                        cngPasswordDialog(context: context);
//                   },
//                   child: Text("change password"),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                        Navigator.of(context)
//                          .push(MaterialPageRoute(builder: (context) => SignUpSuccessPage()));

//                   },
//                   child: Text("sign up success"),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => EnterNameForm()));
//                   },
//                   child: Text("EnterNameForm"),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => AddPet()));
//                   },
//                   child: Text("Add Pet"),
//                 ),


//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.push(context,
//                 //         MaterialPageRoute(builder: (context) => DashBoard()));
//                 //   },
//                 //   child: Text("DASHBOARD"),
//                 // ),





//                 CntrePikr(),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 customBlueButton(context: context,
//                     text1: "continue",
//                     onTap1: () {
//                       print("printing....");

//                     },
//                     colour: AppColor.textRed,
//                     ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//               ],
//             ),
//               ],
//             ),
//           ),
//         ));
//   }
//   Future<UserCredential> signInWithFacebook() async {

//      // Trigger the sign-in flow
//      final LoginResult loginResult = await FacebookAuth.instance
//          .login(permissions: ['email', 'public_profile']);
//      // Create a credential from the access token
//      final OAuthCredential facebookAuthCredential =
//          FacebookAuthProvider.credential(loginResult.accessToken!.token);
//      final userData = await FacebookAuth.instance.getUserData();
//      var userEmail = userData['email'];
//      // Once signed in, return the UserCredential
//      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//    }
// }

//           ),
//         ));
//   }
//   Future<UserCredential> signInWithFacebook() async {
    
//      // Trigger the sign-in flow
//      final LoginResult loginResult = await FacebookAuth.instance
//          .login(permissions: ['email', 'public_profile']);
//      // Create a credential from the access token
//      final OAuthCredential facebookAuthCredential =
//          FacebookAuthProvider.credential(loginResult.accessToken!.token);
//      final userData = await FacebookAuth.instance.getUserData();
//      var userEmail = userData['email'];
//      // Once signed in, return the UserCredential
//      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//    }
// }
