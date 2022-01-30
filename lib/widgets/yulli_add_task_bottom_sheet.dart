import 'dart:async';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:yulli/abstracts/form_mode_viewmodel.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/viewmodels/add_task_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/screens/preview/preview_screen.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/file_storage_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/utils/file_utils.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/bottom_border_input.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/loading_indicator.dart';
import 'package:yulli/widgets/my_date_picker.dart';
import 'package:yulli/widgets/my_dropdown.dart';
import 'package:yulli/widgets/my_members_dialog.dart';
import 'package:yulli/widgets/my_network_image.dart';
import 'package:yulli/widgets/small_text.dart';
import 'package:yulli/widgets/status_selector.dart';
import 'package:yulli/widgets/yulii_page_bottom_sheet.dart';
import 'package:yulli/extensions/index.dart';

import 'members_selector.dart';
import 'opacity_button.dart';

class YulliAddTaskBottomSheet extends StatelessWidget {
  final bool isViewing;
  final Task task;

  const YulliAddTaskBottomSheet({
    Key key,
    this.task,
  })  : isViewing = task != null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print('task $task');
    return ChangeNotifierProvider<AddTaskViewModel>(
      create: (_) => AddTaskViewModel(
        AppLocalization.of(context),
        Provider.of<AppDataService>(context, listen: false),
        Provider.of<DbService>(context, listen: false),
        Provider.of<FileStorageService>(context, listen: false),
        formMode: isViewing ? FormMode.read : FormMode.create,
      )..setTask(task),
      child: _YulliAddTaskBottomSheet(),
    );
  }
}

class _YulliAddTaskBottomSheet extends StatefulWidget {
  _YulliAddTaskBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  __YulliAddTaskBottomSheetState createState() =>
      __YulliAddTaskBottomSheetState();
}

class __YulliAddTaskBottomSheetState extends State<_YulliAddTaskBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pointsList = ['10', '20', '30', '40', '50'];
  FocusNode _nameFocus = FocusNode();
  FocusNode _descriptionFocus = FocusNode();
  AddTaskViewModel _viewModel;
  StreamSubscription _unexpectedExceptionSubscription;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  Status _currentStatus = Status.opened;

  void _onRestore() {
    _nameController.text = _viewModel.name;
    _descriptionController.text = _viewModel.description;
    FocusNodeUtils.unfocusAll();
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController()
      ..addListener(() {
        _viewModel.setName(_nameController.text.trim());
      });
    _descriptionController = TextEditingController()
      ..addListener(() {
        _viewModel.setDescription(_descriptionController.text.trim());
      });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (_viewModel.hasTask) {
        await _viewModel.populateTask();

        _onRestore();
      }
    });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<AddTaskViewModel>(context)
      ..init(_formKey)
      ..validateAllInputs(notify: false)
      ..onRestore.addListener(this._onRestore);

    if (_viewModel.hasTask) {
      setState(() {
        _currentStatus = _viewModel.task.status;
      });
    }

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
    _nameController.dispose();
    _descriptionController.dispose();
    _nameFocus.dispose();
    _descriptionFocus.dispose();
    _viewModel.onRestore.removeListener(this._onRestore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return YulliPageBottomSheet(
      title: _viewModel.mode.isCreating
          ? localization.actions.addDeal
          : _viewModel.mode.isUpdating
              ? localization.actions.editTask
              : localization.labels.deal,
      loading: _viewModel.submitting || _viewModel.loading,
      onClose: () => context.pop(),
      hideBottomPadding: true,
      showEditButton: _viewModel.mode.isReading &&
          _viewModel.hasTask &&
          _viewModel.task.isAuthor(appData.currentUser.remoteId) &&
          _viewModel.task.status.isOpened,
      onEdit: () => _viewModel.setMode(FormMode.update),
      showCancel: _viewModel.mode.isUpdating,
      onCancel: () => _viewModel.setMode(FormMode.read),
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDimens.smPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              BottomBorderdInput(
                type: TextInputType.text,
                hintText: localization.labels.dealName,
                controller: _nameController,
                focus: _nameFocus,
                readOnly: _viewModel.mode.isReading,
              ),
              BottomBorderdInput(
                type: TextInputType.text,
                hintText: localization.labels.description,
                isTextarea: true,
                // canAddMedia: !_viewModel.mode.isReading,
                controller: _descriptionController,
                focus: _descriptionFocus,
                readOnly: _viewModel.mode.isReading,
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

                                print(image);

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

                                print(video);

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
              if (((_viewModel.task != null && _viewModel.task.status.isOpened && _viewModel.isAssigned) ||
                      !_viewModel.mode.isReading) ||
                  _viewModel.files.isNotEmpty)
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
                        child: (_viewModel.task != null && _viewModel.task.status.isOpened &&
                                    _viewModel.isAssigned) ||
                                !_viewModel.mode.isReading
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
                                      final AssetEntity entity =
                                          await FileUtils()
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
                                                    final image =
                                                        await FileUtils()
                                                            .pickImage();

                                                    _viewModel.addFile(
                                                      image,
                                                      isVideo: false,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom:
                                                          AppDimens.smPadding,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                OpacityButton(
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    final video =
                                                        await FileUtils()
                                                            .pickVideo();

                                                    _viewModel.addFile(
                                                      video,
                                                      isVideo: true,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom:
                                                          AppDimens.smPadding,
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
                                                      textAlign:
                                                          TextAlign.center,
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
                      if (_viewModel.files.isNotEmpty)
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
                                                    builder: (_) =>
                                                        PreviewScreen(
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
                                                        color:
                                                            AppColors.primary,
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
                                      if (!_viewModel.mode.isReading ||
                                          (_viewModel.isAssigned &&
                                              _viewModel.task.status.isOpened &&
                                              _viewModel.fileIsMine(file)))
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
                            initialType: MembersDialogType.assigned,
                            onMemberSelected: (user, type) {
                              _viewModel
                                ..setMember(user, notify: false)
                                ..setIsAssigned(true);
                            },
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: AppDimens.lgPadding,
                    //       // vertical: AppDimens.lgPadding,
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: <Widget>[
                    //         SmallText(localization.labels.points),
                    //         Padding(
                    //           padding: EdgeInsets.only(top: 10),
                    //         ),
                    //         MyDropDown(
                    //           disabled: _viewModel.mode.isReading,
                    //           items: pointsList,
                    //           onChanged: (points) {
                    //             _viewModel.setPoints(points);
                    //           },
                    //           currentValue: _viewModel.points.toString(),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                            disabled: _viewModel.mode.isReading,
                            initialDate: _viewModel.date,
                            showFormatedDate: _viewModel.date != null,
                            onDateSelected: (selectedDate) {
                              _viewModel.setDate(selectedDate);
                            },
                          ),
                        ],
                      ),
                    ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.lgPadding,
                        vertical: AppDimens.lgPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SmallText(localization.labels.points),
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.lgPadding,
                        vertical: AppDimens.lgPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(localization.labels.status),
                          const SizedBox(
                            height: AppDimens.smPadding,
                          ),
                          StatusSelector(
                            initialStatus: _currentStatus,
                            canSelectStatus: _viewModel.hasTask &&
                                !_viewModel.task.status.isDone &&
                                !_viewModel.task.status.isDeclined,
                            selectableStatuses: [
                              if (_viewModel.task?.isAuthor(
                                      appData.currentUser.remoteId) ??
                                  false) ...[
                                Status.done,
                                Status.declined,
                                Status.pending,
                                Status.opened,
                              ],
                              if (_viewModel.task?.isUserAssigned(
                                      appData.currentUser.remoteId) ??
                                  false) ...[
                                Status.pending,
                                Status.opened,
                              ]
                            ],
                            onStatusSelected: (status) {
                              setState(() {
                                _currentStatus = status;
                              });
                              _viewModel.updateTaskStatus(status);

                              print(_currentStatus);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          msg: localization.notices.dealCreated,
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
                    text: localization.actions.addDeal,
                  ),
                ),
                elseIfCondition: _viewModel.mode.isUpdating,
                elseIfWidget: Padding(
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
                    text: localization.actions.editTask,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
