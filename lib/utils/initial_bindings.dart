import 'package:atomai/app_export.dart';
import 'package:atomai/services/payment_controller.dart';

import '../services/get_key_from_store.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
    Get.put(GetKeyFromStore());

  }
}
