import 'dart:ui';

import 'package:atomai/app_export.dart';

import '../../../models/prompts/pompts_custom_model.dart';
import '../../../services/vibtaion_service.dart';
import '../../../widgets/custom_button.dart';
import '../../generate_note_screen/controller/generate_note_controller.dart';
import '../widget/idea_prompt_widget.dart';

class PromptScreenWidget extends StatefulWidget {
  final PromptsCustomModel promptsCustomModel;
  const PromptScreenWidget({super.key, required this.promptsCustomModel});

  @override
  State<PromptScreenWidget> createState() => _PromptScreenWidgetState();
}

class _PromptScreenWidgetState extends State<PromptScreenWidget> {
  TextEditingController textEditingController = TextEditingController();
  var generateNoteController = Get.put(GenerateNoteController());

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(
        text: (widget.promptsCustomModel.promptTranslationModel ??
                {"": ""})[Get.locale?.languageCode ?? 'en'] ??
            "");
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        // decoration: BoxDecoration(
        //   color: ColorConstant.gray900,
        //   borderRadius: BorderRadius.circular(20),
        // ),
        decoration: BoxDecoration(
          color: ColorConstant.gray900,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 185,
                  width: 185,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IdeaPromptWidget(
                      model: widget.promptsCustomModel,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "modify_the_prompt".tr,
                      style: AppStyle.txtMontserratAlternatesSemiBold24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  width: 366,
                  maxLines: 5,
                  focusNode: FocusNode(),
                  controller: textEditingController,
                  hintText: "".tr,
                  margin: getMargin(left: 7, top: 7),
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onTap: () {
                      try {
                        VibrationService.vibrate();
                        generateNoteController
                            .searchTxtCtl(textEditingController);
                        generateNoteController.getCompleteionButton();
                      } catch (e) {
                        print(e.toString());
                      } finally {
                        Get.back();
                      }
                    },
                    height: 55,
                    width: 326,
                    text: "Generate".tr,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
