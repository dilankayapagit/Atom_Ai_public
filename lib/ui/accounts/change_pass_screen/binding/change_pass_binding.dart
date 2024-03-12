import '../controller/change_pass_controller.dart';
import 'package:get/get.dart';

class ChangePassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePassController());
  }
}
