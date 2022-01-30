import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/yulli_themes.dart';

import 'my_text_widget.dart';

class TextInGrey extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;

  const TextInGrey({
    Key key,
    @required this.label,
    this.maxLines = 2,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyText(
      label,
      style: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      maxLines: maxLines,
      minLines: minLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
