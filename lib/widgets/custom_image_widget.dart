// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildCustomImageWidget extends StatelessWidget {
  
  String? imagePath;
  double? height;
  double? width;
  BoxFit? fit;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;

  BuildCustomImageWidget({
    this.imagePath,
    this.height,
    this.width,
    this.fit,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildImageView(),
      ),
    );
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return Container(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          );
      }
    }
    return SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.endsWith('.svg')) {
      return ImageType.svg;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png }
