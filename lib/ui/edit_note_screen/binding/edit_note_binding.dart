import '../controller/edit_note_controller.dart';
import 'package:get/get.dart';

class EditNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditNoteController());
  }
}
