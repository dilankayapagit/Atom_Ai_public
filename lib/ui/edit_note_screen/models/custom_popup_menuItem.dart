import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  @override
  final VoidCallback? onTap;

  const CustomPopupMenuItem({
    super.key,
    this.onTap,
    required super.child,
  });

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return _CustomPopupMenuItemState<T>();
  }
}

class _CustomPopupMenuItemState<T>
    extends PopupMenuItemState<T, CustomPopupMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.gray900,
      child: widget.child,
    );
  }
}
