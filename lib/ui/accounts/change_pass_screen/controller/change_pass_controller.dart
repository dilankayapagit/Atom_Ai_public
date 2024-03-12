import 'dart:developer';

import 'package:atomai/app_export.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordOneController = TextEditingController();

  changePassword() async {
    
    try {
      var user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email ?? "",
        password: oldPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);

      user.updatePassword(newPasswordOneController.text);

      Get.back();
    } on FirebaseAuthException catch (e) {
      log("Change pw $e");
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
      log("Change pw $e");
    }
  }


  @override
  void onClose() {
    super.onClose();
    oldPasswordController.dispose();
    newPasswordOneController.dispose();
  }
}
