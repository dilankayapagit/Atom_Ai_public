import 'package:atomai/app_export.dart';
import 'package:atomai/ui/auth/forget_password_screen/models/forget_password_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailOneController = TextEditingController();

  Rx<ForgetPasswordModel> forgetPasswordModelObj = ForgetPasswordModel().obs;

  Future<bool> sendResetForm() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailOneController.text);
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
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    super.onClose();
    emailOneController.dispose();
  }
}
