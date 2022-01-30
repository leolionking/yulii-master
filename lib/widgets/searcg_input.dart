import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/utils/functions_utils.dart';

class SearchInputWidget extends StatefulWidget {
  final String hintText;
  final bool bordered;
  final ValueChanged<String> onSearch;
  final Color backgroundColor;
  final Color iconColor;
  final EdgeInsets padding;
  final Color textColor;
  final Color hintColor;
  final bool enabled;

  const SearchInputWidget({
    @required this.onSearch,
    this.hintText,
    this.bordered = false,
    Key key,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.textColor,
    this.hintColor,
    this.enabled,
  }) : super(key: key);

  @override
  _SearchInputWidgetState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  TextEditingController _controller;
  final Debouncer _debouncer = Debouncer(250);
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        _debouncer.run(() {
          widget.onSearch?.call(_controller.text);
        });
        if (_isEmpty && _controller.text.isNotEmpty) {
          setState(() {
            _isEmpty = false;
          });
        } else if (!_isEmpty && _controller.text.isEmpty) {
          setState(() {
            _isEmpty = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.bordered ? AppColors.darkGrey : Colors.white,
          width: 1.0,
        ),
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: AppDimens.padding,
            ),
            child: Icon(
              Icons.search,
              color: widget.iconColor ?? AppColors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(
                height: 1.0,
                color: widget.textColor ?? AppColors.defaultTextColor,
              ),
              enabled: widget.enabled,
              cursorColor: AppColors.darkGrey,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: widget.hintColor ?? AppColors.grey,
                ),
              ),
            ),
          ),
          if (!_isEmpty)
            IconButton(
              icon: Icon(
                Icons.close,
                color: widget.iconColor ?? AppColors.grey,
              ),
              onPressed: () {
                _controller.clear();
              },
            ),
        ],
      ),
    );
  }
}
