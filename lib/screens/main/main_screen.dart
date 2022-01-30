import 'dart:ui';

// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/ad_manager.dart';
import 'package:yulli/common/viewmodels/chat_viewmodel.dart';
import 'package:yulli/common/viewmodels/main_components_view_model.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_router.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_routes.dart';
import 'package:yulli/screens/main/ui/bottom_navigation.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/goals_service.dart';
import 'package:yulli/services/local_notifications_service.dart';
import 'package:yulli/services/notification_service.dart';
import 'package:yulli/services/tasks_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/dial_bottom_sheet.dart';
import 'package:yulli/widgets/dial_bottom_sheet_tasks.dart';
import 'package:yulli/widgets/fab_dial.dart';
import 'package:yulli/widgets/yulli_add_friend_bottom_sheet.dart';
import 'package:yulli/widgets/yulli_add_goal_bottom_sheet.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/yulli_add_task_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final dbService = Provider.of<DbService>(context, listen: false);
      LocalNotificationsService().init(dbService);
      await Provider.of<NotificationService>(context, listen: false).init();
      await dbService.init();
      await Provider.of<AppDataService>(context, listen: false).init();
      Provider.of<NotificationsViewModel>(context, listen: false).init();
      Provider.of<GoalsService>(context, listen: false).init();
      Provider.of<TasksService>(context, listen: false).init();
      Provider.of<ChatViewModel>(context, listen: false).init();

      LocalNotificationsService().checkIfAppHasBeenOpenedFromNotification();
    });
  }

  void _onBottomNavigationTabPressed(
    BottomNavigationTab tabItem, {
    bool addHistory = true,
  }) async {
    var currentTabItem = await BottomNavigationRouter().observer.currentTabItem;

    if (currentTabItem == tabItem) {
      return;
    }

    Provider.of<MainComponentViewModel>(context, listen: false)
        .setDialVisible(true);

    switch (tabItem) {
      case BottomNavigationTab.home:
        BottomNavigationRouter().goToHome();
        break;
      case BottomNavigationTab.tasks:
        BottomNavigationRouter().goToTasks();
        break;
      case BottomNavigationTab.goals:
        BottomNavigationRouter().goToGoals();
        break;
      case BottomNavigationTab.profile:
        BottomNavigationRouter().goToProfile();
        break;
    }
    setState(() {
      _isFabVisible = tabItem != BottomNavigationTab.profile;
    });
  }

  void onDialItemTap(DialItem dialItem, BuildContext context) {
    print('status bar : ${window.padding.top}');
    switch (dialItem) {
      case DialItem.friend:
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          context: context,
          builder: (_) => YuliiAddFriendBottomSheet(),
        );
        break;
      case DialItem.goal:
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          context: context,
          builder: (_) => YuliiAddGoalBottomSheet(),
        );
        break;
      case DialItem.task:
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          context: context,
          builder: (_) => YulliAddTaskBottomSheet(),
          // builder: (_) => FractionallySizedBox(
          //   heightFactor: 1 -
          //       (AppDimens.of(context).statusBarHeight /
          //           AppDimens.of(context).screenSize.height),
          //   child: DialBottomSheetTasks(),
          // ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: BottomNavigationRouter().navigatorKey,
        onGenerateRoute: BottomNavigationRouter().router.generator,
        initialRoute: BottomNavigationRoutes.home,
        observers: [
          BottomNavigationRouter().observer,
        ],
      ),
      floatingActionButton: Selector<MainComponentViewModel, bool>(
        builder: (context, visible, __) {
          return FabDial(
            visible: visible,
            onItemTap: (dialItem) => this.onDialItemTap(dialItem, context),
          );
        },
        selector: (_, viewModel) => viewModel.fabDialVisible,
      ),
      bottomNavigationBar: YulliBottomNavigation(
        onTabPressed: this._onBottomNavigationTabPressed,
        onSized: (Size size) {
          // AdManager.showBannerAd(size.height);
        },
      ),
    );
  }
}
