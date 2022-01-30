import 'dart:async';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:yulli/abstracts/form_mode_viewmodel.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/viewmodels/add_goal_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/screens/preview/preview_screen.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/utils/file_utils.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/my_dropdown.dart';
import 'package:yulli/widgets/my_members_dialog.dart';
import 'package:yulli/widgets/my_tasks_selector.dart';
import 'package:yulli/widgets/small_text.dart';
import 'package:yulli/widgets/task_selector.dart';
import 'package:yulli/widgets/yulii_page_bottom_sheet.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/services/file_storage_service.dart';

import 'bottom_border_input.dart';
import 'loading_indicator.dart';
import 'members_selector.dart';
import 'my_network_image.dart';
import 'opacity_button.dart';

class YuliiAddGoalBottomSheet extends StatelessWidget {
  final bool isViewing;
  final Goal goal;

  const YuliiAddGoalBottomSheet({
    Key key,
    this.goal,
  })  : isViewing = goal != null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddGoalViewModel(
        AppLocalization.of(context),
        Provider.of<DbService>(context, listen: false),
        Provider.of<FileStorageService>(context, listen: false),
        formMode: isViewing ? FormMode.read : FormMode.create,
      )..setGoal(goal),
      child: _YuliiAddGoalBottomSheet(),
    );
  }
}

class _YuliiAddGoalBottomSheet extends StatefulWidget {
  _YuliiAddGoalBottomSheet({Key key}) : super(key: key);

  @override
  __YuliiAddGoalBottomSheetState createState() =>
      __YuliiAddGoalBottomSheetState();
}

class __YuliiAddGoalBottomSheetState extends State<_YuliiAddGoalBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddGoalViewModel _viewModel;
  StreamSubscription _unexpectedExceptionSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_viewModel.hasGoal) {
        await _viewModel.populateGoal();
      }
    });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<AddGoalViewModel>(context)
      ..init(_formKey)
      ..validateAllInputs(notify: false);

    _unexpectedExceptionSubscription ??=
        _viewModel.unexpectedExceptionStream.listen((event) {
      Fluttertoast.showToast(
        msg: event.message,
        backgroundColor: AppColors.errorColor,
      );
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _unexpectedExceptionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return YulliPageBottomSheet(
      title: _viewModel.mode.isCreating
          ? localization.actions.addGoal
          : _viewModel.mode.isUpdating
              ? localization.actions.editReward
              : localization.labels.reward,
      subtitle: _viewModel.type != null
          ? (_viewModel.type.isPro
              ? localization.labels.proRewardDescription
              : localization.labels.rewardDescription)
          : null,
      loading: _viewModel.submitting || _viewModel.loading,
      onClose: () => context.pop(),
      hideBottomPadding: true,
      showEditButton: _viewModel.mode.isReading &&
          _viewModel.hasGoal &&
          _viewModel.goal.canEdit(appData.currentUser.remoteId),
      onEdit: () => _viewModel.setMode(FormMode.update),
      showCancel: _viewModel.mode.isUpdating,
      onCancel: () => _viewModel.setMode(FormMode.read),
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDimens.smPadding,
        ),
        child: IfElseWidget(
          condition: _viewModel.type == null && !_viewModel.loading,
          ifWidget: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.xlPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppButton(
                  text: localization.labels.reward,
                  onPressed: () => _viewModel.setType(GoalType.classic),
                ),
                SizedBox(
                  height: AppDimens.smPadding,
                ),
                AppButton(
                  text: localization.labels.rewardPro,
                  onPressed: () => _viewModel.setType(GoalType.pro),
                ),
              ],
            ),
          ),
          elseWidget: _YulliAddGoalBottomSheetForm(
            formKey: _formKey,
          ),
        ),
      ),
    );
  }
}

class _YulliAddGoalBottomSheetForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  _YulliAddGoalBottomSheetForm({
    Key key,
    @required this.formKey,
  }) : super(key: key);

  @override
  __YulliAddGoalBottomSheetFormState createState() =>
      __YulliAddGoalBottomSheetFormState();
}

class __YulliAddGoalBottomSheetFormState
    extends State<_YulliAddGoalBottomSheetForm>
    with SingleTickerProviderStateMixin {
  AddGoalViewModel _viewModel;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final pointsList = ['10', '20', '30', '40', '50'];
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  StreamSubscription _exceptionSubscription;

  void _onRestore() {
    final appData = Provider.of<AppDataService>(context, listen: false);
    final localization = AppLocalization.of(context);
    if (_viewModel.isHiddenCauseMistery(appData.currentUser) &&
        !_viewModel.hasBeenClaimedByCurrentUser) {
      print('gtgtg');
      _nameController.text = localization.labels.mysteryGift;
      _descriptionController.text = localization.labels.mysteryGift;
    } else {
      print('hgrjgngjnrjg');
      print(_viewModel.name);
      print(_viewModel.description);
      _nameController.text = _viewModel.name ?? "";
      _descriptionController.text = _viewModel.description ?? "";
    }

    FocusNodeUtils.unfocusAll();
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _nameController.addListener(() {
        if (!_viewModel.mode.isReading) {
          print('hhhh');
          _viewModel.setName(_nameController.text.trim());
        }
      });
      _descriptionController.addListener(() {
        if (!_viewModel.mode.isReading) {
          _viewModel.setDescription(_descriptionController.text.trim());
        }
      });
      if (_viewModel.hasGoal) {
        _onRestore();
      }
    });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<AddGoalViewModel>(context)
      ..onRestore.addListener(this._onRestore)
      ..claimed.addListener(() {
        print('claimed ${_viewModel.claimed.value}');
        this._onRestore();
      });

    _exceptionSubscription ??=
        _viewModel.unexpectedExceptionStream.listen((event) {
      Fluttertoast.showToast(
        msg: event.message,
        backgroundColor: AppColors.errorColor,
        toastLength: Toast.LENGTH_LONG,
      );
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _exceptionSubscription.cancel();
    _nameFocus.dispose();
    _descriptionFocus.dispose();
    _viewModel.onRestore.removeListener(this._onRestore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BottomBorderdInput(
            type: TextInputType.text,
            hintText: localization.labels.goalName,
            controller: _nameController,
            focus: _nameFocus,
            readOnly: _viewModel.mode.isReading,
          ),
          BottomBorderdInput(
            type: TextInputType.text,
            hintText: localization.labels.description,
            isTextarea: true,
            controller: _descriptionController,
            focus: _descriptionFocus,
            readOnly: _viewModel.mode.isReading,
            // canAddMedia: !_viewModel.mode.isReading,
            onCameraButtonTap: () async {
              final AssetEntity entity =
                  await FileUtils().takePhotoOrVideo(context);

              if (entity == null) return;

              final file = await entity.file;

              _viewModel.addFile(
                file,
                isVideo: entity.type == AssetType.video,
              );
            },
            onGalleryButtonTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[100],
                barrierColor: Colors.black54,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(AppDimens.padding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OpacityButton(
                          onTap: () async {
                            Navigator.of(context).pop();
                            final image = await FileUtils().pickImage();

                            if (image == null) {
                              return;
                            }

                            _viewModel.addFile(
                              image,
                              isVideo: false,
                            );
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(
                              bottom: AppDimens.smPadding,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppDimens.smPadding,
                              ),
                            ),
                            child: Text(
                              localization.labels.selectPhoto,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        OpacityButton(
                          onTap: () async {
                            Navigator.of(context).pop();
                            final video = await FileUtils().pickVideo();

                            if (video == null) {
                              return;
                            }

                            _viewModel.addFile(
                              video,
                              isVideo: true,
                            );
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(
                              bottom: AppDimens.smPadding,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppDimens.smPadding,
                              ),
                            ),
                            child: Text(
                              localization.labels.selectVideo,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          if (!_viewModel.mode.isReading || _viewModel.files.isNotEmpty)
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.2,
                    color: AppColors.grey,
                  ),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: AppDimens.smPadding,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: !_viewModel.mode.isReading
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  FeatherIcons.camera,
                                  color: const Color(0xFF797979),
                                ),
                                onPressed: () async {
                                  final AssetEntity entity = await FileUtils()
                                      .takePhotoOrVideo(context);

                                  if (entity == null) return;

                                  final file = await entity.file;

                                  _viewModel.addFile(
                                    file,
                                    isVideo: entity.type == AssetType.video,
                                  );
                                },
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  FeatherIcons.image,
                                  color: const Color(0xFF797979),
                                ),
                                onPressed: () async {
                                  showCupertinoModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.grey[100],
                                    barrierColor: Colors.black54,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(
                                            AppDimens.padding),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            OpacityButton(
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                final image = await FileUtils()
                                                    .pickImage();

                                                _viewModel.addFile(
                                                  image,
                                                  isVideo: false,
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                margin: const EdgeInsets.only(
                                                  bottom: AppDimens.smPadding,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    AppDimens.smPadding,
                                                  ),
                                                ),
                                                child: Text(
                                                  localization
                                                      .labels.selectPhoto,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            OpacityButton(
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                final video = await FileUtils()
                                                    .pickVideo();

                                                _viewModel.addFile(
                                                  video,
                                                  isVideo: true,
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                margin: const EdgeInsets.only(
                                                  bottom: AppDimens.smPadding,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    AppDimens.smPadding,
                                                  ),
                                                ),
                                                child: Text(
                                                  localization
                                                      .labels.selectVideo,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  if (_viewModel.files.isNotEmpty &&
                      !_viewModel.isHiddenCauseMistery(appData.currentUser))
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.padding,
                          vertical: AppDimens.smPadding,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final file = _viewModel.files[index];

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (file.fileType == FileType.video) {
                                        return OpacityButton(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => PreviewScreen(
                                                  fileUrl: file.downloadUrl,
                                                  isVideo: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(
                                                AppDimens.smPadding),
                                            alignment: Alignment.center,
                                            width: constraints.maxHeight -
                                                AppDimens.smPadding * 2,
                                            height: constraints.maxHeight -
                                                AppDimens.smPadding * 2,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimens.smPadding),
                                            ),
                                            child: const Material(
                                              type: MaterialType.circle,
                                              color: Colors.white,
                                              elevation: 2,
                                              shadowColor: Colors.black38,
                                              child: SizedBox(
                                                height: 32,
                                                width: 32,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.play_arrow,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return MyNetworkImage(
                                        url: file.downloadUrl,
                                        width: constraints.maxHeight -
                                            AppDimens.smPadding * 2,
                                        height: constraints.maxHeight -
                                            AppDimens.smPadding * 2,
                                        borderRadius: AppDimens.smPadding,
                                        margin: const EdgeInsets.all(
                                            AppDimens.smPadding),
                                      );
                                    },
                                  ),
                                  // Container(
                                  //   width: constraints.maxHeight -
                                  //       AppDimens.smPadding * 2,
                                  //   height: constraints.maxHeight -
                                  //       AppDimens.smPadding * 2,
                                  //   margin: const EdgeInsets.all(AppDimens.smPadding),
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.grey,
                                  //     borderRadius:
                                  //         BorderRadius.circular(AppDimens.smPadding),
                                  //   ),
                                  // ),
                                  if (!_viewModel.mode.isReading)
                                    OpacityButton(
                                      onTap: () {
                                        _viewModel.removeFile(file);
                                      },
                                      child: const Material(
                                        type: MaterialType.circle,
                                        color: Colors.red,
                                        elevation: 2,
                                        child: SizedBox(
                                          height: AppDimens.smPadding * 2,
                                          width: AppDimens.smPadding * 2,
                                          child: Center(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                        itemCount: _viewModel.files.length,
                      ),
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.lgPadding,
              vertical: AppDimens.lgPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SmallText(localization.labels.members),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      ),
                      MyMembersSelector(
                        disabled: _viewModel.mode.isReading,
                        initialMembers: _viewModel.member != null
                            ? [_viewModel.member]
                            : [],
                        onMemberSelected: (user, type) {
                          _viewModel
                            ..setMember(user, notify: false)
                            ..setIsAssigned(MembersDialogType.assigned == type);
                        },
                      ),
                    ],
                  ),
                ),
                if (_viewModel.type.isClassic)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SmallText(localization.labels.requiredPoints),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        MyDropDown(
                          disabled: _viewModel.mode.isReading,
                          items: pointsList,
                          onChanged: (points) {
                            _viewModel.setPoints(points);
                          },
                          currentValue: _viewModel.points.toString(),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (_viewModel.type.isPro)
            Padding(
              padding: const EdgeInsets.symmetric(
                  // horizontal: AppDimens.lgPadding,
                  // vertical: AppDimens.lgPadding,
                  ),
              child: MyTasksSelector(
                disabled: _viewModel.mode.isReading,
                title: localization.labels.relatedDeals,
                tasks: _viewModel.tasks,
                onSelected: (task) {
                  _viewModel.addTask(task);
                },
                onDeleted: (task, index) {
                  if (!_viewModel.mode.isReading)
                    _viewModel.removeTaskByIndex(index);
                },
                user: _viewModel.member,
                isAssigned: _viewModel.isAssigned,
                canOpenSelector: () {
                  if (_viewModel.member == null) {
                    Fluttertoast.showToast(
                      msg: localization.notices.cannotSelectTaskBeforeMember,
                      backgroundColor: AppColors.warningColor,
                      toastLength: Toast.LENGTH_LONG,
                    );
                    return false;
                  }
                  return true;
                },
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppDimens.xxlPadding,
                    left: AppDimens.lgPadding,
                  ),
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
                        _viewModel.type.isClassic
                            ? localization.notices.mysteryGiftNoticeAtCreation
                            : localization
                                .notices.mysteryProGiftNoticeAtCreation,
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
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppDimens.xlPadding,
                    left: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Switch(
                        value: _viewModel.isMistery,
                        onChanged: (value) {
                          if (_viewModel.mode.isReading) return;
                          _viewModel.setMistery(value);
                        },
                        activeTrackColor: AppColors.primary,
                        activeColor: AppColors.secondary,
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
          IfElseWidget(
            condition: _viewModel.mode.isCreating,
            ifWidget: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.mdPadding,
              ),
              child: AppButton(
                onPressed: () async {
                  final result = await _viewModel.validate();

                  if (result) {
                    Fluttertoast.showToast(
                      msg: localization.notices.goalCreated,
                      textColor: Colors.white,
                      backgroundColor: AppColors.success,
                      toastLength: Toast.LENGTH_LONG,
                    );

                    Future.delayed(Duration(milliseconds: 800), () {
                      Navigator.of(context).pop();
                    });
                  }
                },
                loading: _viewModel.submitting,
                disabled: !_viewModel.isValid,
                text: localization.actions.addGoal,
              ),
            ),
            elseIfCondition: _viewModel.mode.isReading,
            elseIfWidget: IfElseWidget(
              condition: !_viewModel.isCurrentUserAuthor(appData.currentUser),
              ifWidget: IfElseWidget(
                condition: _viewModel.canClaim(appData.currentUser),
                ifWidget: AppButton(
                  text: localization.actions.claimReward,
                  loading: _viewModel.submitting,
                  onPressed: () async {
                    try {
                      await _viewModel.claim();

                      Fluttertoast.showToast(
                        msg: localization.notices.claimSent,
                        textColor: Colors.white,
                        backgroundColor: AppColors.success,
                        toastLength: Toast.LENGTH_LONG,
                      );

                      Future.delayed(Duration(milliseconds: 800), () {
                        Navigator.of(context).pop();
                      });
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: localization.errors.exceptions.unexpected,
                        textColor: Colors.white,
                        backgroundColor: AppColors.errorColor,
                        toastLength: Toast.LENGTH_LONG,
                      );
                    }
                  },
                ),
                elseIfCondition:
                    (_viewModel.goal?.goalType?.isClassic ?? false) &&
                        !_viewModel.hasEnoughPoints(appData.currentUser),
                elseIfWidget: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(
                    top: AppDimens.padding,
                    bottom: AppDimens.lgPadding,
                    left: AppDimens.padding,
                    right: AppDimens.padding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.grey,
                  ),
                  child: Text(
                    localization.notices.notEnoughPoints,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                elseWidget: IfElseWidget(
                  // condition: _viewModel.hasBeenClaimedByCurrentUser &&
                  //     (_viewModel.goal?.goalType?.isPro ?? false),
                  condition: _viewModel.hasBeenClaimedByCurrentUser,
                  ifWidget: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(
                      top: AppDimens.padding,
                      bottom: AppDimens.lgPadding,
                      left: AppDimens.padding,
                      right: AppDimens.padding,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.grey,
                    ),
                    child: Text(
                      localization.notices.alreadyClaimed,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            elseWidget: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.mdPadding,
              ),
              child: AppButton(
                onPressed: () async {
                  final result = await _viewModel.validate(editing: true);

                  if (result) {
                    Fluttertoast.showToast(
                      msg: localization.notices.editDone,
                      textColor: Colors.white,
                      backgroundColor: AppColors.success,
                      toastLength: Toast.LENGTH_LONG,
                    );

                    Future.delayed(Duration(milliseconds: 800), () {
                      Navigator.of(context).pop();
                    });
                  }
                },
                loading: _viewModel.submitting,
                disabled: !_viewModel.isValid,
                text: localization.actions.editReward,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
