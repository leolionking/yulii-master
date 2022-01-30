import 'dart:math' as Math;

import 'package:flutter/material.dart';

class MySliverHeader extends StatelessWidget {
  final bool pinned;
  final bool floating;
  final double minHeight;
  final double maxHeight;
  final Widget child;

  const MySliverHeader({
    Key key,
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    this.pinned = true,
    this.floating = false,
  })  : assert(pinned != null),
        assert(floating != null),
        assert(minHeight != null),
        assert(maxHeight != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _MySliverHeaderDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: child,
      ),
      pinned: pinned,
      floating: floating,
    );
  }
}

class _MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _MySliverHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => Math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_MySliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
