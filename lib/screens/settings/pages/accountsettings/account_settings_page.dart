import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/settings/pages/accountsettings/viewmodels/account_settings_viewmodel.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/if_else_widget.dart';

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPage({Key key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  TextEditingController _firstnameController;
  TextEditingController _lastnameController;
  TextEditingController _emailController;
  TextEditingController _languageController;
  FocusNode _firstnameFocus = FocusNode();
  FocusNode _lastnameFocus = FocusNode();

  void _onAttemptingSignOut(BuildContext context) {
    final localization = AppLocalization.of(context);

    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(
          vertical: AppDimens.lgPadding,
          horizontal: AppDimens.xlPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              localization.notice.beforeSignOut,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: AppDimens.mdPadding,
            ),
            AppButton(
              onPressed: () async {
                await Provider.of<AuthService>(context, listen: false)
                    .signOut();
                AppRouter().goToLaunch();
              },
              text: localization.actions.signOut,
              color: AppColors.errorColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final appData = Provider.of<AppDataService>(context, listen: false);
    _firstnameController =
        TextEditingController(text: appData.currentUser?.firstname)
          ..addListener(() {});
    _lastnameController =
        TextEditingController(text: appData.currentUser?.lastname)
          ..addListener(() {});
    _emailController = TextEditingController(text: appData.currentUser?.email);
    _languageController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _languageController.text =
          AppLocalization.of(context).labels.languageName;
    });
  }

  @override
  void dispose() {
    _firstnameController?.dispose();
    _lastnameController?.dispose();
    _emailController?.dispose();
    _languageController?.dispose();
    _firstnameFocus.dispose();
    _lastnameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return ChangeNotifierProvider<AccountSettingsViewModel>(
      create: (_) => AccountSettingsViewModel(
        Provider.of<DbService>(context, listen: false),
        Provider.of<AppDataService>(context, listen: false),
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                brightness: Brightness.light,
                title: Text(
                  localization.labels.accountSettings,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 2,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  child: Selector<AccountSettingsViewModel, bool>(
                    builder: (_, submitting, child) {
                      return IfElseWidget(
                        condition: submitting,
                        ifWidget: child,
                      );
                    },
                    selector: (_, _viewModel) => _viewModel.submitting,
                    child: const LinearProgressIndicator(),
                  ),
                  preferredSize: Size.fromHeight(1),
                ),
              )
            ];
          },
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.lgPadding,
                  vertical: AppDimens.lgPadding,
                ),
                child: Consumer<AccountSettingsViewModel>(
                  builder: (_, _viewModel, __) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _firstnameController,
                                enabled: _viewModel.editingFirstname,
                                focusNode: _firstnameFocus,
                                onEditingComplete: () =>
                                    _viewModel.setFirstname(
                                  _firstnameController.text.trim(),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: localization.labels.firstname,
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_viewModel.editingFirstname) {
                                  return _viewModel.setFirstname(
                                      _firstnameController.text.trim());
                                }
                                _viewModel.setEditingFirstname(true);
                                Future.delayed(Duration(milliseconds: 200), () {
                                  FocusScope.of(context)
                                      .requestFocus(_firstnameFocus);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppDimens.smPadding,
                                ),
                                child: Text(
                                  _viewModel.editingFirstname
                                      ? localization.actions.save.toUpperCase()
                                      : localization.actions.edit.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppDimens.smPadding,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _lastnameController,
                                enabled: _viewModel.editingLastname,
                                focusNode: _lastnameFocus,
                                onEditingComplete: () => _viewModel.setLastname(
                                  _lastnameController.text.trim(),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: localization.labels.lastname,
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_viewModel.editingLastname) {
                                  return _viewModel.setLastname(
                                      _lastnameController.text.trim());
                                }
                                _viewModel.setEditingLastname(true);
                                Future.delayed(Duration(milliseconds: 200), () {
                                  FocusScope.of(context)
                                      .requestFocus(_lastnameFocus);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppDimens.smPadding,
                                ),
                                child: Text(
                                  _viewModel.editingLastname
                                      ? localization.actions.save.toUpperCase()
                                      : localization.actions.edit.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppDimens.smPadding,
                        ),
                        TextField(
                          controller: _emailController,
                          enabled: false,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: localization.labels.email,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              // fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppDimens.smPadding,
                        ),
                        TextField(
                          controller: _languageController,
                          enabled: false,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: localization.labels.language,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              // fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Spacer(),
              FractionallySizedBox(
                widthFactor: .267,
                child: Image.asset(
                  AssetImages.treeBG,
                  fit: BoxFit.fitWidth,
                ),
              ),
              // SizedBox(
              //   height: AppDimens.mdPadding,
              // ),
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
              ),
              Ink(
                color: AppColors.secondary,
                child: InkWell(
                  enableFeedback: true,
                  onTap: () => this._onAttemptingSignOut(context),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(
                      AppDimens.padding,
                    ),
                    child: Text(
                      localization.labels.toSignOut,
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
