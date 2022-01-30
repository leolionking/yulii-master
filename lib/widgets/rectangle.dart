import 'package:flutter/material.dart';
import 'package:yulli/themes/app_dimens.dart';

class Rectangle extends StatelessWidget {
  final Color color;
  final Widget child;
  final ImageProvider background;
  final double radius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double width;
  final VoidCallback onTap;

  const Rectangle({
    Key key,
    @required this.child,
    @required this.background,
    this.color = Colors.white,
    this.radius = 8.0,
    this.padding = const EdgeInsets.all(AppDimens.padding),
    this.width,
    this.onTap,
    this.margin = EdgeInsets.zero,
  })  : assert(radius != null),
        assert(padding != null),
        assert(margin != null),
        assert(child != null),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: background != null
                ? DecorationImage(
                    image: background,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
