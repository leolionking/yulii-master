import 'package:flutter/material.dart';

class CenteredCircularProgress extends StatelessWidget {
  const CenteredCircularProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
