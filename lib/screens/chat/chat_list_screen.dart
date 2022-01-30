import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/chat_message.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/chat/chat_messages_screen.dart';
import 'package:yulli/screens/chat/viewmodels/chat_list_screen_viewmodel.dart';
import 'package:yulli/screens/chat/viewmodels/chat_messages_viewmodel.dart';
import 'package:yulli/screens/chat/widgets/chat_list_item.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/extensions/index.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatListScreenViewModel>(
      create: (context) => ChatListScreenViewModel(
        dbService: Provider.of<DbService>(context, listen: false),
      ),
      child: _ChatListScreenBody(),
    );
  }
}

class _ChatListScreenBody extends StatefulWidget {
  _ChatListScreenBody({Key key}) : super(key: key);

  @override
  __ChatListScreenBodyState createState() => __ChatListScreenBodyState();
}

class __ChatListScreenBodyState extends State<_ChatListScreenBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatListScreenViewModel>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final currentUser =
        Provider.of<AppDataService>(context, listen: false).currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final user = await AppRouter().goToChatUserSelection();

          if (user != null && user is User) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider<ChatMessagesViewModel>(
                  create: (context) => ChatMessagesViewModel(
                    dbService: Provider.of<DbService>(context, listen: false),
                    participant: user,
                  ),
                  child: ChatMessagesScreen(participant: user),
                ),
              ),
            );
          }
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                AssetImages.treePot,
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    localization.labels.myMessages,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  pinned: true,
                  primary: true,
                  elevation: 0,
                  shadowColor: Colors.black38,
                  // forceElevated: true,
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(
                    top: AppDimens.padding,
                  ),
                ),
                Consumer<ChatListScreenViewModel>(
                    builder: (context, _viewModel, child) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final chat = _viewModel.chats[index];

                        final participant = chat.participants.firstWhere(
                          (element) => element.remoteId != currentUser.remoteId,
                          orElse: () => null,
                        );

                        final lastMessage = chat.lastMessage;

                        return ChatListItem(
                          title: participant?.displayName ?? "",
                          avatarUrl: participant?.avatarUrl,
                          subtitleWidget: Builder(
                            builder: (context) {
                              if (lastMessage != null) {
                                switch (lastMessage.type) {
                                  case ChatMessageType.text:
                                    return Text(
                                      lastMessage.content,
                                      style: context
                                          .textStyles.chatListItemExtract,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  case ChatMessageType.image:
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.image,
                                          size: 14,
                                          color: AppColors.dividerColorOpaque,
                                        ),
                                        const SizedBox(
                                          width: AppDimens.smPadding,
                                        ),
                                        Text(
                                          'Image',
                                          style: context
                                              .textStyles.chatListItemExtract,
                                        )
                                      ],
                                    );
                                  case ChatMessageType.video:
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.videocam,
                                          size: 14,
                                          color: AppColors.dividerColorOpaque,
                                        ),
                                        const SizedBox(
                                          width: AppDimens.smPadding,
                                        ),
                                        Text(
                                          'Image',
                                          style: context
                                              .textStyles.chatListItemExtract,
                                        )
                                      ],
                                    );
                                  case ChatMessageType.deleted:
                                    return Text(
                                      "Message supprimé",
                                      style: context
                                          .textStyles.chatListItemExtract
                                          .copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                }
                              }

                              return SizedBox();
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider<
                                    ChatMessagesViewModel>(
                                  create: (context) => ChatMessagesViewModel(
                                    dbService: Provider.of<DbService>(context,
                                        listen: false),
                                    participant: participant,
                                  ),
                                  child: ChatMessagesScreen(
                                    participant: participant,
                                  ),
                                ),
                              ),
                            );
                          },
                          hasBorder: true,
                          key: ValueKey(chat.remoteId),
                        );
                      },
                      childCount: _viewModel.chats.length,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
