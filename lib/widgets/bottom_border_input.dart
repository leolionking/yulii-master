import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';

class BottomBorderdInput extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType type;
  final bool isObscure;
  final bool isTextarea;
  final TextEditingController controller;
  final FocusNode focus;
  final bool readOnly;
  final bool canAddMedia;
  final VoidCallback onCameraButtonTap;
  final VoidCallback onGalleryButtonTap;

  const BottomBorderdInput({
    Key key,
    this.type,
    this.hintText,
    this.isObscure = false,
    this.isTextarea = false,
    this.controller,
    this.focus,
    this.readOnly,
    this.icon,
    this.canAddMedia,
    this.onCameraButtonTap,
    this.onGalleryButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.2,
                color: AppColors.grey,
              ),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              if (icon != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimens.smPadding,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    TextField(
                      enabled: !(readOnly ?? false),
                      controller: controller,
                      obscureText: isObscure,
                      focusNode: focus,
                      maxLines: isTextarea ? 3 : 1,
                      readOnly: readOnly ?? false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: AppColors.greyDark,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: AppDimens.smPadding,
                          horizontal: AppDimens.padding,
                        ),
                      ),
                    ),
                    if (canAddMedia ?? false)
                      Container(
                        color: Colors.white.withOpacity(.8),
                        margin: const EdgeInsets.only(
                          right: AppDimens.smPadding,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                FeatherIcons.camera,
                                color: const Color(0xFF797979),
                              ),
                              onPressed: onCameraButtonTap,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                FeatherIcons.image,
                                color: const Color(0xFF797979),
                              ),
                              onPressed: onGalleryButtonTap,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
