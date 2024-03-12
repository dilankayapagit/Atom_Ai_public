import '../controller/detail_iamge_controller.dart';
import 'package:get/get.dart';

class DetailNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailNImageController());
  }
}
