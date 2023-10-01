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
  TextEditingController taskNameController = TextEditingController();
  int counter = 50;
  void addNewTask(Task task) {
    tasks.add(task);
    emit(TaskUpdated());
  }

  void updateTaskStatus(int taskId) {
    Task task = tasks.firstWhere((element) => element.id == taskId);
    task.finish();
    emit(TaskStatusUpdated(taskId: taskId));
  }

  void updateSubtaskStatus({required int taskId, required int subtaskId}) {
    Task task = tasks.firstWhere((element) => element.id == taskId);
    Subtask subtask =
        task.getSubtasks.firstWhere((element) => element.id == subtaskId);
    subtask.finish();
    emit(SubtaskStatusUpdated(taskId: taskId, subtaskId: subtaskId));
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

  void addQuickTask() {
    if (taskNameController.text != '') {
      tasks.add(
        Task(
          name: taskNameController.text,
          id: counter,
          startDateTime: DateTime.now(),
          endDateTime: null,
          subtasks: List.empty(growable: true),
        ),
      );
      taskNameController.text = '';
      counter++;
      emit(TaskUpdated());
    }
  }
}
