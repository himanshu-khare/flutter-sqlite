import 'package:flutter/material.dart';
import 'package:fluttersqlite/core/app_export.dart';

class CustomIconButtonWidget extends StatelessWidget {
  CustomIconButtonWidget({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: 
                BoxDecoration(
                  color: appTheme.gray200,
                  borderRadius: BorderRadius.circular(21.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}
