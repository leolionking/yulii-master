import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/app_colors.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final dimens = AppDimens.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 140,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: false,
              title: Text(
                localization.labels.terms,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: dimens.getSizeByScreenType(
                    {
                      DeviceScreenType.mediumPhone: 16,
                      DeviceScreenType.largePhone: 20,
                      DeviceScreenType.smallTablet: 22,
                      DeviceScreenType.mediumTablet: 24,
                      DeviceScreenType.largeTablet: 24,
                    },
                    defaultValue: 14,
                  ),
                  color: AppColors.defaultTextColor,
                ),
              ),
            ),
          ),
          // content here
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.mdPadding,
            ),
          ),
        ],
      ),
    );
  }
}
