import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/firebase_auth_error_codes.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/bottom_border_input.dart';
import 'package:yulli/widgets/bottom_sheet_title_bar.dart';
import 'package:yulli/widgets/date_picker_widget.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/member_selector.dart';
import 'package:yulli/widgets/members_selector.dart';
import 'package:yulli/widgets/my_date_picker.dart';
import 'package:yulli/widgets/my_dropdown.dart';
import 'package:yulli/widgets/my_members_dialog.dart';
import 'package:yulli/widgets/small_text.dart';
import 'package:yulli/widgets/status_selector.dart';
import 'package:yulli/widgets/task_selector.dart';

class DialBottomSheetTasks extends StatefulWidget {
  const DialBottomSheetTasks({Key key}) : super(key: key);

  @override
  _DialBottomSheetTasksState createState() => _DialBottomSheetTasksState();
}

class _DialBottomSheetTasksState extends State<DialBottomSheetTasks> {
  final MyLogger _logger = MyLogger('_DialBottomSheetTasksState');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  FocusNode _descFocus = FocusNode();
  List<User> assigned = [
    User(email: null, firstname: null, lastname: null, isEmailVerified: null)
  ];
  List<User> suggered = [
    User(email: null, firstname: null, lastname: null, isEmailVerified: null)
  ];
  DateTime selectedDate = DateTime.now().add(Duration(minutes: 30));
  List<User> _selectedUsers = [];
  MembersDialogType _selectedType;
  Status _selectedStatus = Status.opened;

  User _assignedUser;
  DateTime _selectedDate;
  Goal _selectedGoal;

  bool _submitting = false;
  bool _isSuccess = false;
  int _point = 10;
  final pointsList = ['10', '20', '30', '40', '50'];

  bool get isNotValid => _selectedUsers.isEmpty || _nameController.text.isEmpty;

  void _onSubmit() async {
    print('herrrrrr');
    setState(() {
      _submitting = true;
    });
    final localization = AppLocalization.of(context);
    final dbService = Provider.of<DbService>(context, listen: false);

    final currentUser = await dbService.getCurrentUser();

    var task = Task(
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      points: _point,
      authorId: currentUser.remoteId,
      assignees: [_selectedUsers.first.remoteId],
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
      status: _selectedStatus,
      dueDate: _selectedDate,
      goalId: _selectedGoal != null ? _selectedGoal.remoteId : null,
    );

    try {
      await dbService.createTask(task);

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
      _logger.e(
        e.message,
        error: e,
      );
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: localization.errors.exceptions.unexpected,
        toastLength: Toast.LENGTH_LONG,
      );
      _logger.e(
        e,
        error: e,
      );
    } finally {
      setState(() {
        _submitting = false;
      });
    }
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
                    hintText: localization.labels.dealName,
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SmallText(localization.labels.members),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              MyMembersSelector(
                                initialMembers: _selectedUsers,
                                initialType: MembersDialogType.assigned,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SmallText(localization.labels.date),
                              SizedBox(
                                height: 10,
                              ),
                              MyDatePicker(
                                initialDate: _selectedDate,
                                showFormatedDate: _selectedDate != null,
                                onDateSelected: (selectedDate) {
                                  setState(() {
                                    _selectedDate = selectedDate;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: AppDimens.lgPadding,
                            left: YulliVars.horizpadding,
                            right: YulliVars.horizpadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SmallText(localization.labels.points),
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: AppDimens.lgPadding,
                            right: AppDimens.lgPadding,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SmallText(localization.labels.status),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              StatusSelector(
                                initialStatus: _selectedStatus,
                                onStatusSelected: (status) {
                                  setState(() {
                                    _selectedStatus = status;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 60, horizontal: 70),
                    child: AppButton(
                      onPressed: this._onSubmit,
                      loading: _submitting,
                      disabled: isNotValid,
                      text: localization.actions.addDeal,
                    ),
                  ),
                  Container(
                    height: AppDimens.xxlPadding,
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
                            localization.notices.dealCreated,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: AppColors.primary,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: BottomSheetTitleBar(
                title: localization.actions.addDeal,
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
