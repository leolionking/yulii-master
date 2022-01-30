import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';

class PrimaryGradientBg extends StatelessWidget {
  const PrimaryGradientBg({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.7, 1.0],
          colors: [
            AppColors.primary,
            Colors.white,
          ],
        ),
      ),
    );
  }
}
