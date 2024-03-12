import '../../../app_export.dart';
import '../../../services/vibtaion_service.dart';
import '../../generate_note_screen/controller/generate_note_controller.dart';
import '../controller/idea_genarator_controller.dart';
import '../widget/idea_prompt_widget.dart';
import 'prompt_screen_widget.dart';

class IdeaPromptPageWidget extends StatefulWidget {
  const IdeaPromptPageWidget(
      {super.key, required this.id, required this.scrollController});
  final ScrollController scrollController;

  final String id;

  @override
  State<IdeaPromptPageWidget> createState() => _IdeaPromptPageWidgetState();
}

class _IdeaPromptPageWidgetState extends State<IdeaPromptPageWidget> {
  var ideaGenaratorController = Get.put(IdeaGenaratorController());
  var generateNoteController = Get.put(GenerateNoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ideaGenaratorController.getNameById(widget.id) ?? "",
            style: AppStyle.txtMontserratAlternatesSemiBold24,
          ),
          const SizedBox(
            height: 15,
          ),
          GridView.builder(
            controller: widget.scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            shrinkWrap: true,
            itemCount:
                ideaGenaratorController.promptsCustomModelListSaearch.length,
            itemBuilder: (context, index) {
              var model =
                  ideaGenaratorController.promptsCustomModelListSaearch[index];

              return GestureDetector(
                onTap: () async {
                  VibrationService.vibrate();

                  Get.back();
                  Get.bottomSheet(
                    PromptScreenWidget(promptsCustomModel: model),
                    isScrollControlled: true,
                  );
                  // Get.to(() => PromptScreenWidget(promptsCustomModel: model));
                },
                child: IdeaPromptWidget(model: model),
              );
            },
          ),
        ],
      ),
    );
  }
}
