import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

enum MyLoggerLevel {
  debug,
  normal,
  severe,
}

extension MyLoggerLevelExtension on MyLoggerLevel {
  int get level {
    switch (this) {
      case MyLoggerLevel.debug:
        return 1;
      case MyLoggerLevel.normal:
        return 2;
      case MyLoggerLevel.severe:
        return 3;
    }
    return 0;
  }

  bool operator >(MyLoggerLevel level) => this.level > level.level;

  bool operator <(MyLoggerLevel level) => this.level < level.level;
}

class MyLogger {
  static final logger = Logger();
  final String tag;
  static List<String> sWhitelist = [];
  static final MyLoggerLevel sLevel =
      kReleaseMode ? MyLoggerLevel.normal : MyLoggerLevel.debug;
  final MyLoggerLevel level;

  MyLogger(
    this.tag, {
    this.level = MyLoggerLevel.debug,
  }) : assert(level != null);

  static void verbose(
      {String tag,
      @required String message,
      Object error,
      StackTrace stackTrace}) {
    if (sWhitelist.isNotEmpty && !sWhitelist.contains(tag)) return;
    logger.v("[$tag] $message", error, stackTrace);
  }

  void v(String message, {Object error}) {
    if (level < sLevel) return;
    verbose(
        message: message,
        tag: tag,
        error: error,
        stackTrace: error == null ? StackTrace.current : null);
  }

  static void debug(
      {String tag,
      @required dynamic message,
      Object error,
      StackTrace stackTrace}) {
    if (sWhitelist.isNotEmpty && !sWhitelist.contains(tag)) return;
    logger.d("[$tag] $message", error, stackTrace);
  }

  void d(dynamic message, {Object error}) {
    if (level < sLevel) return;
    debug(
        message: message,
        tag: tag,
        error: error,
        stackTrace: error == null ? StackTrace.current : null);
  }

  static void info(
      {String tag,
      @required String message,
      Object error,
      StackTrace stackTrace}) {
    if (sWhitelist.isNotEmpty && !sWhitelist.contains(tag)) return;
    logger.i("[$tag] $message", error, stackTrace);
    print("[$tag] $message");
  }

  void i(dynamic message, {Object error}) {
    if (level < sLevel) return;
    info(
      message: message.toString(),
      tag: tag,
      error: error,
      stackTrace: error == null ? StackTrace.current : null,
    );
  }

  static void warning(
      {String tag,
      @required dynamic message,
      Object error,
      StackTrace stackTrace}) {
    if (sWhitelist.isNotEmpty && !sWhitelist.contains(tag)) return;
    logger.w("[$tag] $message", error, stackTrace);
  }

  void w(String message, {Object error}) {
    if (level < sLevel) return;
    warning(
        message: message,
        tag: tag,
        error: error,
        stackTrace: error == null ? StackTrace.current : null);
  }

  static void err(
      {String tag,
      @required String message,
      Object error,
      StackTrace stackTrace}) {
    if (sWhitelist.isNotEmpty && !sWhitelist.contains(tag)) return;
    logger.e("[$tag] $message", error, stackTrace ?? StackTrace.current);
  }

  void e(dynamic message, {@required Object error, StackTrace stackTrace}) {
    if (level < sLevel) return;
    err(
      message: message.toString(),
      tag: tag,
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
}
