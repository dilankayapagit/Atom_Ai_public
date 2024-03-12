import '../controller/splach_controller.dart';
import 'package:get/get.dart';

class SplachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplachController());
  }
}
