import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/chat_message.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/screens/chat/viewmodels/chat_messages_viewmodel.dart';
import 'package:yulli/services/file_storage_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/utils/file_utils.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/my_avatar.dart';
import 'package:yulli/widgets/opacity_button.dart';

import 'widgets/chat_message_item.dart';

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({
    Key key,
    @required this.participant,
  })  : assert(participant != null),
        super(key: key);

  final User participant;

  @override
  _ChatMessagesScreenState createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen>
    with SingleTickerProviderStateMixin {
  void _hanfleFile(
      BuildContext context, ChatMessagesViewModel viewModel, File file,
      {bool isVideo = false, bool askBefore = false}) async {
    assert(isVideo != null);
    if (file != null) {
      final localization = AppLocalization.of(context);

      if (askBefore ?? false) {
        final response = await showOkCancelAlertDialog(
          context: context,
          okLabel: localization.labels.confirm,
          cancelLabel: localization.labels.cancel,
          barrierDismissible: false,
          message: localization.labels.confirmMediaUpload,
          title: localization.labels.confirmation,
          defaultType: OkCancelAlertDefaultType.ok,
        );

        if (response == OkCancelResult.cancel) {
          return;
        }
      }

      viewModel.setLoading(true);

      final uploadedFile =
          await Provider.of<FileStorageService>(context, listen: false)
              .upload(file);

      if (uploadedFile == null) {
        viewModel.setLoading(false);
        return;
      }
      final now = DateTime.now();

      final message = ChatMessage(
        type: isVideo ? ChatMessageType.video : ChatMessageType.image,
        createdAt: now,
        file: uploadedFile,
      );

      message.toJson();

      viewModel.addMessage(message);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatMessagesViewModel>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Consumer<ChatMessagesViewModel>(
      builder: (context, _viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              widget.participant.displayName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            shadowColor: Colors.black38,
            elevation: 2,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppDimens.mdPadding),
                child: OpacityButton(
                  onTap: () {},
                  child: UnconstrainedBox(
                    child: MyAvatar(
                      avatarUrl: widget.participant.avatarUrl,
                      size: 40,
                      isSquared: true,
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
            bottom: _viewModel.loading
                ? const PreferredSize(
                    child: LinearProgressIndicator(),
                    preferredSize: Size.fromHeight(4),
                  )
                : null,
          ),
          body: AnimatedSize(
            vsync: this,
            duration: const Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.mdPadding,
                      vertical: AppDimens.padding,
                    ),
                    itemBuilder: (context, index) {
                      final message = _viewModel.messages[index];

                      return ChatMessageItem(
                        message: message,
                        participantId: _viewModel.participant.remoteId,
                        key: ValueKey(message.remoteId),
                      );
                    },
                    itemCount: _viewModel.messages.length,
                  ),
                ),
                if (_viewModel.isFriend != null && !_viewModel.isFriend)
                  Container(
                    margin: EdgeInsets.only(
                      left: AppDimens.mdPadding,
                      right: AppDimens.mdPadding,
                      bottom: MediaQuery.of(context).padding.bottom +
                          AppDimens.padding,
                    ),
                    padding: const EdgeInsets.all(AppDimens.padding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.smPadding),
                      color: AppColors.messageParticipantColor.withOpacity(.7),
                    ),
                    child: Text(
                      "L'envoi de message à cet utilisateur est désactivé car vous n'êtes plus ami.",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (_viewModel.isFriend != null && _viewModel.isFriend)
                  _ChatForm(
                    loading: _viewModel.loading,
                    onCameraTap: () async {
                      // final file = await FileUtils().pickFile();

                      final AssetEntity entity =
                          await FileUtils().takePhotoOrVideo(context);

                      if (entity == null) return;

                      final file = await entity.file;

                      _hanfleFile(
                        context,
                        _viewModel,
                        file,
                        isVideo: entity.type == AssetType.video,
                      );
                    },
                    onSend: (String value) {
                      final now = DateTime.now();

                      final message = ChatMessage(
                        type: ChatMessageType.text,
                        content: value.trim(),
                        createdAt: now,
                      );

                      _viewModel.addMessage(message);
                    },
                    onGalleryTap: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.grey[100],
                        barrierColor: Colors.black54,
                        builder: (_) {
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

                                    _hanfleFile(
                                      context,
                                      _viewModel,
                                      image,
                                      isVideo: false,
                                      askBefore: true,
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
                                    final image = await FileUtils().pickVideo();

                                    _hanfleFile(
                                      context,
                                      _viewModel,
                                      image,
                                      isVideo: true,
                                      askBefore: true,
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChatForm extends StatefulWidget {
  _ChatForm({
    Key key,
    @required this.onCameraTap,
    @required this.onGalleryTap,
    @required this.onSend,
    this.loading,
  }) : super(key: key);

  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final Function(String) onSend;
  final bool loading;

  @override
  __ChatFormState createState() => __ChatFormState();
}

class __ChatFormState extends State<_ChatForm>
    with SingleTickerProviderStateMixin {
  TextEditingController textController;

  bool textIsEmpty = true;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController()
      ..addListener(() {
        if (textController.text.isNotEmpty && textIsEmpty) {
          setState(() {
            textIsEmpty = false;
          });
        } else if (textController.text.isEmpty && !textIsEmpty) {
          setState(() {
            textIsEmpty = true;
          });
        }
      });
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: AppDimens.padding,
        right: AppDimens.padding,
        top: AppDimens.padding,
        bottom: AppDimens.padding + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              vsync: this,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 40,
                ),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.npadding,
                  vertical: 2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.4,
                        ),
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.unspecified,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: localization.hints.typeAMessage,
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 14,
                            height: 1.4,
                          ),
                          hintMaxLines: 1,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: textIsEmpty
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OpacityButton(
                                  enabled: !(widget.loading ?? false),
                                  onTap: widget.onCameraTap,
                                  child: SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: Center(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: AppDimens.smPadding,
                                ),
                                OpacityButton(
                                  enabled: !(widget.loading ?? false),
                                  onTap: widget.onGalleryTap,
                                  child: SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: Center(
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: !textIsEmpty
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: AppDimens.smPadding,
                      ),
                      OpacityButton(
                        enabled: !(widget.loading ?? false),
                        onTap: () {
                          final text = textController.text;
                          textController.clear();
                          widget.onSend?.call(text);
                          setState(() {});
                        },
                        child: Material(
                          type: MaterialType.circle,
                          color: AppColors.primary,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
