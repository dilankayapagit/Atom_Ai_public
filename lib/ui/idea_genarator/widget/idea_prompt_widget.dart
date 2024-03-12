
import '../../../app_export.dart';
import '../../../models/prompts/pompts_custom_model.dart';

class IdeaPromptWidget extends StatefulWidget {
  const IdeaPromptWidget({
    super.key,
    required this.model,
  });

  final PromptsCustomModel model;

  @override
  State<IdeaPromptWidget> createState() => _IdeaPromptWidgetState();
}

class _IdeaPromptWidgetState extends State<IdeaPromptWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.ideaPromptColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 100,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstant.ideaPromptIconBackColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: 50,
                height: 50,
                child: CustomImageView(
                  url: widget.model.imgUrl,
                  height: 40,
                  width: 40,
                  color: ColorConstant.ideaPromptIconColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                (widget.model.titleTranslationModel ??
                        {"": ""})[Get.locale?.languageCode ?? 'en'] ??
                    "",
                // widget.model.title ?? "",
                style: AppStyle.txtMontserratAlternatesSemiBold16.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                (widget.model.promptTranslationModel ??
                        {"": ""})[Get.locale?.languageCode ?? 'en'] ??
                    "",
                // widget.model.prompt ?? "",
                style: AppStyle.txtMontserratAlternatesSemiBold16.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                ),
                maxLines: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
