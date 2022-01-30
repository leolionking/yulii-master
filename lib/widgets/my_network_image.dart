import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/screens/preview/preview_screen.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

import 'opacity_button.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({
    Key key,
    @required this.url,
    @required this.width,
    @required this.height,
    this.borderRadius,
    this.onTap,
    this.margin,
  })  : assert(url != null),
        assert(width != null),
        assert(height != null),
        super(key: key);

  final String url;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
          child: SizedBox(
            height: height,
            width: width,
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
        );
      },
      fit: BoxFit.fitWidth,
      errorWidget: (_, __, ___) {
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(borderRadius ?? AppDimens.smPadding),
            color: Colors.white,
          ),
          child: Icon(
            FeatherIcons.alertCircle,
            color: AppColors.errorColor,
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        return OpacityButton(
          onTap: () {
            if (onTap != null) {
              onTap();
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PreviewScreen(
                    fileUrl: url,
                    isVideo: false,
                  ),
                ),
              );
            }
          },
          child: Container(
            height: height,
            margin: margin,
            width: width,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppDimens.smPadding),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
