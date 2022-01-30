import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class MyAvatar extends StatelessWidget {
  final User user;
  final String avatarUrl;
  final Color borderColor;
  final double borderWidth;
  final double size;
  final double borderRadius;
  final bool loading;
  final bool isSquared;

  const MyAvatar({
    Key key,
    @required this.avatarUrl,
    this.user,
    this.borderColor = AppColors.avatarDefaultBorderColor,
    this.size = 55,
    this.borderWidth = 2,
    this.loading = false,
    this.isSquared = false,
    this.borderRadius,
  })  : assert(size != null),
        assert(borderWidth != null),
        assert(loading != null, "loading cannot be null"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataService>(context, listen: false);
    final imageUrl = avatarUrl ??
        ((appData.currentUser.remoteId == user?.remoteId)
            ? appData.currentUser.avatarUrl
            : user?.avatarUrl);

    if (!loading) {
      if (imageUrl != null) {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgess) =>
              Container(
            padding: const EdgeInsets.all(AppDimens.padding),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                width: borderWidth,
                color: borderColor,
              ),
              borderRadius:
                  isSquared ? BorderRadius.circular(borderRadius ?? 16) : null,
            ),
            child: CircularProgressIndicator(
              value: downloadProgess.progress,
            ),
          ),
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: isSquared ? BoxShape.rectangle : BoxShape.circle,
              border: Border.all(
                width: borderWidth,
                color: borderColor,
              ),
              borderRadius:
                  isSquared ? BorderRadius.circular(borderRadius ?? 16) : null,
            ),
            child: Icon(
              FeatherIcons.alertCircle,
              color: AppColors.errorColor,
            ),
          ),
          imageBuilder: (context, imageProvider) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: isSquared ? BoxShape.rectangle : BoxShape.circle,
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                ),
                borderRadius: isSquared
                    ? BorderRadius.circular(borderRadius ?? 16)
                    : null,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } else {
        return SizedBox(
          width: size,
          height: size,
          child: isSquared
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16),
                  child: Image.asset(
                    AssetImages.avatarPlaceholder,
                    fit: BoxFit.cover,
                  ),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage(AssetImages.avatarPlaceholder),
                ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppDimens.padding),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: isSquared ? BoxShape.rectangle : BoxShape.circle,
        border: Border.all(
          width: borderWidth,
          color: borderColor,
        ),
      ),
      child: const CircularProgressIndicator(),
    );
  }
}
