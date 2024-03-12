import 'dart:developer';

import 'package:atomai/app_export.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../web_router.dart';

class WebLoginController extends GetxController {
  TextEditingController emailOneController = TextEditingController();

  TextEditingController passwordOneController = TextEditingController();

  Rx<bool> isShowPassword = false.obs;

  Future<bool> userLogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailOneController.text,
        password: passwordOneController.text,
      );
      Get.toNamed(WebRouters.webHomePage);
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
