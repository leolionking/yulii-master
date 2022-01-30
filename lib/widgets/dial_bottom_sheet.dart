import 'package:email_validator/email_validator.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/utils/snackbar_utils.dart';
import 'package:yulli/constants/firebase_auth_error_codes.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/models/user_obj.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/bottom_border_input.dart';
import 'package:yulli/widgets/bottom_sheet_title_bar.dart';
import 'package:yulli/widgets/clock_widget.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/members_selector.dart';
import 'package:yulli/widgets/my_dropdown.dart';
import 'package:yulli/widgets/my_members_dialog.dart';
import 'package:yulli/widgets/small_text.dart';
import 'package:yulli/widgets/task_selector.dart';

class DialBottomSheetGoal extends StatefulWidget {
  const DialBottomSheetGoal({Key key}) : super(key: key);

  @override
  _DialBottomSheetGoalState createState() => _DialBottomSheetGoalState();
}

class _DialBottomSheetGoalState extends State<DialBottomSheetGoal> {
  final MyLogger _logger = MyLogger('_DialBottomSheetGoalState');

  final pointsList = ['10', '20', '30', '40', '50'];
  TextEditingController _nameController;
  TextEditingController _descController;
  FocusNode _nameFocus = FocusNode();
  FocusNode _descFocus = FocusNode();
  List<User> _selectedUsers = [];
  MembersDialogType _selectedType;
  String _name;

  User _assignedUser;
  User _suggeredUser;
  bool _isMystery = false;
  int _point = 10;
  bool _submitting = false;
  bool _isSuccess = false;
  List<User> assigned = [
    User(email: null, firstname: null, lastname: null, isEmailVerified: null)
  ];
  List<User> suggered = [
    User(email: null, firstname: null, lastname: null, isEmailVerified: null)
  ];

  bool get isNotValid =>
      _selectedUsers.isEmpty || _name == null || _name.isEmpty;

  void _onSubmit() async {
    setState(() {
      _submitting = true;
    });
    final localization = AppLocalization.of(context);
    final currentUser =
        await Provider.of<DbService>(context, listen: false).getCurrentUser();

    var goal = Goal(
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      assignees: _selectedType == MembersDialogType.assigned
          ? [_selectedUsers.first.remoteId]
          : null,
      referer: _selectedType == MembersDialogType.suggered
          ? [_selectedUsers.first.remoteId]
          : null,
      isMystery: _isMystery,
      points: _point,
      authorId: currentUser.remoteId,
      status: Status.opened,
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    );

    try {
      await Provider.of<DbService>(context, listen: false).createGoals(goal);

      setState(() {
        _submitting = false;
        _isSuccess = true;
      });
      Future.delayed(Duration(milliseconds: 1720), () {
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      if (e.code == FirebaseAuthErrorCodes.networkRequestFailed) {
        Fluttertoast.showToast(
          msg: localization.errors.exceptions.networkConnectionFailed,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      MyLogger.err(
        message: e.message,
        tag: '_DialBottomSheetGoalState',
        error: e,
      );
    } catch (e) {
      MyLogger.err(
        message: e,
        tag: "_DialBottomSheetGoalState",
        error: e,
      );
    } finally {
      setState(() {
        _submitting = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()
      ..addListener(() {
        _name = _nameController.text;
      });
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _nameFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: AppDimens.padding + 56,
                  ),
                  BottomBorderdInput(
                    type: TextInputType.text,
                    hintText: localization.labels.goalName,
                    controller: _nameController,
                    focus: _nameFocus,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  BottomBorderdInput(
                    type: TextInputType.text,
                    hintText: localization.labels.description,
                    isTextarea: true,
                    controller: _descController,
                    focus: _descFocus,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: YulliVars.horizpadding,
                      right: YulliVars.horizpadding,
                      top: 40,
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SmallText(localization.labels.members),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              MyMembersSelector(
                                initialMembers: _selectedUsers,
                                onMemberSelected: (user, type) {
                                  setState(() {
                                    _selectedUsers = [user];
                                    _selectedType = type;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: YulliVars.horizpadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SmallText(localization.labels.requiredPoints),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                MyDropDown(
                                  items: pointsList,
                                  onChanged: (points) {
                                    setState(() {
                                      _point = points;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 10,
                        child: TaskSelector(
                          localization.labels.relatedDeals,
                          selected: [],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 60, left: YulliVars.horizpadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SmallText(
                                localization.labels.mysteryGiftQuestionMark,
                                bold: true,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(
                                localization
                                    .notices.mysteryGiftNoticeAtCreation,
                                style: TextStyle(
                                  color: YulliColors.grey_dark,
                                  fontSize: 9,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(top: 45, left: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Switch(
                                value: _isMystery,
                                onChanged: (value) {
                                  setState(() {
                                    _isMystery = value;
                                  });
                                },
                                activeTrackColor: YulliColors.blue[500],
                                activeColor: YulliColors.yellow[500],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppDimens.lgPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.mdPadding,
                    ),
                    child: AppButton(
                      onPressed: this._onSubmit,
                      loading: _submitting,
                      disabled: this.isNotValid,
                      text: localization.actions.addGoal,
                    ),
                  ),
                  Container(
                    height: AppDimens.xxlPadding,
                    alignment: Alignment.center,
                    child: _submitting
                        ? CircularProgressIndicator()
                        : _isSuccess
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FeatherIcons.check,
                                    color: AppColors.primary,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: AppDimens.padding,
                                  ),
                                  Text(
                                    localization.notices.goalCreated,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: AppColors.primary,
                                        ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: BottomSheetTitleBar(
                title: localization.actions.addGoal,
                onActionPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class DialBottomSheetFriend extends StatefulWidget {
  const DialBottomSheetFriend({Key key}) : super(key: key);

  @override
  _DialBottomSheetFriendState createState() => _DialBottomSheetFriendState();
}

class _DialBottomSheetFriendState extends State<DialBottomSheetFriend> {
  final MyLogger _logger = MyLogger('_DialBottomSheetFriendState');
  TextEditingController _controller;
  bool _submitting = false;
  bool _isSuccess = false;
  String _error;

  void _onSubmit() async {
    setState(() {
      _error = null;
    });
    final email = _controller.text.trim();
    final localization = AppLocalization.of(context);

    if (!EmailValidator.validate(email)) {
      setState(() {
        _error = localization.errors.validations.invalidEmail;
      });
      return;
    }

    final currentUser =
        await Provider.of<DbService>(context, listen: false).getCurrentUser();
    if (email == currentUser.email) {
      setState(() {
        _error = localization.errors.validations.sameEmailThanYou;
      });
      return;
    }
    setState(() {
      _submitting = true;
    });
    try {
      final result = await Provider.of<DbService>(context, listen: false)
          .sendFriendInvitation(email);

      if (!result) {
        setState(() {
          _error = localization.errors.validations.alreadyFriend;
        });
        return;
      }
      setState(() {
        _isSuccess = true;
      });

      Future.delayed(Duration(milliseconds: 1200), () {
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      _logger.e(e.message, error: e);
      if (e.code == FirebaseAuthErrorCodes.networkRequestFailed) {
        Fluttertoast.showToast(
          msg: localization.errors.exceptions.networkConnectionFailed,
        );
      }
    } catch (e) {
      _logger.e(e.toString(), error: e);
      Fluttertoast.showToast(
        msg: localization.errors.exceptions.unexpected,
      );
    } finally {
      setState(() {
        _submitting = false;
      });
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        constraints: BoxConstraints(
          minWidth: constraints.minHeight,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: AppDimens.padding + 56,
                  ),
                  Padding(
                    // color: Colors.white,
                    padding: const EdgeInsets.only(
                      top: AppDimens.lgPadding,
                      left: AppDimens.xlPadding,
                      right: AppDimens.xlPadding,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            // border: baseBorder,
                            // enabledBorder: baseBorder,
                            hintText: localization.labels.enterFriendEmail,
                            errorText: _error,
                          ),
                        ),
                        SizedBox(
                          height: AppDimens.padding,
                        ),
                        AppButton(
                          onPressed: this._onSubmit,
                          loading: _submitting,
                          text: localization.actions.sendInvitation,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 100,
                          alignment: Alignment.center,
                          child: IfElseWidget(
                            condition: _submitting,
                            ifWidget: const CircularProgressIndicator(),
                            elseIfCondition: _isSuccess,
                            elseIfWidget: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FeatherIcons.check,
                                  color: AppColors.primary,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: AppDimens.padding,
                                ),
                                Text(
                                  localization.notices.invitationSent,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: AppColors.primary,
                                      ),
                                ),
                              ],
                            ),
                            elseWidget: const SizedBox(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: BottomSheetTitleBar(
                title: localization.actions.addFriend,
                onActionPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
