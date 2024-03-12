import 'package:atomai/app_export.dart';

import '../../services/vibtaion_service.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage(
      {super.key,
      required this.height,
      required this.width,
      this.imagePath,
      fit = BoxFit.contain,
      this.svgPath,
      this.margin,
      this.onTap});

  double height;

  double width;

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;
  BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
        VibrationService.vibrate();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          onTap: () {
            onTap!();
          },
          svgPath: svgPath,
          imagePath: imagePath,
          height: height,
          width: width,
          fit: fit,
        ),
      ),
    );
  }
}
