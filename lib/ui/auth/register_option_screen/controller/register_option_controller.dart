import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:atomai/app_export.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../models/user_custom_model.dart';

class RegisterOptionController extends GetxController {
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      Get.offAllNamed(AppRoutes.agreementScreen);
      createUser();
      return true;
    } on FirebaseAuthException catch (e) {
      log("FAcebook Log In$e");

      Fluttertoast.showToast(
          msg: e.message ?? "",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithAnon() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Get.offAllNamed(AppRoutes.notesHomePage);
      createUser();
      return true;
    } on FirebaseAuthException catch (e) {
      log("FAcebook Log In$e");

      Fluttertoast.showToast(
          msg: e.message ?? "",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        createUser();
        Get.toNamed(AppRoutes.agreementScreen);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      log("FAcebook Log In$e");

      Fluttertoast.showToast(
          msg: e.message ?? "",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return false;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> signInWithFacebook() async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //     createUser();
  //     Get.toNamed(AppRoutes.agreementScreen);
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     log("FAcebook Log In$e");

  //     Fluttertoast.showToast(
  //         msg: e.message ?? "",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);

  //     return false;
  //   } catch (e) {
  //     log("FAcebook Log In$e");
  //     return false;
  //   }
  // }

  Future<bool> createUser() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000), () {});
      bool alreadyIn = false;
      var firebaseFirestore = FirebaseFirestore.instance.collection("user");
      var user = FirebaseAuth.instance.currentUser!;
      LogInResult result = await Purchases.logIn(user.uid);
      log(result.customerInfo.toString());
      await firebaseFirestore.doc(user.uid).get().then((value) {
        if (value.exists) {
          alreadyIn = true;
        }
      });
      if (alreadyIn) return true;
      await firebaseFirestore.doc(user.uid).set(
            UserCustomModel(
              userId: user.uid,
              wordCount: 0,
              name: user.email?.split("@")[0],
              email: user.email,
              updatedAt: FieldValue.serverTimestamp(),
              createdAt: FieldValue.serverTimestamp(),
              wordCntReset: FieldValue.serverTimestamp(),
              icon: ImageConstant.img1,
              pushToken: await FirebaseMessaging.instance.getToken(),
            ).toMap(),
            SetOptions(merge: true),
          );

      if (!(user.isAnonymous)) {
        user.sendEmailVerification();
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
