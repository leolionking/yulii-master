import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/small_text.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime selected;
  final Function(DateTime) onDateSelected;

  DatePickerWidget(
    this.selected, {
    @required this.onDateSelected,
  });

  _DatePickerWidgetState createState() =>
      new _DatePickerWidgetState(this.selected);
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selected;

  _DatePickerWidgetState(this.selected);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SmallText("Date"),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
            ),
            GestureDetector(
              child: Icon(
                Icons.date_range,
                color: YulliColors.grey_dark,
                size: 35,
              ),
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    print('change $date');
                  },
                  onConfirm: (date) {
                    setState(() {
                      this.selected = date;
                    });
                    widget.onDateSelected?.call(date);
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.fr,
                );
              },
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(new DateFormat("dd/MM/yyyy").format(selected)),
        ),
      ],
    );
  }
}
