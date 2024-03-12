
import '../app_export.dart';

class GetKeyFromStore extends GetxController {
  var openAiToken = "".obs;
  var stableDiffusionToken = "".obs;

  getKey() async {
    try {
      await FirebaseFirestore.instance
          .collection("key")
          .doc("keys")
          .get()
          .then((value) {
        var doc = value.data()!;
        openAiToken(doc["openAiToken"]);
        stableDiffusionToken(doc["stableDiffusionToken"]);
        print(openAiToken.value);
        print(stableDiffusionToken.value);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getKey();
  }
}
