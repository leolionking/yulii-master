import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/viewmodels/friends_viewmodel.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/my_avatar.dart';
import 'package:yulli/widgets/my_dotted_button.dart';
import 'package:yulli/widgets/my_members_dialog.dart';

class MyMembersSelector extends StatefulWidget {
  final List<User> initialMembers;
  final MembersDialogType initialType;
  final bool disabled;

  final Function(User, MembersDialogType) onMemberSelected;

  MyMembersSelector({
    Key key,
    @required this.onMemberSelected,
    this.initialType = MembersDialogType.both,
    this.initialMembers = const [],
    this.disabled = false,
  })  : assert(initialMembers != null),
        assert(disabled != null),
        super(key: key);

  @override
  _MembersSelectorState createState() => _MembersSelectorState();
}

class _MembersSelectorState extends State<MyMembersSelector> {
  final MyLogger _logger = MyLogger('_MembersSelectorState');

  void _onDottedButtonTap(BuildContext context) {
    FocusNodeUtils.unfocusAll();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => MyMembersDialog(
        type: widget.initialType,
        onUserSelected: (user, type) {
          widget.onMemberSelected?.call(user, type);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 34,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (!widget.disabled)
            MyDottedButton(
              onTap: () => this._onDottedButtonTap(context),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.xsPadding,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemCount: widget.initialMembers.length,
                itemBuilder: (context, index) {
                  final member = widget.initialMembers[index];

                  return SizedBox(
                    width: 34,
                    height: 34,
                    child: MyAvatar(
                      avatarUrl: null,
                      user: member,
                      borderColor: AppColors.primary,
                      size: 34,
                      borderWidth: 1,
                      isSquared: true,
                      borderRadius: 6,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
