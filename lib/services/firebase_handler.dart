import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/scope.dart';
// import 'package:the_apple_sign_in/scope.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' as apple;

class FirebaseHandler {
  /// Google login handle
  static Future<UserSocial?> googleLogin() async {
    UserSocial? userData;

    return await _signInWithGoogle().then((googleAuth) async {
      // Create a new credential

      // GoogleAuthProvider().addScope("email");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // AuthResult linkauthresult=await existingUser.linkWithCredential(credential);

      print("googleAuth.accessToken ${googleAuth.accessToken}");
      print("googleAuth.idToken ${googleAuth.idToken}");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        print(" value is >>> ${value.additionalUserInfo!.profile!["email"]}");
        return value;
      }).catchError((e) {
        print("EXCEPPTIONN  $e");
      });
      User user = userCredential.user!;

      var name = user.displayName ?? "";
      print("printingggg;;;;;${user.email}");
      var token = credential.token.toString();
      var user0 = UserSocial(
          displayName: name,
          email: user.email ?? userCredential.additionalUserInfo?.profile?["email"],
          photoURL: user.photoURL ?? "",
          uid: user.uid,
          token: googleAuth.accessToken ?? "");

      userData = user0;

      return userData;

      print("**** user ${userData?.displayName}");
    }).catchError((error, stackTrace) {
      print("google login error $error");
      print("google login stackTrace $stackTrace");
      userData = null;
      return userData;
    });
  }

  static Future<GoogleSignInAuthentication> _signInWithGoogle() async {
    GoogleSignIn google;
    if (Platform.isIOS) {
      google = GoogleSignIn(
        clientId: "470377298806-5u982sk53nq0mersu4jh4157kdg1ngdj.apps.googleusercontent.com",
      );
    } else {
      google = GoogleSignIn(
        scopes: [],
      );
    }
    await google.signOut();
    return _signOut().then((value) async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await google.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Once signed in, return the UserCredential
      return googleAuth!;
    });
  }

  static firebaseTempLogin() async {
    print("call function for tem user ");
    if (FirebaseAuth.instance.currentUser != null) {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
    } else {
      print("not null");
    }
  }

  /// Facebook login handler
  static Future<UserSocial?> facebookLogin() async {
    await _signOut();
    UserSocial? userData;
    return _signInWithFacebook().then((facebookAuthCredential) async {
      final user = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      // final cred=await FirebaseAuth.instance.currentUser?.linkWithCredential(facebookAuthCredential);

      var user0 = UserSocial(
        displayName: user.user?.displayName ?? "",
        email: user.additionalUserInfo?.profile?["email"] ?? "",
        photoURL: user.user?.photoURL ?? "",
        uid: user.user!.uid,
        token: facebookAuthCredential.accessToken ?? "",
      );
      userData = user0;
      print("user email ${FirebaseAuth.instance.currentUser?.email}");
      return userData;
    }).catchError((error, stackTrace) {
      print("FirebaseAuth login error  :: $error");

      // EasyLoading.showToast("An account already exists with same email address but different sign-in credentials",toastPosition: EasyLoadingToastPosition.bottom);

      print("FirebaseAuth login stackTrace $stackTrace");
      return userData;
    });
  }

  static Future<OAuthCredential> _signInWithFacebook() async {
    final loginResultf = FacebookAuth.instance;
    await loginResultf.logOut();
    // loginResultf.expressLogin()
    // Trigger the sign-in flow
    await FirebaseAuth.instance.signOut();
    // return FirebaseAuth.instance.signOut();

    // print(">>>> ${user}");
    final LoginResult loginResult = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
      permissions: ["email", "public_profile"],
    );
    // Map<String,dynamic>  mapData= await FacebookAuth.instance.getUserData();
    //   print("user map $mapData");
    var accessToken = loginResult.accessToken;
    print("fb accesss token==+++== ${accessToken!.token}");
    if (loginResult.status == LoginStatus.success) {
      print("printing first statussss==${loginResult.message}");
      var myToken = loginResult.accessToken;
      final OAuthCredential credential = FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");

      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      Map<String, dynamic> mapData = user.additionalUserInfo?.profile ?? {};
      print("maild id ${mapData['email']}");
      // print(" ${} ");
      return credential;
    } else if (loginResult.status == LoginStatus.cancelled) {
      print("printing statussss==${loginResult.message}");
    }
    print("fb accesss token $accessToken");
    // Create a credential from the access token

    // Once signed in, return the UserCredential
    throw loginResult.status;
  }
  // try {
  //   final loginResultf = FacebookAuth.instance;
  //   await loginResultf.logOut();
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   var accessToken = loginResult.accessToken;
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   return facebookAuthCredential;
  // } catch (e) {
  //   return Future.error("Facebook login issue :: > $e");
  // }

  // apple login handle
  static Future<UserSocial?> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await apple.TheAppleSignIn.performRequests([
      const apple.AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    // 2. check the result
    switch (result.status) {
      case apple.AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final OAuthCredential credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final FirebaseAuth auth = FirebaseAuth.instance;

        final userCredential = await auth.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;

        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null && fullName.givenName != null && fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        print("userCredential=============");
        print(userCredential.user);
        print("APPLE SIGN IN  ${userCredential.user?.getIdToken() ?? ""}");
        var token = await userCredential.user?.getIdToken() ?? "";
        print("APPLE SIGN IN  $token");
        var user = UserSocial(
          displayName: userCredential.user?.providerData[0].displayName ?? "",
          email: userCredential.user?.providerData[0].email ?? "",
          photoURL: userCredential.user?.providerData[0].photoURL ?? "",
          uid: userCredential.user!.uid,
          token: token,
        );
        //// user data
        return user;

      case apple.AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case apple.AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        print("error in apple login");

        throw UnimplementedError();
    }
  }

  static Future _signOut() async {
    // FacebookAuth fb = FacebookAuth.instance;
    // await fb.logOut();
    // return google.isSignedIn().then((value) async {
    //   if (value) {

    await FirebaseAuth.instance.signOut();
    //   }
    // });
  }
}

class UserSocial {
  String displayName;
  String email;
  String photoURL;
  String token;
  String uid;

  UserSocial(
      {required this.displayName, required this.email, required this.photoURL, required this.token, required this.uid});
}
