import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/vibtaion_service.dart';
import '../../../utils/image_constant.dart';
import '../../../utils/size_utils.dart';
import '../../../theme/app_style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../controller/notes_home_controller.dart';

class EmptyFolderWidget extends StatelessWidget {
  EmptyFolderWidget({super.key});
  final controller = Get.put(NotesHomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getVerticalSize(
                338.00,
              ),
              width: getHorizontalSize(
                343.00,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: getVerticalSize(
                        106.00,
                      ),
                      width: getHorizontalSize(
                        132.00,
                      ),
                      margin: getMargin(
                        left: 17,
                        top: 63,
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.img2,
                            height: getVerticalSize(
                              106.00,
                            ),
                            width: getHorizontalSize(
                              132.00,
                            ),
                            alignment: Alignment.center,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.img19,
                            height: getVerticalSize(
                              10.00,
                            ),
                            width: getHorizontalSize(
                              7.00,
                            ),
                            alignment: Alignment.topRight,
                            margin: getMargin(
                              top: 6,
                              right: 54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: getSize(
                        174.00,
                      ),
                      width: getSize(
                        174.00,
                      ),
                      margin: getMargin(
                        bottom: 27,
                      ),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.img3,
                            height: getSize(
                              174.00,
                            ),
                            width: getSize(
                              174.00,
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: getHorizontalSize(
                                82.00,
                              ),
                              margin: getMargin(
                                right: 12,
                                bottom: 8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.img19,
                                    height: getVerticalSize(
                                      10.00,
                                    ),
                                    width: getHorizontalSize(
                                      7.00,
                                    ),
                                    alignment: Alignment.centerRight,
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.img19,
                                    height: getVerticalSize(
                                      10.00,
                                    ),
                                    width: getHorizontalSize(
                                      7.00,
                                    ),
                                    margin: getMargin(
                                      top: 102,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img19,
                    height: getVerticalSize(
                      10.00,
                    ),
                    width: getHorizontalSize(
                      7.00,
                    ),
                    alignment: Alignment.bottomLeft,
                    margin: getMargin(
                      left: 76,
                      bottom: 31,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img19,
                    height: getVerticalSize(
                      10.00,
                    ),
                    width: getHorizontalSize(
                      7.00,
                    ),
                    alignment: Alignment.bottomLeft,
                    margin: getMargin(
                      left: 24,
                      bottom: 76,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: getHorizontalSize(
                        56.00,
                      ),
                      margin: getMargin(
                        right: 15,
                        bottom: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.img19,
                            height: getVerticalSize(
                              10.00,
                            ),
                            width: getHorizontalSize(
                              7.00,
                            ),
                            margin: getMargin(
                              left: 18,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.img71,
                            height: getSize(
                              56.00,
                            ),
                            width: getSize(
                              56.00,
                            ),
                            margin: getMargin(
                              top: 185,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img19,
                    height: getVerticalSize(
                      10.00,
                    ),
                    width: getHorizontalSize(
                      7.00,
                    ),
                    alignment: Alignment.bottomLeft,
                    margin: getMargin(
                      left: 55,
                      bottom: 143,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img71,
                    height: getSize(
                      56.00,
                    ),
                    width: getSize(
                      56.00,
                    ),
                    alignment: Alignment.topLeft,
                    margin: getMargin(
                      left: 109,
                      top: 13,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgPlandetravail338x338,
                    height: getSize(
                      338.00,
                    ),
                    width: getSize(
                      338.00,
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            Container(
              width: getHorizontalSize(
                222.00,
              ),
              margin: getMargin(top: 18, bottom: 20),
              child: Text(
                "msg_oups_il_n_y_a2".tr,
                maxLines: null,
                textAlign: TextAlign.center,
                style: AppStyle.txtMulishRegular16.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                // if (FirebaseAuth.instance.currentUser!.isAnonymous) {
                //   Fluttertoast.showToast(
                //       msg: "Please_sign_in_or_sign_up".tr,
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor: Colors.red,
                //       textColor: Colors.white,
                //       fontSize: 16.0);
                //   return;
                // }                      VibrationService.vibrate();
                VibrationService.vibrate();

                controller.dialogCreateFolder();
              },
              height: 56,
              width: 204,
              text: "msg_nouveau_dossier".tr,
              margin: getMargin(
                top: 59,
              ),
              variant: ButtonVariant.OutlineGray90001,
              shape: ButtonShape.CircleBorder28,
              fontStyle: ButtonFontStyle.MulishRegular16,
            ),
          ],
        ),
      ),
    );
  }
}
