import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/add_friend_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/yulii_page_bottom_sheet.dart';
import 'package:yulli/extensions/index.dart';

class YuliiAddFriendBottomSheet extends StatelessWidget {
  const YuliiAddFriendBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddFriendViewModel(AppLocalization.of(context))
        ..setDependencies(
          dbService: Provider.of<DbService>(context, listen: false),
        ),
      child: _YuliiAddFriendBottomSheet(),
    );
  }
}

class _YuliiAddFriendBottomSheet extends StatefulWidget {
  const _YuliiAddFriendBottomSheet({Key key}) : super(key: key);

  @override
  _YuliiAddFriendBottomSheetState createState() =>
      _YuliiAddFriendBottomSheetState();
}

class _YuliiAddFriendBottomSheetState
    extends State<_YuliiAddFriendBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  AddFriendViewModel _viewModel;
  StreamSubscription _unexpectedExceptionSubscription;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        _viewModel?.setEmail(_controller.text.trim());
      });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<AddFriendViewModel>(context)
      ..init(_formKey)
      ..validateAllInputs(notify: false);

    _unexpectedExceptionSubscription ??=
        _viewModel.unexpectedExceptionStream.listen((event) {
      Fluttertoast.showToast(
        msg: event.message,
        backgroundColor: AppColors.errorColor,
      );
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _unexpectedExceptionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return YulliPageBottomSheet(
      title: localization.actions.addFriend,
      loading: _viewModel.submitting,
      onClose: () => context.pop(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDimens.lgPadding,
          left: AppDimens.xlPadding,
          right: AppDimens.xlPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              autovalidate: _viewModel.autoValidate,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  // border: baseBorder,
                  // enabledBorder: baseBorder,
                  hintText: localization.labels.enterFriendEmail,
                  // errorText: _error,
                ),
                validator: (_) => _viewModel.emailError,
              ),
            ),
            SizedBox(
              height: AppDimens.padding,
            ),
            AppButton(
              onPressed: () async {
                final result = await _viewModel.validate();

                if (result) {
                  Fluttertoast.showToast(
                    msg: localization.notices.invitationSent,
                    textColor: Colors.white,
                    backgroundColor: AppColors.success,
                    toastLength: Toast.LENGTH_LONG,
                  );

                  Future.delayed(Duration(milliseconds: 1200), () {
                    Navigator.of(context).pop();
                  });
                }
              },
              loading: _viewModel.submitting,
              text: localization.actions.sendInvitation,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
