import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_style.dart';
import '../utils/color_constant.dart';
import '../utils/size_utils.dart';

class CustomBlurDialog extends StatefulWidget {
  const CustomBlurDialog(
      {super.key,
      this.title = "",
      this.child,
      this.btnEnable = false,
      this.titleHeight = 70});
  final String title;
  final Widget? child;
  final bool btnEnable;
  final double titleHeight;

  @override
  State<CustomBlurDialog> createState() => _CustomBlurDialogState();
}

class _CustomBlurDialogState extends State<CustomBlurDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        backgroundColor: ColorConstant.gray900,
        child: Container(
          padding: widget.btnEnable
              ? const EdgeInsets.only(top: 15)
              : const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: widget.btnEnable ? widget.titleHeight : null,
                child: Center(
                  child: Text(
                    widget.title,
                    style: AppStyle.txtMulishRegular14.copyWith(
                        letterSpacing: getHorizontalSize(0.14),
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: widget.child,
              )
            ],
          ),
        ),
      ),
    );
  }
}
