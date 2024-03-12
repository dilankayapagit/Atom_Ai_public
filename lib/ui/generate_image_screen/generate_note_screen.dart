import 'package:atomai/ui/generate_image_screen/widgets/list_item_widget.dart';
import 'package:atomai/ui/generate_image_screen/widgets/listrectangleth_item_widget.dart';
import 'package:flutter/foundation.dart';

import '../../app_export.dart';
import '../../services/vibtaion_service.dart';
import '../detail_image_screen/controller/detail_iamge_controller.dart';
import 'constant/image_filter_constant.dart';
import 'controller/generate_note_controller.dart';
import 'models/image_style_model.dart';
import 'models/size_list_model.dart';
import 'widgets/generate_note_item_widget.dart';

class GenerateImagesScreen extends StatefulWidget {
  const GenerateImagesScreen({super.key});

  @override
  State<GenerateImagesScreen> createState() => _GenerateImagesScreenState();
}

class _GenerateImagesScreenState extends State<GenerateImagesScreen> {
  var controller = Get.put(GenerateImagesController());
  var detailNoteController = Get.put(DetailNImageController());

  var scrollController = ScrollController();
  final FocusNode _focusNodeSearch = FocusNode();
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      controller.searchTxtCtl(TextEditingController(text: "car with rocket"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        top: false,
        bottom: false,
        child: GestureDetector(
          onTap: () {
            _focusNodeSearch.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.gray900,
            appBar: CustomAppBar(
              height: getVerticalSize(89),
              leadingWidth: 48,
              leading: AppbarImage(
                  height: getSize(24),
                  width: getSize(24),
                  svgPath: ImageConstant.imgArrowleft,
                  margin: getMargin(left: 24, top: 14, bottom: 17),
                  onTap: () {
                    Get.back();
                  }),
              title: AppbarSubtitle1(
                  text: "lbl_notes".tr, margin: getMargin(left: 12)),
            ),
            body: SizedBox(
              width: size.width,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: getPadding(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("msg_generate_an_image".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtMontserratAlternatesBold22),
                      Padding(
                          padding: getPadding(
                            right: 15,
                            top: 20,
                          ),
                          child: Row(children: [
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
                                      color: ColorConstant.promptSearchColor,
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
                                style: AppStyle.txtMulishRomanMedium16WhiteA700
                                    .copyWith(fontSize: 14),
                                textInputAction: TextInputAction.go,
                                maxLines: 1,
                                decoration: InputDecoration(
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
                            GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                controller.getImages();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : CustomImageView(
                                        svgPath: ImageConstant.imgArrowright,
                                        height: getVerticalSize(45.00),
                                        width: getHorizontalSize(45.00),
                                      ),
                              ),
                            ),
                          ])),
                      Padding(
                          padding: getPadding(top: 30),
                          child: Text("lbl_filter".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtMontserratAlternatesBold22)),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                              height: getVerticalSize(63),
                              child: ListView.separated(
                                  padding: getPadding(top: 25),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                        height: getVerticalSize(12));
                                  },
                                  itemCount:
                                      ImageFilterConstant.sizeList.length,
                                  itemBuilder: (context, index) {
                                    SizeListModel model =
                                        ImageFilterConstant.sizeList[index];
                                    return GestureDetector(
                                        onTap: () {
                                          VibrationService.vibrate();

                                          controller.setSelectSize(model);
                                        },
                                        child: ListItemWidget(model));
                                  }))),
                      Padding(
                          padding: getPadding(
                            left: 7,
                            top: 35,
                          ),
                          child: SizedBox(
                              // width: size.width,
                              height: getVerticalSize(90),
                              child: ListView.separated(
                                  // padding: getPadding(left: 25),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                        height: getVerticalSize(12));
                                  },
                                  itemCount:
                                      ImageFilterConstant.imageList.length,
                                  itemBuilder: (context, index) {
                                    ImageStyleModel model =
                                        ImageFilterConstant.imageList[index];
                                    return GestureDetector(
                                        onTap: () {
                                          VibrationService.vibrate();

                                          controller.setSelectedStyle(model);
                                          // controller.selectSize(model.);
                                        },
                                        child:
                                            ListrectanglethItemWidget(model));
                                  }))),
                      Padding(
                          padding: getPadding(
                            top: 15,
                            bottom: 10,
                          ),
                          child: Text("msg_search_results".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtMontserratAlternatesBold22)),
                      SizedBox(
                        height: size.height * .7,
                        child: GridView.builder(
                          controller: scrollController,
                          itemCount: controller.imageGenarateList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var model = controller.imageGenarateList[index];
                            return GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                detailNoteController.setSelectIndex(index);
                                detailNoteController
                                    .setImageList(controller.imageGenarateList);
                                Get.toNamed(AppRoutes.detailNoteScreen);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GenerateNoteItemWidget(model),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
