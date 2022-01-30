import 'package:flutter/foundation.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'status.dart';

class MyTasksByFriend {
  final User friend;
  final List<Task> tasks;

  MyTasksByFriend({
    @required this.friend,
    @required this.tasks,
  })  : assert(friend != null),
        assert(tasks != null);

  int get totalTasks => tasks.length;
  List<Task> get finishedTasks =>
      tasks.where((task) => task.status.isDone).toList();
  int get finishedTasksCount => finishedTasks.length;
  int get finishedTasksPoints {
    int points = 0;

    finishedTasks.forEach((task) {
      points += task.points;
    });

    return points;
  }

  @override
  String toString() => """
    friend: $friend,
    tasksLength: ${tasks.length}
  """;
}
