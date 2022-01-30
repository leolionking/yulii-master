import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/button_widget.dart';

class FilterOptions extends StatefulWidget {
  final ValueChanged<int> onTap;
  final int current;
  var labels = [];

  FilterOptions(
    this.labels, {
    @required this.onTap,
    @required this.current,
  });
  _FilterOptionsState createState() => new _FilterOptionsState(this.labels);
}

class _FilterOptionsState extends State<FilterOptions> {
  var labels = [];
  var _scrollControllerOption;

  _FilterOptionsState(this.labels);

  List<ButtonWidget> options = [];
  var selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.current;
    super.initState();
    _scrollControllerOption = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollControllerOption,
        itemCount: labels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                right: index != labels.length - 1 ? 10 : 40,
                left: index != 0 ? 0 : 30),
            child: //options[index],
                ButtonWidget(
              "${labels[index]}",
              selectedIndex == index ? YulliColors.yellow[500] : Colors.white,
              100,
              () {
                widget.onTap?.call(index);
                setState(() {
                  selectedIndex = index;
                });
                _scrollControllerOption.animateTo(index * 100.0 - 50,
                    duration: new Duration(seconds: 1), curve: Curves.ease);
              },
              isOutline: selectedIndex != index,
            ),
          );
        },
      ),
      constraints: new BoxConstraints.loose(
        new Size(MediaQuery.of(context).size.width, 50),
      ),
    );
  }
}
