import '../controller/agreement_controller.dart';
import 'package:get/get.dart';

class AgreementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgreementController());
  }
}
