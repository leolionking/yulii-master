import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/yulli_themes.dart';

class Avatar extends StatelessWidget {
  final ImageProvider imageProvider;
  final double width;
  final String image;
  final Color borderColor;
  final double borderWidth;

  const Avatar(
    this.image, {
    @required this.imageProvider,
    this.width = 55.0,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.grey,
          width: borderWidth ?? .5,
        ),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: imageProvider ?? AssetImage(image),
        ),
      ),
    );
  }
}
