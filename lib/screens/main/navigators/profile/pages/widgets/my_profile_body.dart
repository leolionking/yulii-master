import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/my_tasks_by_friend.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/screens/main/navigators/profile/pages/viewmodels/user_profile_page_viewmodel.dart';
import 'package:yulli/screens/main/navigators/profile/pages/widgets/friend_widget.dart';
import 'package:yulli/screens/main/navigators/profile/pages/widgets/my_friend_widget.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/centered_circular_progress.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/no_data.dart';

import 'my_tasks_by_friend_widget.dart';

class MyProfileBody extends StatefulWidget {
  final TabController tabController;

  const MyProfileBody({
    Key key,
    @required this.tabController,
  })  : assert(tabController != null),
        super(key: key);

  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  UserProfilePageViewModel _viewModel;

  void _onTabListener() {}

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(this._onTabListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _viewModel.init();
    });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<UserProfilePageViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(this._onTabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return SliverFillRemaining(//SliverFillRemaining
      child: TabBarView(
        controller: widget.tabController,
        children: [
          SafeArea(
            top: false,
            bottom: false,
            child: IfElseWidget(
              condition: _viewModel.tabOneHasData,
              elseIfCondition: _viewModel.tabOneLoading,
              ifWidget: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.mdPadding,
                  vertical: AppDimens.lgPadding,
                ),
                itemBuilder: (context, index) {
                  User friend = _viewModel.friends[index];

                  return MyFriendWidget(
                    user: friend,
                    onDeleteAction: (user) async {
                      final response = await showOkCancelAlertDialog(
                        context: context,
                        okLabel: localization.labels.confirm,
                        cancelLabel: localization.labels.cancel,
                        barrierDismissible: false,
                        message: localization.labels.confirmFriendDeletion,
                        title: localization.labels.confirmation,
                        defaultType: OkCancelAlertDefaultType.ok,
                      );

                      if (response == OkCancelResult.cancel) {
                        return;
                      }

                      _viewModel.deleteFriend(user);
                    },
                  );
                },
                itemCount: _viewModel.friends.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: AppDimens.nlgPadding,
                  );
                },
              ),
              elseIfWidget: const CenteredCircularProgress(),
              elseWidget: const NoData(),
            ),
          ),
          SafeArea(
            top: false,
            bottom: false,
            child: IfElseWidget(
              condition: _viewModel.tabTwoHasData,
              elseIfCondition: _viewModel.tabTwoLoading,
              ifWidget: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.mdPadding,
                  vertical: AppDimens.lgPadding,
                ),
                itemBuilder: (context, index) {
                  MyTasksByFriend tasksByFriend =
                      _viewModel.myTasksByFriend[index];

                  print(tasksByFriend.friend);

                  return MyTasksByFriendWidget(
                    tasksByFriend: tasksByFriend,
                  );
                },
                itemCount: _viewModel.myTasksByFriend.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: AppDimens.nlgPadding,
                  );
                },
              ),
              elseIfWidget: const CenteredCircularProgress(),
              elseWidget: const NoData(),
            ),
          ),
        ],
      ),
    );
  }
}
