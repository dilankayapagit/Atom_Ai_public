import 'dart:io';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

import '../../app_export.dart';
import '../../models/image_genarate_model/artifact.dart';
import '../../services/vibtaion_service.dart';
import '../generate_image_screen/widgets/generate_note_item_widget.dart';
import 'controller/detail_iamge_controller.dart';

class DetailImageScreen extends StatefulWidget {
  const DetailImageScreen({super.key});

  @override
  State<DetailImageScreen> createState() => _DetailImageScreenState();
}

class _DetailImageScreenState extends State<DetailImageScreen> {
  var controller = Get.put(DetailNImageController());
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: ColorConstant.gray900,
          appBar: CustomAppBar(
            title: AppbarSubtitle1(
                text: "lbl_notes".tr, margin: getMargin(left: 12)),
            height: getVerticalSize(89),
            leadingWidth: 48,
            leading: AppbarImage(
                height: getSize(24),
                width: getSize(24),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(
                  left: 24,
                  top: 12,
                ),
                onTap: () {
                  Get.back();
                }),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: getPadding(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.6,
                    width: size.width,
                    margin: getMargin(left: 1),
                    decoration: BoxDecoration(
                      color: ColorConstant.blueGray8004c,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(16),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.memory(
                        controller
                            .imageGenarateList[controller.selectIndex.value]
                            .imgbytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                      padding: getPadding(left: 1, top: 32),
                      child: Row(children: [
                        GestureDetector(
                          onTap: () async {
                            VibrationService.vibrate();

                            await controller.saveImg(controller
                                .imageGenarateList[controller.selectIndex.value]
                                .imgbytes);
                            Get.back();
                            Get.back();
                            // Get.offNamedUntil(
                            //     AppRoutes.editNoteScreen, (route) => false);
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: ColorConstant.floatingActionBtnColor,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imageUp,
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: getPadding(left: 10, top: 12, bottom: 9),
                            child: Text("msg_import_image_into".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtMulishSemiBold24
                                    .copyWith(fontSize: 14))),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            VibrationService.vibrate();

                            // saveImage(controller
                            //         .imageGenarateList[
                            //             controller.selectIndex.value]
                            //         .base64 ??
                            //     "");
                            saveBase64Image(controller
                                    .imageGenarateList[
                                        controller.selectIndex.value]
                                    .base64 ??
                                "");
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: ColorConstant.floatingActionBtnColor,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6,
                                child: CustomImageView(
                                  imagePath: ImageConstant.downLine,
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
                  Padding(
                      padding: getPadding(top: 31, bottom: 20),
                      child: Text("lbl_related_photo".tr,
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
                        Artifact model = controller.imageGenarateList[index];
                        return GestureDetector(
                            onTap: () {
                              VibrationService.vibrate();

                              _scrollToTop();
                              controller.setSelectIndex(index);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GenerateNoteItemWidget(model)));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveBase64Image(String base64Image) async {
    try {
      List<int> bytes = base64.decode(base64Image);

      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final filePath = '$tempPath/image_${generateRandomName()}.jpg';

      await File(filePath).writeAsBytes(bytes);
      final result = await ImageGallerySaver.saveFile(filePath);
      if (result['isSuccess']) {
        print('Image saved to gallery!');
      } else {
        print('Failed to save image: ${result['error']}');
      }
      try {
        await Share.shareXFiles([XFile(filePath)], text: 'Sharing Image');
      } catch (e) {
        print('Sharing failed: $e');
      }
    } catch (e) {
      print('eroor $e');
    }

    // try {
    //   final bytes = const Base64Decoder().convert(base64Image);
    //   // final permissionStatus = await Permission.storage.request();
    //   // if (!permissionStatus.isGranted) {
    //   //   return;
    //   // }
    //   final result = await FilePicker.platform.getDirectoryPath();
    //   if (result == null) {
    //     return;
    //   }

    //   final directoryPath = result;
    //   final file = File('$directoryPath/image_${generateRandomName()}.jpg');
    //   await file.writeAsBytes(bytes);

    //   print('Image saved successfully');
    // } catch (e) {
    //   print('Image saved successfully $e');
    // }
  }

  Future<void> saveImage(String base64) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/image_${generateRandomName()}.jpg';
    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(base64Decode(base64));
    OpenFilex.open(imagePath);
  }

  String generateRandomName() {
    final bytes = utf8.encode(DateTime.now().toString());
    final digest = sha1.convert(bytes);
    return digest.toString();
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the curve as needed
    );
  }
}
