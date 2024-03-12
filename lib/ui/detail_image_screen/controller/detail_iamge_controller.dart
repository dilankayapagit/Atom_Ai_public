import 'dart:developer';

import 'package:flutter/services.dart';

import '../../../app_export.dart';
import '../../../models/image_genarate_model/artifact.dart';
import '../../../services/user_data_controller.dart';
import '../../edit_note_screen/controller/edit_note_controller.dart';
import '../models/detail_note_model.dart';

class DetailNImageController extends GetxController {
  Rx<DetailNoteModel> detailNoteModelObj = DetailNoteModel().obs;
  var imageGenarateList = <Artifact>[].obs;
  var selectIndex = 0.obs;
  var userDataController = Get.put(UserDataController());
  var editNoteController = Get.put(EditNoteController());

  Future<String> saveImg(Uint8List file) async {
    Get.dialog(
        CustomBlurDialog(
          title: "Uploading Image".tr,
          child: const CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    try {
      final storage = FirebaseStorage.instance.ref().child(
          'notes/${userDataController.user.value!.uid}/${generateRandomName()}_image.png');

      await storage.putData(
        file,
        SettableMetadata(
          contentType: "image/png",
        ),
      );
      var url = await storage.getDownloadURL();
      editNoteController.uploadImg(url);
      return url;
    } catch (e) {
      log("IMG uploader $e");
    } finally {
      Get.back();
    }
    return "";
  }

  String generateRandomName() {
    final bytes = utf8.encode(DateTime.now().toString());
    final digest = sha1.convert(bytes);
    return digest.toString();
  }

  setSelectIndex(int num) {
    selectIndex(num);
    update();
  }

  setImageList(List<Artifact> list) {
    imageGenarateList(list);
    update();
  }
}
