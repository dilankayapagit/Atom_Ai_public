// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/note_firebase_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/vibtaion_service.dart';
import '../../../theme/app_style.dart';
import '../../../utils/image_constant.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../edit_note_screen/controller/edit_note_controller.dart';
import '../../generate_note_screen/controller/generate_note_controller.dart';

class EmptyNoteWidget extends StatefulWidget {
  const EmptyNoteWidget({
    Key? key,
    this.folderId = "",
  }) : super(key: key);
  final String folderId;

  @override
  State<EmptyNoteWidget> createState() => _EmptyNoteWidgetState();
}

class _EmptyNoteWidgetState extends State<EmptyNoteWidget> {
  var generateNoteController = Get.put(GenerateNoteController());

  var editNoteController = Get.put(EditNoteController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 20,
        right: 20,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: getVerticalSize(
                312.00,
              ),
              width: getHorizontalSize(
                330.00,
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
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
                        top: 50,
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
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: getPadding(
                        left: 59,
                        top: 279,
                        right: 91,
                        bottom: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              top: 5,
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
                            margin: getMargin(
                              bottom: 5,
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
                      left: 7,
                      bottom: 63,
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
                    alignment: Alignment.topRight,
                    margin: getMargin(
                      top: 61,
                      right: 51,
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
                      left: 38,
                      bottom: 130,
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
                    alignment: Alignment.bottomRight,
                    margin: getMargin(
                      right: 16,
                      bottom: 135,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img7156x56,
                    height: getSize(
                      56.00,
                    ),
                    width: getSize(
                      56.00,
                    ),
                    alignment: Alignment.bottomRight,
                    margin: getMargin(
                      right: 13,
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
                      left: 92,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img52171x170,
                    height: getVerticalSize(
                      171.00,
                    ),
                    width: getHorizontalSize(
                      170.00,
                    ),
                    alignment: Alignment.topRight,
                    margin: getMargin(
                      top: 59,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgPlandetravail288x286,
                    height: getVerticalSize(
                      288.00,
                    ),
                    width: getHorizontalSize(
                      286.00,
                    ),
                    alignment: Alignment.centerLeft,
                    margin: getMargin(
                      left: 8,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: getHorizontalSize(
                201.00,
              ),
              margin: getMargin(
                  //left: 54,
                  top: 50,
                  bottom: 20),
              child: Text(
                "msg_oups_il_n_y_a".tr,
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
              onTap: () {                      VibrationService.vibrate();

                editNoteController.setNoteFirebaseModel(NoteFirebaseModel());
                editNoteController.setParentId(widget.folderId);
                generateNoteController.startUp();
                Get.toNamed(AppRoutes.generateNoteScreen);
              },
              height: 56,
              width: 192,
              text: "lbl_nouveau_notes".tr,
              margin: getMargin(
                //left: 59,
                top: 60,
              ),
              variant: ButtonVariant.OutlineGray90001,
              shape: ButtonShape.CircleBorder28,
              fontStyle: ButtonFontStyle.MulishRegular16,
            )
          ]),
        ),
      ),
    );
  }
}
