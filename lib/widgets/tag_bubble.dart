import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';

enum TagType { newElement, claimed }

extension TagTypeExt on TagType {
  String label(BuildContext context) {
    final localization = AppLocalization.of(context);
    switch (this) {
      case TagType.newElement:
        return localization.labels.newItem;
      case TagType.claimed:
        return localization.labels.claimedItem;
      default:
        return null;
    }
  }

  Color get color {
    switch (this) {
      case TagType.newElement:
        return const Color(0xFF43D7B5);
      case TagType.claimed:
        return const Color(0xFFDF2D13);
      default:
        return null;
    }
  }
}

class TagBubble extends StatelessWidget {
  final TagType tagType;

  const TagBubble({
    Key key,
    @required this.tagType,
  })  : assert(tagType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: tagType.color,
      ),
      child: Text(
        tagType.label(context),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
