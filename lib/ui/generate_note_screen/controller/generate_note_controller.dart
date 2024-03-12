import 'package:atomai/app_export.dart';
import 'package:dio/dio.dart' as diop;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/recive_model_gpt4/recive_model_gpt4.dart';
import '../../../services/get_key_from_store.dart';
import '../../../services/payment_controller.dart';
import '../../../services/user_data_controller.dart';
import '../widgets/generate_note_model.dart';

class GenerateNoteController extends GetxController {
  var searchTxtCtl = TextEditingController().obs;
  var textToSpeach = FlutterTts().obs;
  var isAnimationActive = false.obs;
  var isLoading = false.obs;
  var isTextToSpeach = false.obs;
  var currentText = " ".obs;
  var getKeyFromStore = Get.put(GetKeyFromStore());

  var userDataController = Get.put(UserDataController());
  var paymentController = Get.put(PaymentController());
  var titletTxtCtl = TextEditingController().obs;
  var controllerQuill = QuillController.basic().obs;

  var massages = <Map<String, String>>[].obs;

  var gptVersion = 0.obs;

  getCompletion(String prompt, {double? tmp = 0.0}) async {
    massages.add({"role": "user", "content": prompt});
    (massages.toList().toString());
    if (prompt == "") {
      return;
    }

    if (checkWordNotAvailable()) {
      Get.bottomSheet(const BottomSheetWidget(),
          backgroundColor: ColorConstant.gray900, isScrollControlled: true);

      return;
    }
    try {
      textToSpeach.value.stop();
      isLoading(true);

      diop.BaseOptions baseOptions = diop.BaseOptions(
        baseUrl: Constants.baseUrlOpenAI,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 100000),
        headers: {
          "Content-Type": "application/json",
          "Connection": "Keep-Alive",
          "Authorization": "Bearer ${getKeyFromStore.openAiToken.value}"
        },
      );

      var user = FirebaseAuth.instance.currentUser!;
      final startTime = DateTime.now();
      diop.Dio dio = diop.Dio(baseOptions);
      var response = await dio.post(
        '/chat/completions',
        data: {
          "model":
              paymentController.packageNew.value.entitleId == "atomai_a_m_e" ||
                      paymentController.packageNew.value.entitleId ==
                          "advanced_atomai_y"
                  ? "gpt-4-0613"
                  : "gpt-3.5-turbo-0613",
          "messages": massages,
          "temperature": tmp,
          "max_tokens": paymentController.packageNew.value.wordsAnu,
          "stream": false,
          "top_p": 1.0,
          "presence_penalty": 0.0,
          "frequency_penalty": 0.0,
          "stop": null,
          "n": 1,
          "user": user.uid
        },
      );
      final endTime = DateTime.now();
      final timeTaken = endTime.difference(startTime).inSeconds;
      var test = ReciveModelGpt4.fromMap(response.data);
      ("${timeTaken.toString()}s model- ${test.model} data");
      massages.add(
          {"role": "assistant", "content": test.choices.first.message.content});
      currentText(test.choices.first.message.content);
      setWordCount(test.usage.completion_tokens);
      setIsAnimationActive(true);
      addTextToSpeach(currentText.value);
    } catch (e) {
      setIsAnimationActive(false);
      setIsLoading(false);
      ("getCompletion $e");
      Fluttertoast.showToast(
          msg: "Server Outage ${e.toString()}".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } finally {
      update();
    }
  }

  bool checkWordNotAvailable() {
    if (FirebaseAuth.instance.currentUser!.isAnonymous &&
        1000 <=
            (userDataController.userCustomModel.value.wordCount ?? 0).toInt() &&
        paymentController.packageNew.value.payId == "Free") {
      return true;
    }

    if ((paymentController.packageNew.value.maxTxt ?? 5000).toInt() >
        ((userDataController.userCustomModel.value.wordCount ?? 0)).toInt()) {
      return false;
    } else {
      return true;
    }
  }

  setWordCount(int count) async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var firebaseFirestore = FirebaseFirestore.instance.collection("user");
      int num = userDataController.userCustomModel.value.wordCount! + count;

      if (num > (paymentController.package.value.maxTxt ?? 0)) {
        num = paymentController.package.value.maxTxt ?? 0;
      }
      await firebaseFirestore.doc(userId).set(
        {
          "wordCount": num,
          "wordCountUpdateAt": FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      userDataController.getUserData();
    } catch (e) {
      (e.toString());
    }
  }

  void getCompleteionButton() {
    resetCurrentText();
    if (!(isAnimationActive.value)) {
      if (searchTxtCtl.value.text == "") {
        Fluttertoast.showToast(
            msg: "Empty Prompt".tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      final lastLine = controllerQuill.value.document.length;

      controllerQuill.value.updateSelection(
        TextSelection.collapsed(offset: lastLine),
        ChangeSource.local,
      );
      controllerQuill.value.document.insert(
          controllerQuill.value.document.length - 1,
          "${searchTxtCtl.value.text} \n");

      controllerQuill.value
        ..formatText(
            controllerQuill.value.selection.baseOffset,
            searchTxtCtl.value.text.length,
            Attribute.clone(Attribute.header, 1))
        ..formatText(
            controllerQuill.value.selection.baseOffset,
            searchTxtCtl.value.text.length,
            Attribute.clone(Attribute.color, "#7e57c2"))
        ..formatText(
            controllerQuill.value.selection.baseOffset,
            searchTxtCtl.value.text.length,
            Attribute.clone(Attribute.bold, true));
      if (titletTxtCtl.value.text == "") {
        titletTxtCtl.value.text = searchTxtCtl.value.text;
      }
      getCompletion(searchTxtCtl.value.text);
      searchTxtCtl.value.clear();
      update();
    }
  }

  setQuillControllerDoc(Document quillDocument) {
    // var data = quillDocument;
    // controllerQuill(QuillController.basic());
    controllerQuill.value.document = quillDocument;
    update();
  }

  addTextToSpeach(String responseText) async {
    if (isTextToSpeach.value) {
      await textToSpeach.value.speak(responseText);
    }
  }

  setIsTextSpeach(bool isTrue) {
    isTextToSpeach(isTrue);
    update();
  }

  resetCurrentText() {
    currentText("");
    update();
  }

  setIsAnimationActive(bool isTrue) {
    isAnimationActive(isTrue);
    update();
  }

  setIsLoading(bool isTrue) {
    isLoading(isTrue);
    update();
  }

  setMassages(List<Map<String, String>> msg) {
    massages(msg.toList());
  }

  setTitle(String st) {
    titletTxtCtl(TextEditingController(text: st));
  }

  startUp() {
    setIsAnimationActive(false);
    setIsLoading(false);
    titletTxtCtl.value.clear();
    massages([]);
    controllerQuill(QuillController.basic());
    searchTxtCtl(TextEditingController());
    textToSpeach.value.stop();
    massages([
      {"role": "system", "content": "You are a helpful assistant god."}
    ]);
    controllerQuill.value.document
        .insert(controllerQuill.value.document.length - 1, " ");
  }

  @override
  void onReady() {
    super.onReady();
    textToSpeach(FlutterTts());
    textToSpeach.value.stop();
  }

  @override
  void onClose() {
    super.onClose();
    searchTxtCtl.value.clear();
    textToSpeach.value.stop();
    massages([]);
  }
}
