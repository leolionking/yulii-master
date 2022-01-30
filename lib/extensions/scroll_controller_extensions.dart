import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

extension ScrollControllerExtension on ScrollController {
  bool get hasReachBottom =>
      this.offset >= this.position.maxScrollExtent && !this.position.outOfRange;
  bool get hasReachTop =>
      this.offset <= this.position.minScrollExtent && !this.position.outOfRange;
}

extension ScrollDirectionExtension on ScrollDirection {
  bool get isForward => this == ScrollDirection.forward;
  bool get isReverse => this == ScrollDirection.reverse;
  bool get isIdle => this == ScrollDirection.idle;
}
