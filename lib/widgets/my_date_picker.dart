import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/app_language_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/small_text.dart';
import 'package:yulli/extensions/index.dart';

class MyDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateSelected;
  final bool showFormatedDate;
  final bool disabled;

  const MyDatePicker({
    Key key,
    @required this.initialDate,
    @required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.showFormatedDate = true,
    this.disabled = false,
  })  : assert(showFormatedDate != null),
        assert(disabled != null),
        super(key: key);

  void _showDatePicker(BuildContext context) async {
    final localization = AppLocalization.of(context);
    final now = DateTime.now();
    final max = now.add(Duration(days: 3650));
    final appLanguageVM =
        Provider.of<AppLanguageViewModel>(context, listen: false);
    final currentDate = initialDate ?? now;

    DateTime selectedDate;

    if (context.isIOS) {
      selectedDate = await DatePicker.showDatePicker(
        context,
        minTime: now,
        maxTime: max,
        locale: appLanguageVM.locale.localeType,
        currentTime: currentDate,
      );
    } else {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: now,
        lastDate: max,
        helpText: localization.labels.date,
      );
    }

    if (selectedDate != null) {
      onDateSelected?.call(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => !disabled ? this._showDatePicker(context) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.xsPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                MdiIcons.calendarMonthOutline,
                color: AppColors.myDateTimePickerIconColor,
                size: 28,
              ),
              SizedBox(
                width: AppDimens.smPadding,
              ),
              if (showFormatedDate)
                Text(
                  initialDate.format('dd/MM/yyyy'),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppColors.myDateTimePickerIconColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
