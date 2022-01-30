class ListUtils {
  static List<T> distinct<T, R>(List<T> myList, R Function(T) iteratee) {
    Set set = Set();

    return myList.where((element) {
      R _id = iteratee(element);
      bool isNew = !set.contains(_id);
      set.add(_id);
      return isNew;
    }).toList();
  }
}
