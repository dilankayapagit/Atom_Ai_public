import 'package:atomai/app_export.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      this.height = 75,
      this.leadingWidth,
      this.leading,
      this.title,
      this.bottom,
      this.centerTitle,
      this.actions,
      this.colour = Colors.transparent,
      this.systemUiOverlayStyle});

  double height;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  PreferredSizeWidget? bottom;
  Color colour;
  SystemUiOverlayStyle? systemUiOverlayStyle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: systemUiOverlayStyle ??
          SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarColor: ColorConstant.gray900,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
      bottom: bottom,
      elevation: 0,
      toolbarHeight: height,
      titleTextStyle: AppStyle.txtMontserratAlternatesSemiBold24,
      automaticallyImplyLeading: false,
      backgroundColor: colour,
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: title,
      ),
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
}
