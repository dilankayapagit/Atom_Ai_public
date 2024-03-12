import 'dart:developer';
import 'dart:io';

import 'package:atomai/app_export.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';

import '../../../services/vibtaion_service.dart';
import '../controller/edit_note_controller.dart';
import '../models/bottom_image_selector.dart';

class BottomOptionsSheetCustom extends StatefulWidget {
  const BottomOptionsSheetCustom(
      {required this.quillController,
      required this.focusNodeQuillEditor,
      required this.focusNodeSearch,
      super.key});
  final QuillController quillController;
  final FocusNode focusNodeQuillEditor;
  final FocusNode focusNodeSearch;

  @override
  _BottomOptionsSheetCustomState createState() =>
      _BottomOptionsSheetCustomState();
}

class _BottomOptionsSheetCustomState extends State<BottomOptionsSheetCustom> {
  var controller = Get.put(EditNoteController());

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _strikeThrough = false;

  int headerLevel = 0;

  String _text = '';
  List<int>? _offsets = [];
  int _index = 0;
  TextEditingController searchTxtCntrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.quillController.addListener(() async {
      if (!mounted) return;
      try {
        final formats = widget.quillController.getSelectionStyle();
        _isBold = formats.containsKey(Attribute.bold.key);
        _isItalic = formats.containsKey(Attribute.italic.key);
        _isUnderline = formats.containsKey(Attribute.underline.key);
        _strikeThrough = formats.containsKey(Attribute.strikeThrough.key);
        if (formats.attributes[Attribute.header.key] != null) {
          headerLevel = formats.attributes[Attribute.header.key]!.value;
        } else {
          headerLevel = 0;
        }
      } catch (e) {
        log("$e bottom sheet");
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget _buildSecondWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        color: ColorConstant.gray900,
        key: const ValueKey(1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyHeaders(1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.bottomNavEdit,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      width: size.width * 0.2,
                      height: size.height * 0.07,
                      child: Center(
                        child: Text(
                          "Title",
                          style: AppStyle.heading1Txt.copyWith(
                            color: headerLevel == 1
                                ? ColorConstant.floatingActionBtnColor
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyHeaders(2);
                    },
                    child: Container(
                      width: size.width * 0.2,
                      height: size.height * 0.07,
                      color: ColorConstant.bottomNavEdit,
                      child: Center(
                        child: Text(
                          "Heading",
                          style: AppStyle.heading2Txt.copyWith(
                            color: headerLevel == 2
                                ? ColorConstant.floatingActionBtnColor
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyHeaders(3);
                    },
                    child: Container(
                      width: size.width * 0.3,
                      height: size.height * 0.07,
                      color: ColorConstant.bottomNavEdit,
                      child: Center(
                        child: Text(
                          "Subheading",
                          style: AppStyle.heading3Txt.copyWith(
                            color: headerLevel == 3
                                ? ColorConstant.floatingActionBtnColor
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyHeaders(0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.bottomNavEdit,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                      ),
                      width: size.width * 0.2,
                      height: size.height * 0.07,
                      child: Center(
                        child: Text(
                          "Body",
                          style: AppStyle.description.copyWith(
                            color: headerLevel == 0
                                ? ColorConstant.floatingActionBtnColor
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: size.height * 0.07,
              color: ColorConstant.bottomNavEdit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyBold();
                    },
                    imagePath: "assets/icons_png/WHITE/Bold type.png",
                    color: !_isBold
                        ? Colors.white.withOpacity(0.3)
                        : ColorConstant.floatingActionBtnColor,
                    height: 30,
                    width: 30,
                  ),
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyItalic();
                    },
                    imagePath: "assets/icons_png/WHITE/Italic.png",
                    color: !_isItalic
                        ? Colors.white.withOpacity(0.3)
                        : ColorConstant.floatingActionBtnColor,
                    height: 30,
                    width: 30,
                  ),
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyStrike();
                    },
                    imagePath: "assets/icons_png/WHITE/strikethrough.png",
                    color: !_strikeThrough
                        ? Colors.white.withOpacity(0.3)
                        : ColorConstant.floatingActionBtnColor,
                    height: 30,
                    width: 30,
                  ),
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      _applyUnderline();
                    },
                    imagePath: "assets/icons_png/WHITE/underline.png",
                    color: !_isUnderline
                        ? Colors.white.withOpacity(0.3)
                        : ColorConstant.floatingActionBtnColor,
                    height: 30,
                    width: 30,
                  ),
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      widget.quillController.undo();
                    },
                    imagePath: "assets/icons_png/WHITE/Refresh-1.png",
                    color: Colors.white.withOpacity(0.3),
                    height: 30,
                    width: 30,
                  ),
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      widget.quillController.redo();
                    },
                    imagePath: "assets/icons_png/WHITE/Refresh-2.png",
                    color: Colors.white.withOpacity(0.3),
                    height: 30,
                    width: 30,
                  ),
                  CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      controller.toggleWidget(0);
                    },
                    imagePath: "assets/icons_png/WHITE/Down.png",
                    color: Colors.white.withOpacity(0.3),
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstWidget() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.gray900,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      height: size.height * 0.06,
      key: const ValueKey(2),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomImageView(
              onTap: () {
                VibrationService.vibrate();

                uploadImg(false);
              },
              imagePath: "assets/icons_png/WHITE/Camera.png",
              color: Colors.white.withOpacity(0.3),
              height: 30,
              width: 30,
            ),
            CustomImageView(
              onTap: () {
                VibrationService.vibrate();

                Get.bottomSheet(
                  BottomImageSelector(
                    focusNodeQuillEditor: widget.focusNodeQuillEditor,
                    quillController: widget.quillController,
                  ),
                  isScrollControlled: true,
                );

                // _uploadImg(true);
              },
              imagePath: "assets/icons_png/WHITE/Image 2.png",
              color: Colors.white.withOpacity(0.3),
              height: 30,
              width: 30,
            ),
            CustomImageView(
              onTap: () {
                VibrationService.vibrate();

                _applyList();
              },
              imagePath: "assets/icons_png/WHITE/Board tasks.png",
              color: Colors.white.withOpacity(0.3),
              height: 30,
              width: 30,
            ),
            CustomImageView(
              onTap: () {
                VibrationService.vibrate();

                controller.toggleWidget(1);
              },
              imagePath: "assets/icons_png/WHITE/AA 2.png",
              color: Colors.white.withOpacity(0.3),
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdWidget() {
    return Container(
      key: const ValueKey(3),
      decoration: BoxDecoration(
        color: ColorConstant.gray900,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      height: size.height * 0.07,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 5),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              CustomTextFormField(
                width: 220,
                focusNode: widget.focusNodeSearch,
                controller: searchTxtCntrl,
                //onChanged: _textChanged,
                hintText: "lbl_rechercher".tr,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
                suffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomImageView(
                    onTap: () {
                      VibrationService.vibrate();

                      try {
                        if (searchTxtCntrl.value.text != "") {
                          _offsets = widget.quillController.document
                              .search(searchTxtCntrl.value.text);
                          _index = 0;
                          _text = searchTxtCntrl.value.text;

                          if (_offsets!.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "No Results",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }
                          log(_offsets!.toList().toString());
                          if (_offsets != null || _offsets!.isNotEmpty) {
                            _moveToPosition();
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    imagePath: "assets/icons_png/WHITE/Search.png",
                    color: ColorConstant.indigo5099,
                    height: 20,
                    width: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CustomImageView(
                  onTap: () {
                    VibrationService.vibrate();

                    setState(() {
                      _index -= 1;
                    });
                    _moveToPosition();
                  },
                  imagePath: "assets/icons_png/BLACK/uparrow.png",
                  color: ColorConstant.indigo5099,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CustomImageView(
                  onTap: () {
                    VibrationService.vibrate();

                    setState(() {
                      _index += 1;
                    });
                    _moveToPosition();
                  },
                  imagePath: "assets/icons_png/BLACK/Down.png",
                  color: ColorConstant.indigo5099,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.07),
                child: GestureDetector(
                  onTap: () {
                    VibrationService.vibrate();

                    searchTxtCntrl.clear();
                    controller.toggleWidget(0);
                  },
                  child: Text(
                    "Done".tr,
                    style: AppStyle.txtMulishRegular14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: controller.showFirstWidget.value == 0
          ? _buildFirstWidget()
          : controller.showFirstWidget.value == 1
              ? _buildSecondWidget()
              : _buildThirdWidget(),
    );
  }

  void _moveToPosition() {
    try {
      if (_offsets != null) {
        widget.quillController.updateSelection(
            TextSelection(
                baseOffset: _offsets![_index],
                extentOffset: _offsets![_index] + _text.length),
            ChangeSource.local);
      }
    } catch (e) {
      log("${e}move search");
    }
  }

  void _applyList() {
    try {
      final selection = widget.quillController.selection;
      if (!selection.isCollapsed) {
        final formats = widget.quillController.getSelectionStyle();
        var isbold = formats.containsKey(Attribute.unchecked.key);
        widget.quillController.formatSelection(Attribute.unchecked);

        if (!isbold) {
          widget.quillController.formatSelection(Attribute.unchecked);
        } else {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.unchecked, null));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _applyHeaders(int num) {
    try {
      final selection = widget.quillController.selection;
      if (!selection.isCollapsed) {
        // final formats = widget.quillController.getSelectionStyle();
        //var header = formats.containsKey(Attribute.header.key);
        if (num == 0 || headerLevel == num) {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.header, null));
          return;
        }
        // if (!header) {
        widget.quillController
            .formatSelection(Attribute.clone(Attribute.header, num));
        // } else {
        // widget.quillController
        //     .formatSelection(Attribute.clone(Attribute.header, null));
        // }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _applyStrike() {
    try {
      final selection = widget.quillController.selection;
      if (!selection.isCollapsed) {
        final formats = widget.quillController.getSelectionStyle();
        var isbold = formats.containsKey(Attribute.strikeThrough.key);

        if (!isbold) {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.strikeThrough, true));
        } else {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.strikeThrough, null));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _applyUnderline() {
    try {
      final selection = widget.quillController.selection;
      if (!selection.isCollapsed) {
        final formats = widget.quillController.getSelectionStyle();
        var isbold = formats.containsKey(Attribute.underline.key);

        if (!isbold) {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.underline, true));
        } else {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.underline, null));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _applyItalic() {
    try {
      final selection = widget.quillController.selection;
      if (!selection.isCollapsed) {
        final formats = widget.quillController.getSelectionStyle();
        var isbold = formats.containsKey(Attribute.italic.key);

        if (!isbold) {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.italic, true));
        } else {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.italic, null));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _applyBold() {
    try {
      final selection = widget.quillController.selection;
      if (!selection.isCollapsed) {
        final formats = widget.quillController.getSelectionStyle();
        var isbold = formats.containsKey(Attribute.bold.key);

        if (!isbold) {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.bold, true));
        } else {
          widget.quillController
              .formatSelection(Attribute.clone(Attribute.bold, null));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  uploadImg(bool isGallery) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image;
    if (isGallery) {
      image = await picker.pickImage(source: ImageSource.gallery);
    } else {
      image = await picker.pickImage(source: ImageSource.camera);
    }
    if (image != null) {
      addSpace();
      String url = await controller.saveImg(File(image.path));
      final index = widget.quillController.selection.baseOffset;
      final length = widget.quillController.selection.extentOffset - index;
      widget.quillController
          .replaceText(index, length, BlockEmbed.image(url), null);
      addSpace();
    }
  }

  addSpace({String st = "\n\n"}) {
    widget.quillController.document
        .insert(widget.quillController.document.length - 1, st);
    widget.focusNodeQuillEditor.nextFocus();
  }
}
