import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/friends_viewmodel.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/my_members_list_item.dart';

import '../localizations.dart';

enum MembersDialogType {
  assigned,
  suggered,
  both,
}

class MyMembersDialog extends StatefulWidget {
  final MembersDialogType type;
  final Function(User, MembersDialogType) onUserSelected;

  const MyMembersDialog({
    Key key,
    this.type = MembersDialogType.both,
    this.onUserSelected,
  })  : assert(type != null),
        super(key: key);

  @override
  _MyMembersDialogState createState() => _MyMembersDialogState();
}

class _MyMembersDialogState extends State<MyMembersDialog> {
  int _selected = 0;
  TextEditingController _searchInputController;

  void _onSearchTextChanged() {
    final viewModel = Provider.of<FriendsViewModel>(context, listen: false);
    viewModel.search(_searchInputController.text);
  }

  @override
  void initState() {
    super.initState();
    _searchInputController = TextEditingController()
      ..addListener(this._onSearchTextChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var viewModel = Provider.of<FriendsViewModel>(context, listen: false);

      if (viewModel.friends.isEmpty) {
        viewModel.init();
      } else {
        viewModel.refresh();
      }
    });
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: .5,
        style: BorderStyle.none,
      ),
    );
    final localization = AppLocalization.of(context);

    return Dialog(
      backgroundColor: AppColors.primary,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: KeyboardVisibilityBuilder(
        builder: (context, iskeyboardVisible) {
          return FractionallySizedBox(
            heightFactor: iskeyboardVisible ? 4 / 5 : 2 / 5,
            child: Consumer<FriendsViewModel>(
              builder: (_, _viewModel, __) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 38,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          IfElseWidget(
                            condition: widget.type == MembersDialogType.both,
                            ifWidget: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_selected != 0) {
                                        setState(() {
                                          _selected = 0;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: double.maxFinite,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selected == 0
                                            ? Colors.transparent
                                            : AppColors.primaryLight,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        localization.labels.assignTo,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: _selected == 0
                                                  ? Colors.white
                                                  : AppColors.primary,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_selected != 1) {
                                        setState(() {
                                          _selected = 1;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: double.maxFinite,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selected == 1
                                            ? Colors.transparent
                                            : AppColors.primaryLight,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        localization.labels.suggestTo,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: _selected == 1
                                                  ? Colors.white
                                                  : AppColors.primary,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            elseWidget: SizedBox.expand(
                              child: Center(
                                child: Text(
                                  widget.type == MembersDialogType.assigned
                                      ? localization.labels.assignTo
                                      : localization.labels.suggestTo,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 38,
                              height: 38,
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              child: Icon(
                                FeatherIcons.x,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.mdPadding,
                        vertical: AppDimens.padding,
                      ),
                      child: TextField(
                        controller: _searchInputController,
                        cursorColor: Colors.white,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.white,
                            ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: AppDimens.smPadding,
                            horizontal: AppDimens.padding,
                          ),
                          enabledBorder: defaultInputBorder,
                          focusedBorder: defaultInputBorder,
                          border: defaultInputBorder,
                          isDense: true,
                          filled: true,
                          fillColor: const Color(0xFF7DBDF1),
                          hintText: localization.labels.nameOrEmail,
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: IfElseWidget(
                        condition: !_viewModel.initialLoading,
                        ifWidget: ListView.builder(
                          // padding: EdgeInsets.symmetric(
                          //   vertical: AppDimens.padding,
                          // ),
                          itemCount: _viewModel.friends.length,
                          itemBuilder: (context, index) {
                            final currentUser = _viewModel.friends[index];

                            return MyMembersListItem(
                              user: currentUser,
                              onItemTap: (user) {
                                widget.onUserSelected?.call(
                                  user,
                                  _selected == 0
                                      ? MembersDialogType.assigned
                                      : MembersDialogType.suggered,
                                );
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                        elseWidget: const Align(
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
