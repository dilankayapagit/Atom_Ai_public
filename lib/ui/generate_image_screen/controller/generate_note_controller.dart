import 'package:atomai/models/image_genarate_model/artifact.dart';
import 'package:atomai/models/image_genarate_model/image_generate_iamge.dart';
import 'package:dio/dio.dart' as diop;

import '../../../app_export.dart';
import '../../../services/get_key_from_store.dart';
import '../../../services/payment_controller.dart';
import '../../../services/user_data_controller.dart';
import '../../generate_note_screen/widgets/generate_note_model.dart';
import '../constant/image_filter_constant.dart';
import '../models/generate_note_model.dart';
import '../models/image_style_model.dart';
import '../models/size_list_model.dart';

class GenerateImagesController extends GetxController {
  Rx<GenerateNoteModel> generateNoteModelObj = GenerateNoteModel().obs;
  var isLoading = false.obs;
  var searchTxtCtl = TextEditingController().obs;
  var imageGenarateList = <Artifact>[].obs;
  //selected
  var selectSize = ImageFilterConstant.sizeList[0].obs;
  var selectedStyle = ImageFilterConstant.imageList[0].obs;

  var getKeyFromStore = Get.put(GetKeyFromStore());
  var userDataController = Get.put(UserDataController());
  var paymentController = Get.put(PaymentController());

  Future<bool> getImages() async {
    imageGenarateList.clear();
    if (checkWordNotAvailable()) {
      Get.bottomSheet(const BottomSheetWidget(),
          backgroundColor: ColorConstant.gray900, isScrollControlled: true);

      return true;
    }
    isLoading(true);

    try {
      diop.BaseOptions baseOptions = diop.BaseOptions(
        baseUrl: Constants.baseUrlStableDiffusion,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 100000),
        headers: {
          "Content-Type": "application/json",
          "Connection": "Keep-Alive",
          "Accept": "application/json",
          "Authorization":
              "Bearer ${getKeyFromStore.stableDiffusionToken.value}"
        },
      );

      var body = {
        "text_prompts": [
          {"text": searchTxtCtl.value.text}
        ],
        "cfg_scale": 7,
        "clip_guidance_preset": "FAST_BLUE",
        "height": selectSize.value.size![0],
        "width": selectSize.value.size![1],
        "samples": 4,
        "steps": 30,
      };

      if (selectedStyle.value.id != "") {
        body.addAll({
          "style_preset": selectedStyle.value.id ?? "",
        });
        debugPrint(selectedStyle.value.id ?? "");
      }
      diop.Dio dio = diop.Dio(baseOptions);
      var response = await dio.post(
        '/text-to-image',
        data: body,
      );
      var model =
          ImageGenarateModel.fromMap(response.data as Map<String, dynamic>);

      for (var images in model.artifacts!) {
        imageGenarateList
            .add(images.copyWith(imgbytes: base64Decode(images.base64!)));
      }
      setWordCount();
    } catch (e) {
      debugPrint("Image generator  $e");
    } finally {
      isLoading(false);
    }

    return true;
  }

  bool checkWordNotAvailable() {
    // if (FirebaseAuth.instance.currentUser!.isAnonymous &&
    //     2 <=
    //         (userDataController.userCustomModel.value.wordCount ?? 0).toInt() &&
    //     paymentController.packageNew.value.payId == "Free") {
    //   return true;
    // }

    if ((paymentController.packageNew.value.maxImg ?? 500).toInt() >
        ((userDataController.userCustomModel.value.imgCount ?? 0)).toInt()) {
      return false;
    } else {
      return true;
    }
  }

  setWordCount() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var firebaseFirestore = FirebaseFirestore.instance.collection("user");
      int num = userDataController.userCustomModel.value.imgCount! + 1;

      if (num > (paymentController.package.value.maxTxt ?? 0)) {
        num = paymentController.package.value.maxTxt ?? 0;
      }
      await firebaseFirestore.doc(userId).set(
        {
          "imgCount": num,
          "wordCountUpdateAt": FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      userDataController.getUserData();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  setSelectSize(SizeListModel sizeListModel) {
    selectSize(sizeListModel);
    update();
  }

  setSelectedStyle(ImageStyleModel imageStyleModel) {
    selectedStyle(imageStyleModel);
    update();
  }
}
