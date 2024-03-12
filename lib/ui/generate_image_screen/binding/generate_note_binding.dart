import '../controller/generate_note_controller.dart';
import 'package:get/get.dart';

class GenerateImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenerateImagesController());
  }
}
