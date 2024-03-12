import 'dart:developer';
import 'dart:typed_data';

import 'package:atomai/admin/web_add_promts/web_add_prompt_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/models/prompts/category_custom_mode.dart';
import 'package:atomai/models/prompts/pompts_custom_model.dart';
import 'package:fluttertoast/fluttertoast.dart';


class WebAddPromptsDialogs extends GetxController {
  var controller = Get.put(WebAddPromptController());
  var isLoading = false.obs;

  Future<bool> setCategoryDialog(PromptsCustomModel promptsCustomModel) async {
    TextEditingController titleTextCtl =
        TextEditingController(text: promptsCustomModel.title);
    TextEditingController promptTextCtl =
        TextEditingController(text: promptsCustomModel.prompt);
    TextEditingController titleTranslations =
        TextEditingController(text: promptsCustomModel.prompt);

    selected(promptsCustomModel.categoryId);
    var imgTemp = Uint8List(0);
    var imgName = "false";
    var imgUrl = promptsCustomModel.imgUrl;

    await Get.defaultDialog(
      backgroundColor: ColorConstant.gray900,
      cancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Center(
          child: Text(
            "lbl_annuler".tr,
            style: AppStyle.txtPoppinsMedium16,
          ),
        ),
      ),
      confirm: Obx(
        () => isLoading.value
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: () async {
                  if (controller.categoryCustomModelList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Categories",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (promptTextCtl.text == "" ||
                      selected.value == "" ||
                      titleTextCtl.text == "") {
                    Fluttertoast.showToast(
                        msg: "Fill All the Details",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }

                  isLoading(true);

                  try {
                    await controller.setPrompt(PromptsCustomModel(
                      id: promptsCustomModel.id,
                      title: titleTextCtl.text,
                      titleTranslation: titleTranslations.text,
                      prompt: promptTextCtl.text,
                      categoryId: selected.value,
                      imgUrl: imgName == "false"
                          ? imgUrl
                          : await controller.uploadImageToFirebaseStorage(
                              imgTemp,
                              imgName,
                            ),
                    ));
                  } catch (e) {
                    log(e.toString());
                  } finally {
                    updateImg(Uint8List(0), "");
                    selected("");
                  }
                  isLoading(false);
                  Get.back();
                },
                child: Container(
                  width: 75,
                  height: 30,
                  decoration: BoxDecoration(
                    color: ColorConstant.floatingActionBtnColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "lbl_ok".tr,
                      style: AppStyle.txtPoppinsMedium16,
                    ),
                  ),
                ),
              ),
      ),
      title: "Update Prompt",
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
      content: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Enter Title",
                style: AppStyle.txtMulishRegular14.copyWith(
                  color: Colors.white,
                ),
              ),
              CustomTextFormField(
                width: 200,
                focusNode: FocusNode(),
                controller: titleTextCtl,
                hintText: "Enter Title",
                maxLines: 1,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Enter Title Translation",
                style: AppStyle.txtMulishRegular14.copyWith(
                  color: Colors.white,
                ),
              ),
              CustomTextFormField(
                width: 200,
                focusNode: FocusNode(),
                controller: titleTranslations,
                hintText: "Enter Title Translation",
                maxLines: 1,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Enter Prompt",
                style: AppStyle.txtMulishRegular14.copyWith(
                  color: Colors.white,
                ),
              ),
              CustomTextFormField(
                width: 200,
                focusNode: FocusNode(),
                controller: promptTextCtl,
                hintText: "Enter Prompt",
                maxLines: 1,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Selectect category",
                style: AppStyle.txtMulishRegular14.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    height: 200,
                    width: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.categoryCustomModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var model = controller.categoryCustomModelList[index];
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              select(model.id ?? "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selected.value == model.id
                                      ? ColorConstant.floatingActionBtnColor
                                      : null,
                                ),
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: Text(
                                    "${index + 1}       ${model.name}",
                                    maxLines: 1,
                                    style: AppStyle.txtMulishRegular14.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var result = await FilePicker.platform.pickFiles();
                      if (result == null) {
                        return;
                      }
                      imgTemp = result.files.first.bytes ?? Uint8List(0);
                      imgName = result.files.first.name;
                      updateImg(imgTemp, imgName);
                    },
                    child: Image.memory(
                      img.value,
                      height: 150,
                      color: Colors.white,
                      width: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          promptsCustomModel.imgUrl ?? "",
                          color: Colors.white,
                          height: 150,
                          width: 150,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return true;
  }

  Future<bool> categoryDialog(
      {CategoryCustomModel? categoryCustomModelTemp}) async {
    TextEditingController nameCntrl = TextEditingController();
    TextEditingController translatiopnntrl = TextEditingController();

    if (categoryCustomModelTemp != null) {
      nameCntrl =
          TextEditingController(text: categoryCustomModelTemp.name ?? "");
      translatiopnntrl = TextEditingController(
          text: categoryCustomModelTemp.titleTranslation ?? "");
    }

    await Get.defaultDialog(
      backgroundColor: ColorConstant.gray900,
      cancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Center(
          child: Text(
            "lbl_annuler".tr,
            style: AppStyle.txtPoppinsMedium16,
          ),
        ),
      ),
      confirm: Obx(
        () => isLoading.value
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: () async {
                  if (nameCntrl.text == "" || translatiopnntrl.text == "") {
                    Fluttertoast.showToast(
                        msg: "Fill All the Details",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  isLoading(true);
                  try {
                    if (categoryCustomModelTemp == null) {
                      await controller.addCategory(CategoryCustomModel(
                        titleTranslation: translatiopnntrl.text,
                        name: nameCntrl.text,
                      ));
                    } else {
                      await controller.setCategory(CategoryCustomModel(
                        id: categoryCustomModelTemp.id,
                        titleTranslation: translatiopnntrl.text,
                        name: nameCntrl.text,
                      ));
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                  isLoading(false);
                  Get.back();
                },
                child: Container(
                  width: 75,
                  height: 20,
                  decoration: BoxDecoration(
                    color: ColorConstant.floatingActionBtnColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "lbl_ok".tr,
                      style: AppStyle.txtPoppinsMedium16,
                    ),
                  ),
                ),
              ),
      ),
      title: "Add Category",
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
      content: Column(
        children: [
          Text(
            "Category",
            style: AppStyle.txtMulishRegular14.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            width: 200,
            focusNode: FocusNode(),
            controller: nameCntrl,
            hintText: "Category",
            fontStyle: TextFormFieldFontStyle.MulishRegular16,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Category Translation",
            style: AppStyle.txtMulishRegular14.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            maxLines: 3,
            width: 200,
            focusNode: FocusNode(),
            controller: translatiopnntrl,
            hintText: "Category Translation",
            fontStyle: TextFormFieldFontStyle.MulishRegular16,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
    return true;
  }

  var selected = "".obs;
  select(String selected) {
    this.selected(selected);
    update();
  }

  var img = Uint8List(0).obs;
  var imgName = "".obs;

  updateImg(Uint8List img, String imgName) {
    this.img(img);
    this.imgName(imgName);
    update();
  }

  Future<bool> addPromptDialog() async {
    if (controller.categoryCustomModelList.isEmpty) {
      Fluttertoast.showToast(
          msg: "Fill All the Details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return true;
    }
    TextEditingController promptTextCtl = TextEditingController();
    TextEditingController titleTextCtl = TextEditingController();
    TextEditingController titleTranslation = TextEditingController();
    selected(controller.categoryCustomModelList[0].id ?? "");
    await Get.defaultDialog(
      backgroundColor: ColorConstant.gray900,
      cancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Center(
          child: Text(
            "lbl_annuler".tr,
            style: AppStyle.txtPoppinsMedium16,
          ),
        ),
      ),
      confirm: Obx(
        () => isLoading.value
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: () async {
                  if (controller.categoryCustomModelList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Categories",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (promptTextCtl.text == "" ||
                      selected.value == "" ||
                      img.value == Uint8List(0) ||
                      titleTextCtl.text == "") {
                    Fluttertoast.showToast(
                        msg: "Fill All the Details",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }

                  isLoading(true);
                  try {
                    await controller.addPrompt(PromptsCustomModel(
                      titleTranslation: titleTranslation.text,
                      title: titleTextCtl.text,
                      prompt: promptTextCtl.text,
                      categoryId: selected.value,
                      imgUrl: await controller.uploadImageToFirebaseStorage(
                        img.value,
                        imgName.value,
                      ),
                    ));
                  } catch (e) {
                    log(e.toString());
                  } finally {
                    img(Uint8List(0));
                    imgName("");
                    selected("");
                  }
                  isLoading(false);
                  Get.back();
                },
                child: Container(
                  width: 75,
                  height: 30,
                  decoration: BoxDecoration(
                    color: ColorConstant.floatingActionBtnColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "lbl_ok".tr,
                      style: AppStyle.txtPoppinsMedium16,
                    ),
                  ),
                ),
              ),
      ),
      title: "Add Prompt",
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
      content: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                width: 200,
                focusNode: FocusNode(),
                controller: titleTextCtl,
                hintText: "Enter Title",
                maxLines: 1,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                width: 200,
                focusNode: FocusNode(),
                controller: titleTranslation,
                hintText: "Enter Translation Title",
                maxLines: 1,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                width: 200,
                focusNode: FocusNode(),
                controller: promptTextCtl,
                hintText: "Enter Prompt",
                maxLines: 3,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Selectect category",
                style: AppStyle.txtMulishRegular14.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    height: 200,
                    width: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.categoryCustomModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var model = controller.categoryCustomModelList[index];
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              select(model.id ?? "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selected.value == model.id
                                      ? ColorConstant.floatingActionBtnColor
                                      : null,
                                ),
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: Text(
                                    "${index + 1}       ${model.name}",
                                    maxLines: 1,
                                    style: AppStyle.txtMulishRegular14.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var result = await FilePicker.platform.pickFiles();
                      if (result == null) {
                        return;
                      }
                      var img = result.files.first.bytes;
                      var imgName = result.files.first.name;
                      updateImg(img ?? Uint8List(0), imgName);
                    },
                    child: Image.memory(
                      img.value,
                      height: 150,
                      color: Colors.white,
                      width: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/icons_png/BLACK/Image 2.png",
                          color: Colors.white,
                          height: 150,
                          width: 150,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return true;
  }
}
