import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_router.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_routes.dart';
import 'package:yulli/themes/app_colors.dart';

enum BottomNavigationTab {
  home,
  tasks,
  goals,
  profile,
}

class TabHelper {
  static IconData icon(BottomNavigationTab tabItem) {
    switch (tabItem) {
      case BottomNavigationTab.tasks:
        return FeatherIcons.checkCircle;
      case BottomNavigationTab.goals:
        return FeatherIcons.gift;
      case BottomNavigationTab.profile:
        return FeatherIcons.user;
      default:
        return FeatherIcons.home;
    }
  }

  static String text(
      BottomNavigationTab tabItem, AppLocalization_Labels localization) {
    switch (tabItem) {
      case BottomNavigationTab.tasks:
        return localization.screens.deals;
      case BottomNavigationTab.goals:
        return localization.screens.goals;
      case BottomNavigationTab.profile:
        return localization.screens.profile;
      default:
        return localization.screens.home;
    }
  }

  static BottomNavigationTab index(int index) {
    switch (index) {
      case 1:
        return BottomNavigationTab.tasks;
      case 2:
        return BottomNavigationTab.goals;
      case 3:
        return BottomNavigationTab.profile;
      default:
        return BottomNavigationTab.home;
    }
  }

  static int fromIndex(BottomNavigationTab tabItem) {
    switch (tabItem) {
      case BottomNavigationTab.tasks:
        return 1;
      case BottomNavigationTab.goals:
        return 2;
      case BottomNavigationTab.profile:
        return 3;
      default:
        return 0;
    }
  }

  static BottomNavigationTab itemFromRoute(String routeName) {
    switch (routeName) {
      case BottomNavigationRoutes.home:
        return BottomNavigationTab.home;
      case BottomNavigationRoutes.tasks:
        return BottomNavigationTab.tasks;
      case BottomNavigationRoutes.goals:
        return BottomNavigationTab.goals;
      case BottomNavigationRoutes.profile:
        return BottomNavigationTab.profile;
    }
    return null;
  }
}

class YulliBottomNavigation extends StatefulWidget {
  final ValueChanged<BottomNavigationTab> onTabPressed;
  final Function(Size) onSized;

  const YulliBottomNavigation({
    Key key,
    @required this.onTabPressed,
    this.onSized,
  }) : super(key: key);

  @override
  _YulliBottomNavigationState createState() => _YulliBottomNavigationState();
}

class _YulliBottomNavigationState extends State<YulliBottomNavigation> {
  final _key = GlobalKey();
  int _index = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSized?.call(_key.currentContext.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BottomNavigationTab>(
      stream: BottomNavigationRouter().observer.tabItem,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          _index = TabHelper.fromIndex(snapshot.data);
        }
        return BottomNavigationBar(
          key: _key,
          backgroundColor: Colors.white,
          elevation: 12,
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.unselectedTab,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          onTap: (index) {
            widget.onTabPressed(TabHelper.index(index));
          },
          items: [
            ...BottomNavigationTab.values.map(
              (BottomNavigationTab tabItem) => BottomNavigationBarItem(
                icon: Icon(TabHelper.icon(tabItem)),
                title: Text(
                  TabHelper.text(
                    tabItem,
                    AppLocalization.of(context),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
