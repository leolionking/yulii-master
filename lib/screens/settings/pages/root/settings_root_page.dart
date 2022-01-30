import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/settings/routing/settings_router.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_bar_ok_button.dart';
import 'package:yulli/widgets/app_button.dart';

const termsUrl = "https://yuliigames.com/termes-et-conditions";
const policies = "https://yuliigames.com/politique-de-confidentialit%C3%A9";

enum SettingsPageItem {
  accountSettings,
  about,
  tutorial,
  qa,
  terms,
  privacy,
}

class SettingsRootPage extends StatefulWidget {
  const SettingsRootPage({Key key}) : super(key: key);

  @override
  _SettingsRootPageState createState() => _SettingsRootPageState();
}

class _SettingsRootPageState extends State<SettingsRootPage> {
  void _onListTileItemTap(SettingsPageItem pageItem) async {
    switch (pageItem) {
      case SettingsPageItem.accountSettings:
        SettingsRouter().goToAccountSettingsPage();
        break;
      case SettingsPageItem.about:
        SettingsRouter().goToAboutPage(context);
        break;
      case SettingsPageItem.tutorial:
        AppRouter().goToOnboarding(context, fromSettings: true);
        break;
      case SettingsPageItem.qa:
        SettingsRouter().goToQaPage();
        break;
      case SettingsPageItem.terms:
        if (await canLaunch(termsUrl)) {
          await launch(termsUrl, forceWebView: true);
        } else {
          Fluttertoast.showToast(msg: 'Cannot open url');
        }
        // SettingsRouter().goToTermsPage();
        break;
      case SettingsPageItem.privacy:
        if (await canLaunch(policies)) {
          await launch(policies, forceWebView: true);
        } else {
          Fluttertoast.showToast(msg: 'Cannot open url');
        }
        // SettingsRouter().goToPrivacyPage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    final TextStyle listTileTextStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            );
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Transform.scale(
            scale: 1.3,
            child: Image.asset(
              AssetImages.treePot,
              fit: BoxFit.fitHeight,
              alignment: Alignment(-.95, 1.0),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppBar(
                brightness: Brightness.light,
                title: Text(
                  localization.screens.settings,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                actions: <Widget>[
                  AppBarOkButton(
                    onPressed: () => AppRouter().pop(),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimens.xlPadding,
                      ),
                      title: Text(
                        localization.labels.accountSettings,
                        style: listTileTextStyle,
                      ),
                      onTap: () => this
                          ._onListTileItemTap(SettingsPageItem.accountSettings),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimens.xlPadding,
                      ),
                      onTap: () =>
                          this._onListTileItemTap(SettingsPageItem.about),
                      title: Text(
                        localization.labels.about,
                        style: listTileTextStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimens.xlPadding,
                      ),
                      onTap: () =>
                          this._onListTileItemTap(SettingsPageItem.tutorial),
                      title: Text(
                        localization.labels.tutorial,
                        style: listTileTextStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimens.xlPadding,
                      ),
                      onTap: () => this._onListTileItemTap(SettingsPageItem.qa),
                      title: Text(
                        localization.labels.qa,
                        style: listTileTextStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimens.xlPadding,
                      ),
                      onTap: () =>
                          this._onListTileItemTap(SettingsPageItem.terms),
                      title: Text(
                        localization.labels.terms,
                        style: listTileTextStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimens.xlPadding,
                      ),
                      onTap: () =>
                          this._onListTileItemTap(SettingsPageItem.privacy),
                      title: Text(
                        localization.labels.privacyPolicy,
                        style: listTileTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.mdPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      localization.labels.loggedInAs,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      appData.currentUser.email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: AppDimens.padding,
                    ),
                    Text(
                      appData.appInfo.nameAndVersion,
                      style: TextStyle(
                        fontSize: 14,
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
