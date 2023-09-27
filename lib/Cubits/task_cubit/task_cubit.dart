import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Models/task.dart';
// import 'package:intl/intl.dart';
// import 'package:to_do/Models/config.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  List<Task> tasks = List.empty(growable: true);
  String tasksOption = 'all';
  
  void addNewTask(Task task) {
    tasks.add(task);
    emit(TaskUpdated());
  }

  int dateTimeCopmerable(DateTime date1, DateTime date2) {
    if (date1.year > date2.year)
      return 1;
    else if (date1.year < date2.year)
      return -1;
    else if (date1.month > date2.month)
      return 1;
    else if (date1.month < date2.month)
      return -1;
    else if (date1.day > date2.day)
      return 1;
    else if (date1.day < date2.day)
      return -1;
    else
      return 0;
  }

  void changeTaskOption(String? value, BuildContext context) {
    tasksOption = value!;
    emit(TasksOptionChanged());
  }

  void deleteTask(int taskId) {
    tasks.removeAt(tasks.indexWhere((element) => element.id == taskId));
    emit(TaskUpdated());
  }

  void editTask(Task task) {
    int index = tasks.indexWhere((element) => element.id == task.id);
    tasks.removeAt(index);
    tasks.insert(index, task);
    emit(TaskUpdated());
  }
  
}
