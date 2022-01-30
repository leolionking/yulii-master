import 'package:flutter/material.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/my_avatar.dart';

class MyMembersListItem extends StatelessWidget {
  final User user;
  final Function(User) onItemTap;

  const MyMembersListItem({
    Key key,
    @required this.user,
    @required this.onItemTap,
  })  : assert(user != null),
        assert(onItemTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onItemTap(user),
        splashColor: AppColors.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.mdPadding,
            vertical: 12,
          ),
          // color: Colors.red,
          child: SizedBox(
            height: 32,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyAvatar(
                  user: user,
                  size: 30,
                  borderWidth: 0,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        user.displayName,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              height: 1,
                            ),
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
