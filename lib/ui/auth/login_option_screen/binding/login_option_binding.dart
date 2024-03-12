import '../controller/login_option_controller.dart';
import 'package:get/get.dart';

class LoginOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginOptionController());
  }
}
