
import '../../../app_export.dart';
import '../../../models/prompts/category_custom_mode.dart';

class IdeaCategoryWidget extends StatefulWidget {
  const IdeaCategoryWidget(
      {super.key, required this.model, required this.isSelected});

  final CategoryCustomModel model;
  final String isSelected;

  @override
  State<IdeaCategoryWidget> createState() => _IdeaCategoryWidgetState();
}

class _IdeaCategoryWidgetState extends State<IdeaCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        //   height: 20,
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: widget.isSelected == widget.model.id
              ? ColorConstant.floatingActionBtnColor
              : ColorConstant.ideaPromptColor,
        ),
        child: Center(
          child: Text(
            (widget.model.titleTranslationModel ??
                    {"": ""})[Get.locale?.languageCode ?? 'en'] ??
                "",
            style: AppStyle.txtMontserratAlternatesSemiBold16,
          ),
        ),
      ),
    );
  }
}
