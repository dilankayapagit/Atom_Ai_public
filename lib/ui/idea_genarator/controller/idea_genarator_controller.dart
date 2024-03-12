import 'dart:developer';

import 'package:atomai/app_export.dart';

import '../../../models/prompts/category_custom_mode.dart';
import '../../../models/prompts/pompts_custom_model.dart';

class IdeaGenaratorController extends GetxController {
  var promptsCustomModelList = <PromptsCustomModel>[].obs;
  var categoryCustomModelList = <CategoryCustomModel>[].obs;
  var promptsCustomModelListSaearch = <PromptsCustomModel>[].obs;

  searchList(String id) {
    if (id == "all") {
      promptsCustomModelListSaearch(promptsCustomModelList);
      return;
    }

    var promptsCustomModelListTemp = <PromptsCustomModel>[];

    for (var element in promptsCustomModelList) {
      if (element.categoryId == id) {
        promptsCustomModelListTemp.add(element);
      }
    }

    promptsCustomModelListSaearch(promptsCustomModelListTemp);
    update();
  }

  // Stream<List<CategoryCustomModel>> getCategory() {
  //   var categoryCustomModelListTemp = <CategoryCustomModel>[
  //     CategoryCustomModel(name: "All", id: "all", titleTranslationModel: {
  //       "en": "All",
  //       "fr": "Tout",
  //       "es": "Todo",
  //       "de": "Alle",
  //       "it": "Tutto",
  //       "zh": "全部",
  //       "ja": "全て"
  //     }),
  //   ];

  //   // Create a StreamController to listen for changes
  //   StreamController<List<CategoryCustomModel>> streamController =
  //       StreamController<List<CategoryCustomModel>>();

  //   try {
  //     // Query the 'category' collection and listen for changes
  //     FirebaseFirestore.instance
  //         .collection("category")
  //         .orderBy("createAt", descending: true)
  //         .snapshots()
  //         .listen((querySnapshot) {
  //       categoryCustomModelListTemp
  //           .clear(); // Clear the list before adding new data
  //       for (var doc in querySnapshot.docs) {
  //         try {
  //           var data = doc.data();
  //           var model = CategoryCustomModel.fromMap(data).copyWith(
  //             id: doc.id,
  //             titleTranslationModel: json.decode(data["titleTranslation"]),
  //           );
  //           categoryCustomModelListTemp.add(model);
  //         } catch (e) {
  //           log("idea prompt error $e");
  //         }
  //       }
  //       // Add the updated list to the stream
  //       streamController.add(categoryCustomModelListTemp);
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   return streamController.stream; // Return the Stream for listening
  // }

  Future<bool> getCategory() async {
    try {
      var categoryCustomModelListTemp = <CategoryCustomModel>[
        CategoryCustomModel(name: "All", id: "all", titleTranslationModel: {
          "en": "All",
          "fr": "Tout",
          "es": "Todo",
          "de": "Alle",
          "it": "Tutto",
          "zh": "全部",
          "ja": "全て"
        })
      ];
      await FirebaseFirestore.instance
          .collection("category")
          .orderBy(
            "createAt",
            descending: true,
          )
          .get()
          .then((quary) {
        for (var doc in quary.docs) {
          try {
            var data = doc.data();
            var model = CategoryCustomModel.fromMap(data).copyWith(
              id: doc.id,
              titleTranslationModel: json.decode(data["titleTranslation"]),
            );
            categoryCustomModelListTemp.add(model);
          } catch (e) {
            log("idea prompt error $e");
          }
          // log("category ${model.titleTranslationModel}");
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

  Future<bool> getPrompts() async {
    try {
      var promptsCustomModelListTemp = <PromptsCustomModel>[];
      await FirebaseFirestore.instance
          .collection("prompts")
          .orderBy(
            "createAt",
            descending: true,
          )
          .get()
          .then((quary) {
        for (var doc in quary.docs) {
          var data = doc.data();
          promptsCustomModelListTemp.add(
            PromptsCustomModel.fromMap(data).copyWith(
              id: doc.id,
              categoryName: getNameById(data["categoryId"]),
              titleTranslationModel: json.decode(data["titleTranslation"]),
              promptTranslationModel: json.decode(data["prompt"]),
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

  String? getNameById(String id) {
    for (var cat in categoryCustomModelList) {
      if (cat.id == id) {
        return cat.name;
      }
    }
    return "Removed";
  }

  @override
  void onReady() {
    super.onReady();
    startUp();
  }

  startUp() async {
    getCategory();
    await getPrompts();
    searchList("all");
  }
}
