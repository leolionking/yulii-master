import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/screens/chat/widgets/chat_list_item.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/loading_indicator.dart';
import 'package:yulli/widgets/no_data.dart';
import 'package:yulli/widgets/searcg_input.dart';

class ChatUserSelectionScreen extends StatefulWidget {
  const ChatUserSelectionScreen({Key key}) : super(key: key);

  @override
  _ChatUserSelectionScreenState createState() =>
      _ChatUserSelectionScreenState();
}

class _ChatUserSelectionScreenState extends State<ChatUserSelectionScreen> {
  bool _loading = true;
  List<User> _friends = [];
  String _searchText;

  List<User> get searchedFriends =>
      _searchText != null && _searchText.isNotEmpty
          ? _friends
              .where((element) => element.displayName
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()))
              .toList()
          : _friends;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final friends =
          await Provider.of<DbService>(context, listen: false).getFriends();

      setState(() {
        _loading = false;
        _friends = friends;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
                  backgroundColor: Colors.white,
                  title: Text(
                    localization.labels.selectAFriend,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  pinned: true,
                  floating: true,
                  // elevation: 0,
                  shadowColor: Colors.black38,
                  bottom: PreferredSize(
                    child: SearchInputWidget(
                      onSearch: (String value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      hintText: localization.actions.searchFriend,
                      enabled: !_loading,
                      backgroundColor: AppColors.primary,
                      iconColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.mdPadding,
                        vertical: AppDimens.smPadding,
                      ),
                      hintColor: Colors.white.withOpacity(.7),
                      textColor: Colors.white,
                    ),
                    preferredSize:
                        Size.fromHeight(35 + AppDimens.smPadding * 2),
                  ),
                  // forceElevated: true,
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: AppDimens.padding),
                ),
                if (_loading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: LoadingIndicator(),
                  ),
                if (!_loading && _friends.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: NoData(),
                  ),
                if (!_loading && _friends.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final friend = searchedFriends[index];

                        return ChatListItem(
                          onTap: () {
                            Navigator.of(context).pop(friend);
                          },
                          title: friend.displayName,
                          avatarUrl: friend.avatarUrl,
                          avatarRightPadding: AppDimens.mdPadding,
                          key: ValueKey(friend.remoteId),
                        );
                      },
                      childCount: searchedFriends.length,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
