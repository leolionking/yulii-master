import 'package:flutter/material.dart';
import 'package:yulli/constants/asset_images.dart';

class YulliLogo extends StatelessWidget {
  const YulliLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .5,
      child: Image.asset(
        AssetImages.yulliLogo,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
