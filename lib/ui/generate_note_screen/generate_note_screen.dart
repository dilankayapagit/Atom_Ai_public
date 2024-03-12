import 'dart:developer';
import 'dart:math' as math;

import 'package:atomai/ui/idea_genarator/idea_genarator.dart';
import 'package:jiffy/jiffy.dart';

import '../../services/payment_controller.dart';
import '../../services/share_controller.dart';
import '../../services/vibtaion_service.dart';
import '../edit_note_screen/controller/edit_note_controller.dart';
import '../../widgets/text_editor_custom.dart';
import '../edit_note_screen/models/custom_popup_menuItem.dart';
import 'controller/generate_note_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/app_bar/appbar_subtitle_2.dart';

class GenerateNoteScreen extends StatefulWidget {
  const GenerateNoteScreen({super.key});

  @override
  State<GenerateNoteScreen> createState() => _GenerateNoteScreenState();
}

class _GenerateNoteScreenState extends State<GenerateNoteScreen> {
  // final QuillController controller.controllerQuill.value = QuillController.basic();
  ScrollController scrollController = ScrollController();
  final FocusNode _focusNodeQuill = FocusNode();
  final FocusNode _focusNodeSearch = FocusNode();

  var paymentController = Get.put(PaymentController());

  var editNoteController = Get.put(EditNoteController());
  var controller = Get.put(GenerateNoteController());
  var shareController = Get.put(ShareController());

  bool readOnly = true;
  bool isEnable = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.setIsAnimationActive(false);
    controller.setIsLoading(false);
    controller.titletTxtCtl.value.clear();
    controller.massages([]);
    super.dispose();
  }

  getBack() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.controllerQuill.value.document
            .toPlainText()
            .trim()
            .isNotEmpty) {
          await Get.dialog(
              CustomBlurDialog(
                btnEnable: true,
                title: "Would_you_like_to_record_your_note".tr,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        VibrationService.vibrate();
                        Get.back();
                      },
                      child: Container(
                        width: size.width * 0.392,
                        height: 64,
                        decoration: BoxDecoration(
                          color: ColorConstant.gray900,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "lbl_annuler".tr,
                            style: AppStyle.txtMulishRegular16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorConstant.gray900,
                      width: 4.8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          VibrationService.vibrate();
                          Get.back();
                          Get.defaultDialog(
                            backgroundColor: ColorConstant.gray900,
                            title: "Saving.".tr,
                            barrierDismissible: false,
                            titleStyle: AppStyle.txtMulishRegular14.copyWith(
                                letterSpacing: getHorizontalSize(0.14),
                                fontSize: 16,
                                color: Colors.white),
                            content: const CircularProgressIndicator(),
                          );
                          editNoteController.setMassages(controller.massages);
                          editNoteController.setQuillControllerDoc(
                              controller.controllerQuill.value.document);
                          editNoteController.setTitleTxtController(
                              controller.titletTxtCtl.value.text);
                          await editNoteController.saveNote(
                              // controller.controllerQuill.value,
                              );
                        } catch (e) {
                          log(e.toString());
                        } finally {
                          Get.back();
                        }
                      },
                      child: Container(
                        width: size.width * 0.392,
                        height: 64,
                        decoration: BoxDecoration(
                          color: ColorConstant.floatingActionBtnColor,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
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
                  ],
                ),
              ),
              barrierDismissible: false);
        }

        Get.back();
        return true;
      },
      child: GestureDetector(
        onVerticalDragDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          top: false,
          bottom: false,
          child: Obx(
            () => GestureDetector(
              onTap: () {
                _focusNodeSearch.unfocus();
              },
              child: Scaffold(
                backgroundColor: ColorConstant.gray900,
                appBar: CustomAppBar(
                    colour: ColorConstant.gray900,
                    height: getVerticalSize(56.00),
                    leadingWidth: 48,
                    leading: AppbarImage(
                      height: getSize(24.00),
                      width: getSize(24.00),
                      svgPath: ImageConstant.imgArrowleft,
                      margin: getMargin(left: 24, top: 16, bottom: 16),
                      onTap: () async {
                        if (controller.controllerQuill.value.document
                            .toPlainText()
                            .trim()
                            .isNotEmpty) {
                          await Get.dialog(
                              CustomBlurDialog(
                                btnEnable: true,
                                title: "Would_you_like_to_record_your_note".tr,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        VibrationService.vibrate();
                                        Get.back();
                                      },
                                      child: Container(
                                        width: size.width * 0.392,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.gray900,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "lbl_annuler".tr,
                                            style: AppStyle.txtMulishRegular16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: ColorConstant.gray900,
                                      width: 4.8,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        try {
                                          VibrationService.vibrate();
                                          Get.back();
                                          Get.defaultDialog(
                                            backgroundColor:
                                                ColorConstant.gray900,
                                            title: "Saving.".tr,
                                            barrierDismissible: false,
                                            titleStyle: AppStyle
                                                .txtMulishRegular14
                                                .copyWith(
                                                    letterSpacing:
                                                        getHorizontalSize(0.14),
                                                    fontSize: 16,
                                                    color: Colors.white),
                                            content:
                                                const CircularProgressIndicator(),
                                          );
                                          editNoteController
                                              .setMassages(controller.massages);
                                          editNoteController
                                              .setQuillControllerDoc(controller
                                                  .controllerQuill
                                                  .value
                                                  .document);
                                          editNoteController
                                              .setTitleTxtController(controller
                                                  .titletTxtCtl.value.text);
                                          await editNoteController.saveNote(
                                              // controller.controllerQuill.value,
                                              );
                                        } catch (e) {
                                          log(e.toString());
                                        } finally {
                                          Get.back();
                                        }
                                      },
                                      child: Container(
                                        width: size.width * 0.392,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          color: ColorConstant
                                              .floatingActionBtnColor,
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(15.0),
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
                                  ],
                                ),
                              ),
                              barrierDismissible: false);
                        }

                        Get.back();
                        return true;
                      },
                    ),
                    title: AppbarSubtitle2(
                        text: "lbl_notes".tr, margin: getMargin(left: 12)),
                    actions: [
                      if (!controller.isTextToSpeach.value)
                        CustomImageView(
                          onTap: () async {
                            VibrationService.vibrate();

                            controller.setIsTextSpeach(true);
                          },
                          imagePath: "assets/icons_png/WHITE/Volume Off.png",
                          color: Colors.white.withOpacity(0.3),
                          height: getVerticalSize(30.00),
                          width: getHorizontalSize(30.00),
                          fit: BoxFit.scaleDown,
                        ),
                      if (controller.isTextToSpeach.value)
                        CustomImageView(
                          onTap: () async {
                            VibrationService.vibrate();

                            controller.setIsTextSpeach(false);
                            controller.textToSpeach.value.stop();
                          },
                          imagePath: "assets/icons_png/WHITE/Volume Down.png",
                          color: Colors.white.withOpacity(0.3),
                          height: getVerticalSize(30.00),
                          width: getHorizontalSize(30.00),
                          fit: BoxFit.scaleDown,
                        ),
                      PopupMenuButton(
                        color: Colors.transparent,
                        icon: CustomImageView(
                          height: getSize(25.00),
                          width: getSize(25.00),
                          svgPath: ImageConstant.imgUpload,
                          fit: BoxFit.contain,
                        ),
                        elevation: 0,
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuItem>[
                            CustomPopupMenuItem(
                              child: GestureDetector(
                                onTap: () async {
                                  VibrationService.vibrate();

                                  Get.back();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  shareController.shareFile(
                                      controller.controllerQuill.value,
                                      controller.titletTxtCtl.value.text,
                                  context: context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.dropdown,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: 215,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            VibrationService.vibrate();

                                            Get.back();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            shareController.shareFile(
                                                controller
                                                    .controllerQuill.value,
                                                controller
                                                    .titletTxtCtl.value.text,
                                  context: context);
                                          },
                                          child: CustomImageView(
                                            onTap: () async {
                                              Get.back();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              shareController.shareFile(
                                                  controller
                                                      .controllerQuill.value,
                                                  controller
                                                      .titletTxtCtl.value.text,
                                  context: context);
                                            },
                                            imagePath:
                                                "assets/icons_png/WHITE/Document pdf - 2.png",
                                            color: Colors.white,
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "msg_Partager_en_PDF".tr,
                                          style: AppStyle
                                              .txtMulishRomanSemiBold16
                                              .copyWith(
                                            color: Colors.white,
                                            letterSpacing:
                                                getHorizontalSize(0.24),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomPopupMenuItem(
                              child: GestureDetector(
                                onTap: () async {
                                  VibrationService.vibrate();

                                  Get.back();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  shareController.shareFile(
                                      controller.controllerQuill.value,
                                      controller.titletTxtCtl.value.text,
                                      isTextOnly: true,
                                  context: context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.dropdown,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: 215,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            VibrationService.vibrate();

                                            Get.back();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            shareController.shareFile(
                                                controller
                                                    .controllerQuill.value,
                                                controller
                                                    .titletTxtCtl.value.text,
                                                isTextOnly: true,
                                  context: context);
                                          },
                                          child: CustomImageView(
                                            onTap: () async {
                                              VibrationService.vibrate();

                                              Get.back();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              shareController.shareFile(
                                                  controller
                                                      .controllerQuill.value,
                                                  controller
                                                      .titletTxtCtl.value.text,
                                                  isTextOnly: true,
                                  context: context);
                                            },
                                            imagePath:
                                                "assets/icons_png/WHITE/Document - 1.png",
                                            color: Colors.white,
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            "msg_Partager_du_texte_uniquement"
                                                .tr,
                                            style: AppStyle
                                                .txtMulishRomanSemiBold16
                                                .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.white,
                                              letterSpacing:
                                                  getHorizontalSize(0.24),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ];
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppbarSubtitle1(
                        onTap: () {
                          VibrationService.vibrate();

                          editNoteController.setQuillControllerDoc(
                              controller.controllerQuill.value.document);
                          editNoteController.setTitleTxtController(
                              controller.titletTxtCtl.value.text);
                          editNoteController.setMassages(controller.massages);
                          Get.offNamed(AppRoutes.editNoteScreen);
                        },
                        text: "lbl_enregistr".tr,
                        margin: getMargin(
                          //left: 10,
                          top: 21,
                          right: 20,
                          bottom: 13,
                        ),
                      ),
                    ]),
                body: Obx(
                  () => Padding(
                    padding: getPadding(
                      left: 20,
                      //top: 13,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: controller.titletTxtCtl.value,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtMulishSemiBold24.copyWith(
                            letterSpacing: getHorizontalSize(0.24),
                          ),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "lbl_input_title".tr,
                            hintStyle: AppStyle.txtMulishSemiBold24.copyWith(
                              letterSpacing: getHorizontalSize(0.24),
                            ),
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${Jiffy.now().format(pattern: "MMMM do yyyy, h:mm a")} | ${controller.controllerQuill.value.document.toPlainText().split(" ").length} ${"words".tr}"
                                .tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRegular12.copyWith(
                              letterSpacing: getHorizontalSize(0.12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListView(
                              controller: scrollController,
                              reverse: true,
                              children: [
                                if (controller.isAnimationActive.value)
                                  AnimatedTextKit(
                                    repeatForever: false,
                                    isRepeatingAnimation: false,
                                    stopPauseOnTap: false,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        controller.currentText.value,
                                        speed: Duration(
                                            milliseconds:
                                                controller.isTextToSpeach.value
                                                    ? 55
                                                    : 10),
                                        textStyle: AppStyle.description,
                                      ),
                                    ],
                                    onFinished: () async {
                                      controller.setIsAnimationActive(false);
                                      controller.setIsLoading(false);
                                      controller.controllerQuill.value.document
                                          .insert(
                                              controller.controllerQuill.value
                                                      .document.length -
                                                  1,
                                              controller.currentText.value);
                                      controller.controllerQuill.value.document
                                          .insert(
                                              controller.controllerQuill.value
                                                      .document.length -
                                                  1,
                                              " \n");
                                    },
                                  ),
                                TextEditorCustom(
                                  controllerQuill:
                                      controller.controllerQuill.value,
                                  focusNode: _focusNodeQuill,
                                  scrollController: ScrollController(),
                                  isReadOnly: true,
                                  showCursor: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      VibrationService.vibrate();

                                      controller.setIsAnimationActive(false);
                                      controller.setIsLoading(false);
                                      controller.resetCurrentText();
                                      controller.textToSpeach.value.stop();
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorConstant.bottomNavEdit,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CustomImageView(
                                              svgPath: ImageConstant.imgCamera,
                                              color: Colors.white,
                                              height: getVerticalSize(10.00),
                                              width: getHorizontalSize(10.00),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    VibrationService.vibrate();

                                    controller.setIsAnimationActive(false);
                                    controller.setIsLoading(false);
                                    controller.resetCurrentText();
                                    controller.textToSpeach.value.stop();
                                    math.Random random = math.Random();
                                    int randomNumber = random.nextInt(10);

                                    controller.getCompletion(
                                        "${controller.controllerQuill.value.document.toPlainText()}\n Rethink",
                                        tmp: randomNumber / 10);
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 7),
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.bottomNavEdit,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CustomImageView(
                                            svgPath:
                                                ImageConstant.imgUploadIndigo50,
                                            height: getVerticalSize(10.00),
                                            width: getHorizontalSize(10.00),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: controller.isLoading.value
                                        ? BoxDecoration(
                                            color: ColorConstant.bottomNavEdit,
                                            borderRadius: BorderRadius.circular(
                                              getHorizontalSize(12.00),
                                            ),
                                          )
                                        : BoxDecoration(
                                            color:
                                                ColorConstant.promptSearchColor,
                                            border: Border.all(
                                              color: ColorConstant
                                                  .promptSearchBorderColor,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              getHorizontalSize(12.00),
                                            ),
                                          ),
                                    width: size.width * .7,
                                    child: TextField(
                                      focusNode: _focusNodeSearch,
                                      controller: controller.searchTxtCtl.value,
                                      style: AppStyle
                                          .txtMulishRomanMedium16WhiteA700
                                          .copyWith(fontSize: 14),
                                      textInputAction: TextInputAction.go,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CustomImageView(
                                              onTap: () async {
                                                VibrationService.vibrate();

                                                Get.to(() =>
                                                    const IdeaGenarator());
                                              },
                                              imagePath:
                                                  "assets/icons_png/WHITE/Lamp.png",
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              height: getVerticalSize(15.00),
                                              width: getHorizontalSize(15.00),
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                        label: DefaultTextStyle(
                                          style: AppStyle
                                              .txtMulishRomanMedium16WhiteA700
                                              .copyWith(
                                            fontSize: 14,
                                          ),
                                          child: AnimatedTextKit(
                                            repeatForever: false,
                                            // stopPauseOnTap: true,
                                            totalRepeatCount: 3,
                                            pause: const Duration(seconds: 1),
                                            animatedTexts: [
                                              TypewriterAnimatedText(
                                                  'msg_type_a_message'.tr),
                                            ],
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: controller.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : CustomImageView(
                                            onTap: () {
                                              VibrationService.vibrate();
                                              _focusNodeSearch.unfocus();
                                              controller.getCompleteionButton();
                                            },
                                            svgPath:
                                                ImageConstant.imgArrowright,
                                            height: getVerticalSize(45.00),
                                            width: getHorizontalSize(45.00),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
