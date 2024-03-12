import '../controller/register_option_controller.dart';
import 'package:get/get.dart';

class RegisterOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterOptionController());
  }
}
