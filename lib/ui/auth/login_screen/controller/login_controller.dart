import 'dart:developer';

import 'package:atomai/app_export.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../models/login_model.dart';

class LoginController extends GetxController {
  TextEditingController emailOneController = TextEditingController();

  TextEditingController passwordOneController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;

  Rx<bool> isShowPassword = false.obs;

  Future<bool> userLogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailOneController.text,
        password: passwordOneController.text,
      );
      var user = FirebaseAuth.instance.currentUser!;
      LogInResult result = await Purchases.logIn(user.uid);
     log(result.customerInfo.toString());
      return true;
    } on FirebaseAuthException catch (e) {
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
      log("user login $e");
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailOneController.dispose();
    passwordOneController.dispose();
  }
}
