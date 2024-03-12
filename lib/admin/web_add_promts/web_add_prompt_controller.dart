import 'dart:developer';
import 'dart:typed_data';

import 'package:atomai/app_export.dart';
import 'package:atomai/models/prompts/pompts_custom_model.dart';

import '../../models/prompts/category_custom_mode.dart';

class WebAddPromptController extends GetxController {
  var promptsCustomModelList = <PromptsCustomModel>[].obs;
  var categoryCustomModelList = <CategoryCustomModel>[].obs;

  deletePrompts(PromptsCustomModel promptsCustomModel) async {
    await FirebaseStorage.instance
        .refFromURL(promptsCustomModel.imgUrl ?? "")
        .delete();
    await FirebaseFirestore.instance
        .collection("prompts")
        .doc(promptsCustomModel.id)
        .delete();
    getPrompts();
  }

  deleteCategory(CategoryCustomModel categoryCustomModel) async {
    await FirebaseFirestore.instance
        .collection("category")
        .doc(categoryCustomModel.id)
        .delete();
    getCategory();
  }

  Future<String> uploadImageToFirebaseStorage(
      Uint8List img, String imgName) async {
    String dateTime = DateTime.now().toIso8601String();

    var storageRef = FirebaseStorage.instance.ref(
      'prompts  /${imgName + dateTime}',
    );
    await storageRef.putData(
      img,
      SettableMetadata(
        contentType: "image/png",
      ),
    );

    return await storageRef.getDownloadURL();
  }

  Future<bool> getPrompts() async {
    try {
      var promptsCustomModelListTemp = <PromptsCustomModel>[];
      await FirebaseFirestore.instance
          .collection("prompts")
          .get()
          .then((quary) {
        for (var doc in quary.docs) {
          var data = doc.data();
          promptsCustomModelListTemp.add(
            PromptsCustomModel.fromMap(data).copyWith(
              id: doc.id,
              categoryName: getNameById(data["categoryId"]),
            ),
          );
        }
      });
      promptsCustomModelList(promptsCustomModelListTemp);
      update();
    } catch (e) {
      log("${e}prompts");
    }
    return true;
  }

  Future<bool> setPrompt(PromptsCustomModel promptsCustomModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("prompts")
          .doc(promptsCustomModel.id)
          .set(
              promptsCustomModel
                  .copyWith(
                    categoryName: "",
                  )
                  .toMap(),
              SetOptions(merge: true));

      await getPrompts();
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  Future<bool> addPrompt(PromptsCustomModel promptsCustomModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("prompts")
          .add(promptsCustomModel
              .copyWith(
                createAt: FieldValue.serverTimestamp(),
                id: "",
                categoryName: "",
              )
              .toMap());

      await getPrompts();
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  Future<bool> getCategory() async {
    try {
      var categoryCustomModelListTemp = <CategoryCustomModel>[];
      await FirebaseFirestore.instance
          .collection("category")
          .get()
          .then((quary) {
        for (var doc in quary.docs) {
          var data = doc.data();
          categoryCustomModelListTemp
              .add(CategoryCustomModel.fromMap(data).copyWith(
            id: doc.id,
          ));
        }
      });
      categoryCustomModelList(categoryCustomModelListTemp);
      getPrompts();
      update();
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  String? getNameById(String id) {
    for (var cat in categoryCustomModelList) {
      if (cat.id == id) {
        return cat.name;
      }
    }
    return "Removed";
  }

  Future<bool> setCategory(CategoryCustomModel categoryCustomModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("category")
          .doc(categoryCustomModel.id)
          .set(
              categoryCustomModel
                  .copyWith(
                    createAt: FieldValue.serverTimestamp(),
                  )
                  .toMap(),
              SetOptions(merge: true));
      await getCategory();
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  Future<bool> addCategory(CategoryCustomModel categoryCustomModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("category")
          .add(categoryCustomModel
              .copyWith(
                createAt: FieldValue.serverTimestamp(),
              )
              .toMap());
      await getCategory();
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  @override
  void onReady() {
    super.onReady();
    startUp();
  }

  startUp() async {
    await getCategory();
    await getPrompts();
  }
}
