import 'dart:collection';

extension ListExtension on List {
  List<T> distinct<T>() => LinkedHashSet<T>.from(this).toList();
  List<T> doAtEachRangeSize<T>(int rangeSize, List<T> Function(List) action) {
    if (this.isEmpty) {
      return const [];
    }
    var start = 0;
    var end = 10;
    List<T> results = [];

    do {
      if (end > length) {
        end = length;
      }
      final range = getRange(start, end).toList();

      results.addAll(action(range));

      start += 10;
      end += 10;
    } while (start < length);

    return results;
  }

  Future<List<T>> doAtEachRangeSizeAsync<T>(
      int rangeSize, Future<List<T>> Function(List) action) async {
    if (this.isEmpty) {
      return const [];
    }
    var start = 0;
    var end = 10;
    List<T> results = [];

    do {
      if (end > length) {
        end = length;
      }
      final range = getRange(start, end).toList();

      results.addAll(await action(range));

      start += 10;
      end += 10;
    } while (start < length);

    return results;
  }
}
