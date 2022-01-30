import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/opacity_button.dart';

enum ImagePickerAction {
  delete,
  gallery,
  // camera,
}

extension ImagePickerActionExtension on ImagePickerAction {
  IconData get iconData {
    switch (this) {
      case ImagePickerAction.delete:
        return FeatherIcons.trash2;
      case ImagePickerAction.gallery:
        return FeatherIcons.image;
      // case ImagePickerAction.camera:
      //   return FeatherIcons.aperture;
    }
    return null;
  }

  String label(BuildContext context) {
    final localization = AppLocalization.of(context);
    switch (this) {
      case ImagePickerAction.delete:
        return localization.labels.deletePicture;
      case ImagePickerAction.gallery:
        return localization.labels.gallery;
      // case ImagePickerAction.camera:
      //   return localization.labels.camera;
    }
    return null;
  }

  bool get isDelete => this == ImagePickerAction.delete;
  bool get isGallery => this == ImagePickerAction.gallery;
  // bool get isCamera => this == ImagePickerAction.camera;
}

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(ImagePickerAction) onActionTap;
  final bool hideDelete;

  const ImagePickerBottomSheet({
    Key key,
    @required this.onActionTap,
    this.hideDelete = false,
  })  : assert(onActionTap != null),
        assert(hideDelete != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: AppDimens.mdPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimens.lgPadding,
              right: AppDimens.lgPadding,
              bottom: AppDimens.mdPadding,
            ),
            child: Text(
              localization.labels.profilePicture,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var i = 0; i < ImagePickerAction.values.length; i++)
                if (!(hideDelete && ImagePickerAction.values[i].isDelete))
                  _ImagePickerBottomSheetButton(
                    action: ImagePickerAction.values[i],
                    onTap: (action) {
                      onActionTap?.call(action);
                      Navigator.of(context).pop();
                    },
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImagePickerBottomSheetButton extends StatelessWidget {
  final ImagePickerAction action;
  final Function(ImagePickerAction) onTap;

  const _ImagePickerBottomSheetButton({
    Key key,
    @required this.action,
    @required this.onTap,
  })  : assert(action != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OpacityButton(
        opacity: .5,
        onTap: () => onTap?.call(action),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimens.mdPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: action.isDelete
                      ? AppColors.errorColor
                      : AppColors.secondary,
                ),
                child: Icon(
                  action.iconData,
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(
                  bottom: AppDimens.smPadding,
                ),
              ),
              Text(
                action.label(context),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGrey,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
