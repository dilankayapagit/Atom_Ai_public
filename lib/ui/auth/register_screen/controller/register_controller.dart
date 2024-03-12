import 'dart:developer';

import 'package:atomai/app_export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../models/user_custom_model.dart';
import '../models/register_model.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailTwoController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordOneController = TextEditingController();

  Rx<RegisterModel> registerModelObj = RegisterModel().obs;

  Rx<bool> isShowPassword = false.obs;

  Future<bool> register() async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTwoController.text,
        password: passwordOneController.text,
      );
      await createUser(user.user!.uid);

      FirebaseAuth.instance.currentUser!.sendEmailVerification();

      log("User ID Create user ${user.user!.uid}");
      Get.toNamed(AppRoutes.agreementScreen);
    } catch (e) {
      log(e.toString());
      return false;
    }

    return true;
  }

  Future<bool> createUser(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000), () {});
      var user = FirebaseAuth.instance.currentUser!;
      LogInResult result = await Purchases.logIn(user.uid);
      log(result.customerInfo.toString());
      var firebaseFirestore = FirebaseFirestore.instance.collection("user");
      await firebaseFirestore.doc(userId).set(
            UserCustomModel(
              userId: userId,
              name: fullNameController.text,
              email: emailTwoController.text,
              phoneNumber: phoneController.text,
              updatedAt: FieldValue.serverTimestamp(),
              createdAt: FieldValue.serverTimestamp(),
              wordCntReset: FieldValue.serverTimestamp(),
              icon: ImageConstant.img1,
              wordCount: 0,
              pushToken: await FirebaseMessaging.instance.getToken(),
            ).toMap(),
            SetOptions(merge: true),
          );

      await user.updateDisplayName(fullNameController.text);
      user.sendEmailVerification();

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    fullNameController.dispose();
    emailTwoController.dispose();
    phoneController.dispose();
    passwordOneController.dispose();
  }
}
