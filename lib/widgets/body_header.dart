import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/my_title.dart';
import 'package:yulli/widgets/searcg_input.dart';

class BodyHeader extends StatelessWidget {
  final String title;
  final int badge;
  final bool hasAppBarBehavior;
  final bool containSearchbar;
  final bool showShadow;

  const BodyHeader({
    Key key,
    @required this.title,
    @required this.badge,
    this.hasAppBarBehavior = false,
    this.containSearchbar = false,
    this.showShadow = false,
  })  : assert(title != null),
        assert(badge != null),
        assert(showShadow != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          if (showShadow)
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 2,
            )
        ],
      ),
      height: hasAppBarBehavior || containSearchbar ? 64 : 56,
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: AppDimens.padding,
              left: AppDimens.lgPadding,
              right: AppDimens.lgPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: !hasAppBarBehavior && !containSearchbar
                  ? <Widget>[
                      MyTitle(title, YulliColors.blue[500], Colors.black),
                      Badge(
                        padding: EdgeInsets.all(8.0),
                        borderRadius: BorderRadius.circular(50),
                        badgeContent: Text(
                          badge.toString(),
                          style: TextStyle(
                            color: YulliColors.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        badgeColor: YulliColors.yellow_light,
                        elevation: 0.0,
                        animationType: BadgeAnimationType.scale,
                      ),
                    ]
                  : hasAppBarBehavior
                      ? [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: YulliColors.grey_dark, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.close,
                              size: 30,
                              color: YulliColors.grey_dark,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ]
                      : [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: YulliColors.grey_dark,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width -
                                (79 + YulliVars.horizpadding),
                            child: SearchInputWidget(
                              hintText: title,
                              bordered: true,
                            ),
                          ),
                        ],
            ),
          ),
          // (hasAppBarBehavior) ? Divider()
        ],
      ),
    );
  }
}
