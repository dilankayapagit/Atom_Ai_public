import 'package:fluttertoast/fluttertoast.dart';

import '../../../app_export.dart';
import '../../../services/vibtaion_service.dart';
import '../controller/notes_home_controller.dart';
import '../widgets/search_note_widget.dart';

class BottomSheetSearchHome extends StatefulWidget {
  const BottomSheetSearchHome(
      {super.key,
      this.widthbar = 220,
      required this.index,
      required this.forcusNode});
  final double widthbar;
  final int index;

  final FocusNode forcusNode;
  @override
  State<BottomSheetSearchHome> createState() => _BottomSheetSearchHomeState();
}

class _BottomSheetSearchHomeState extends State<BottomSheetSearchHome> {
  TextEditingController textEditingController = TextEditingController();
  var controller = Get.put(NotesHomeController());

  @override
  Widget build(BuildContext context) {
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
                focusNode: widget.forcusNode,
                width: size.width * 0.7,
                controller: textEditingController,
                hintText: "lbl_rechercher".tr,
                fontStyle: TextFormFieldFontStyle.MulishRegular16,
                textInputAction: TextInputAction.done,
                suffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomImageView(
                    onTap: () {
                      if (textEditingController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please enter valid Name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }
                      Get.to(SearchWidget(
                          name: textEditingController.text,
                          index: widget.index));
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
                padding: EdgeInsets.only(left: size.width * 0.07),
                child: GestureDetector(
                  onTap: () {
                    VibrationService.vibrate();
                    controller.isSearch(false);
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
}
