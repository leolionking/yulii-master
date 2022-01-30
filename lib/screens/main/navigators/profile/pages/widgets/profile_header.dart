import 'package:badges/badges.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/chat_viewmodel.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/avatar.dart';
import 'package:yulli/widgets/clickable_text.dart';
import 'package:yulli/widgets/my_avatar.dart';
import 'package:yulli/widgets/inked_button.dart';
import 'package:yulli/widgets/opacity_button.dart';

import 'image_picker_bottom_sheet.dart';

class ProfileHeader extends StatelessWidget {
  final List<Task> finishedTasks;

  const ProfileHeader({
    Key key,
    @required this.finishedTasks,
  }) : super(key: key);

  void _onAvatarTap(BuildContext context) {
    final appData = Provider.of<AppDataService>(context, listen: false);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => ImagePickerBottomSheet(
        onActionTap: (ImagePickerAction action) async {
          switch (action) {
            // case ImagePickerAction.camera:
            //   appData.pickImage(ImageSource.camera);
            //   break;
            case ImagePickerAction.gallery:
              appData.pickImage(ImageSource.gallery);
              break;
            case ImagePickerAction.delete:
              appData.deleteAvatar();
              break;
          }
        },
        hideDelete: !appData.currentUser.hasAvatar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataService>(context, listen: false);
    final localization = AppLocalization.of(context);

    return SliverAppBar(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      expandedHeight: 250,
      floating: false,
      pinned: true,
      primary: true,
      bottom: PreferredSize(
        child: const SizedBox(),
        preferredSize: Size.fromHeight(112),
      ),
      flexibleSpace: Stack(
        children: <Widget>[
          FlexibleSpaceBar(
            centerTitle: true,
            background: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      YulliColors.blue[500].withOpacity(0.6),
                      BlendMode.dstIn,
                    ),
                    child: Image.asset(
                      "assets/images/profile_back.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset("assets/images/trophy.png"),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Selector<AppDataService, int>(
                                  builder: (context, _points, __) {
                                    return Text(
                                      _points.toString(),
                                      style: TextStyle(
                                        color: AppColors.secondary,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                  selector: (context, _viewModel) =>
                                      _viewModel.lastCredits?.current ?? 0,
                                ),
                                Text(
                                  localization.labels.pointsPlaceholder(
                                    points: "",
                                  ),
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.sort, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  finishedTasks.length.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  localization.notice.dealsCompleted,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: 40.0,
                left: AppDimens.padding,
                right: AppDimens.padding,
                bottom: 0,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width:
                        MediaQuery.of(context).size.width - AppDimens.lgPadding,
                    // margin: EdgeInsets.only(
                    //   top: AppDimens.padding,
                    // ),
                    height: 100,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: AppDimens.padding,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: OpacityButton(
                              onTap: () => this._onAvatarTap(context),
                              child: Consumer<AppDataService>(
                                builder: (context, _appDataService, __) {
                                  return Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: MyAvatar(
                                          key: ValueKey(_appDataService
                                              .currentUser.avatarUrl),
                                          avatarUrl: _appDataService
                                              .currentUser.avatarUrl,
                                          user: _appDataService.currentUser,
                                          size: 84,
                                          borderWidth: 2,
                                          borderColor: Colors.white,
                                          loading:
                                              _appDataService.avatarUploading,
                                          isSquared: true,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.secondary,
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () => AppRouter().goToSettings(),
                            icon: Icon(
                              FeatherIcons.settings,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () => AppRouter().goToChatList(),
                            icon: Selector<ChatViewModel, int>(
                              selector: (context, viewModel) =>
                                  viewModel.unreadMessagesCount,
                              builder: (context, unreadMessagesCount, child) {
                                final count = unreadMessagesCount < 99
                                    ? "$unreadMessagesCount"
                                    : "+99";
                                return Badge(
                                  showBadge: unreadMessagesCount > 0,
                                  badgeContent: Text(
                                    count,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                  ),
                                  child: child,
                                );
                              },
                              child: const Icon(
                                Icons.chat,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppDimens.padding,
                  ),
                  Text(
                    appData.currentUser.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ClickableTextWidget(
                  //   "Modifier",
                  //   TextStyle(color: YulliColors.yellow[500], fontSize: 18),
                  //   () {},
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
