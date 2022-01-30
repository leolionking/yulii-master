import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/my_avatar.dart';
import 'package:yulli/widgets/opacity_button.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key key,
    @required this.onTap,
    @required this.title,
    @required this.avatarUrl,
    this.subtitle,
    this.avatarRightPadding,
    this.hasBorder = false,
    this.subtitleWidget,
  })  : assert(title != null),
        super(key: key);

  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final String avatarUrl;
  final double avatarRightPadding;
  final bool hasBorder;
  final Widget subtitleWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimens.smPadding,
      ),
      child: OpacityButton(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(
              width: AppDimens.lgPadding,
            ),
            MyAvatar(
              avatarUrl: avatarUrl,
              isSquared: true,
              borderColor: Colors.transparent,
            ),
            avatarRightPadding != null
                ? SizedBox(
                    width: avatarRightPadding,
                  )
                : const SizedBox(
                    width: AppDimens.smPadding,
                  ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                height: hasBorder
                    ? AppDimens.chatListItemHeight
                    : AppDimens.chatListItemAvatarSize,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: hasBorder
                          ? AppColors.dividerColor
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: context.textStyles.chatListItemUserName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: AppDimens.xsPadding,
                    ),
                    if (subtitleWidget != null) subtitleWidget,
                    if (subtitleWidget == null && subtitle != null)
                      Text(
                        subtitle,
                        style: context.textStyles.chatListItemExtract,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
