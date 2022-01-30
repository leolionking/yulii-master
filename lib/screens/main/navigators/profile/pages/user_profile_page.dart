import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/screens/main/navigators/home/routing/home_router.dart';
import 'package:yulli/screens/main/navigators/profile/pages/viewmodels/user_profile_page_viewmodel.dart';
import 'package:yulli/screens/main/navigators/profile/pages/widgets/my_profile_body.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/my_sliver_header.dart';
import 'package:yulli/widgets/no_data.dart';

import 'widgets/profile_body.dart';
import 'widgets/profile_header.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DbService>(context, listen: false);
    final localization = AppLocalization.of(context);

    return ChangeNotifierProvider(
      create: (_) => UserProfilePageViewModel(
        Provider.of<DbService>(context, listen: false),
      ),
      child: FutureBuilder<List<List<dynamic>>>(
        future: Future.wait([
          dbService.getMyAssignedTasks(statuses: [Status.done]),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.isEmpty) {
            return NoData();
          }
          final finishedTaks = snapshot.data.first.cast<Task>();

          return CustomScrollView(
            // physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              ProfileHeader(
                finishedTasks: finishedTaks,
              ),
              MySliverHeader(
                minHeight: 56,
                maxHeight: 56,
                child: Container(
                  height: 56,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorWeight: 3.0,
                    labelStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          height: 1.7,
                        ),
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              height: 1.7,
                            ),
                    tabs: [
                      Tab(
                        text: localization.labels.friends,
                      ),
                      Tab(
                        text: localization.labels.myStats,
                      ),
                    ],
                  ),
                ),
              ),
              MyProfileBody(
                tabController: _tabController,
              ),
            ],
          );
        },
      ),
    );
  }
}
