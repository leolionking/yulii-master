import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/yulli_themes.dart';

class MyDropDown extends StatefulWidget {
  final List<String> items;
  static String dropdownValue;
  final int currentItemIndex;
  final String currentValue;
  final ValueChanged<int> onChanged;
  final bool disabled;

  MyDropDown({
    Key key,
    @required this.items,
    @required this.onChanged,
    this.currentItemIndex = 0,
    this.disabled = false,
    this.currentValue,
  })  : assert(items != null),
        assert(currentItemIndex != null),
        assert(currentItemIndex < items.length),
        assert(currentItemIndex >= 0),
        assert(disabled != null),
        super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropDown> {
  String _currentValue;

  @override
  void initState() {
    super.initState();

    if (widget.currentValue != null &&
        widget.items.indexOf(widget.currentValue) != -1) {
      _currentValue = widget.currentValue;
    } else {
      _currentValue = widget.items.isNotEmpty ? widget.items.first : null;
    }
  }

  @override
  void didUpdateWidget(MyDropDown oldWidget) {
    if (widget.currentValue != oldWidget.currentValue ||
        widget.items != oldWidget.items) {
      if (widget.currentValue != null &&
          widget.items.indexOf(widget.currentValue) != -1) {
        _currentValue = widget.currentValue;
      } else {
        _currentValue = widget.items.isNotEmpty ? widget.items.first : null;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkGrey,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$_currentValue"),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.darkGrey,
            )
          ],
        ),
      ),
      onTap: () {
        if (widget.disabled) return;
        FocusNodeUtils.unfocusAll();
        showButtonSheet();
      },
    );
  }

  showButtonSheet() {
    final localization = AppLocalization.of(context);

    List actions = new List.generate(
      widget.items.length,
      (i) => new CupertinoActionSheetAction(
        child: Text(
          "${widget.items[i]} pts",
          style: TextStyle(color: YulliColors.blue[500]),
        ),
        onPressed: () {
          setState(() {
            MyDropDown.dropdownValue = widget.items[i];
          });
          Navigator.of(context, rootNavigator: true).pop("Discard");
          widget.onChanged?.call(int.parse(widget.items[i]));
        },
      ),
    ).toList();

    final act = CupertinoActionSheet(
        title: Text(
          localization.labels.requiredPointsCount,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        //message: Text('Choisir une option'),
        actions: actions,
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            localization.labels.cancel,
            style: TextStyle(color: Colors.orange),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ));
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => act,
    );
  }
}
