import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/no_data.dart';

import 'friend_widget.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TabBarView(
      children: <Widget>[
        NoData(),
        NoData(),
      ],
    );
  }
}
