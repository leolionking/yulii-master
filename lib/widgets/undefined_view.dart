import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String path;

  const UndefinedView({
    Key key,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings);
    return Container(
      child: Center(
        child: Text('Undefined Route : $path'),
      ),
    );
  }
}
