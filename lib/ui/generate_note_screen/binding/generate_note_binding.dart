import '../controller/generate_note_controller.dart';
import 'package:get/get.dart';

class GenerateNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenerateNoteController());
  }
}
