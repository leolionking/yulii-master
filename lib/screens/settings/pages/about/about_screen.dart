import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

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
                localization.labels.aboutOf(
                  name: "Yulii",
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.defaultTextColor,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.padding,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppDimens.padding,
                horizontal: AppDimens.lgPadding,
              ),
              child: Text(
                localization.longText.about,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.defaultTextColor,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.mdPadding,
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   padding: EdgeInsets.symmetric(
      //     horizontal: AppDimens.lgPadding,
      //     vertical: AppDimens.lgPadding,
      //   ),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: <Widget>[
      //       Text(
      //         localization.labels.aboutOf(
      //           name: appData.appInfo.appName,
      //         ),
      //         style: TextStyle(
      //           fontWeight: FontWeight.w600,
      //           fontSize: 20,
      //         ),
      //       ),
      //       SizedBox(
      //         height: AppDimens.mdPadding,
      //       ),
      //       Text(
      //         localization.longText.about,
      //         style: TextStyle(
      //           color: const Color(0xFFABB5C9),
      //           fontSize: 15,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
