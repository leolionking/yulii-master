import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/avatar.dart';
import 'package:badges/badges.dart';
import 'package:yulli/widgets/my_avatar.dart';
import 'package:yulli/widgets/notification_badge.dart';

class FixedHeader extends StatelessWidget {
  final User currentUser;
  final int finishedTasksCount;

  const FixedHeader({
    @required this.currentUser,
    this.finishedTasksCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (currentUser == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyAvatar(
              user: currentUser,
              size: 60,
              borderWidth: 2,
              borderColor: Colors.white,
              isSquared: true,
            ),
            // Avatar(
            //   AssetImages.avatarPlaceholder,
            //   imageProvider: AssetImage(AssetImages.avatarPlaceholder),
            // ),
            NotificationBadge(),
          ],
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -25, 0.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: AppDimens.smPadding,
                    right: AppDimens.padding,
                  ),
                  child: Text(
                    localization.templated.hello(
                      firstname: currentUser.firstname,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
              //Spacer(),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 35),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Image.asset(AssetImages.trophy),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Consumer<AppDataService>(
                            builder: (context, _appDataService, child) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: (_appDataService
                                                  .lastCredits?.current ??
                                              0)
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " points",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.sort, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "$finishedTasksCount ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: localization.notice.dealsCompleted,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        //Goal(),
      ],
    );
  }
}
