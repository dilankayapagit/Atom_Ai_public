import '../controller/forget_password_succes_reset_controller.dart';
import 'package:get/get.dart';

class ForgetPasswordSuccesResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordSuccesResetController());
  }
}
