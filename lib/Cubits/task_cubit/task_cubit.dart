import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Models/task.dart';
// import 'package:intl/intl.dart';
// import 'package:to_do/Models/config.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  List<Task> tasks = List.empty(growable: true);
  String tasksOption = 'all';
  DateTime? customFilteredDate;
  TextEditingController taskNameController = TextEditingController();
  int counter = 50;

  void getTasks() {}

  List<Task> getFilteredTasks() {
    if (tasksOption == 'today') {
      return tasks
          .where((element) => (element.startDateTime != null) &&
              (DateFormat.yMd().format(element.startDateTime!) == DateFormat.yMd().format(DateTime.now())) ||
              (element.repeat == 'daily' && element.startDateTime!.compareTo(DateTime.now()) == 0) ||
              ((element.repeat == 'weekly' && element.startDateTime!.difference(DateTime.now()).inDays % 7 == 0)) ||
              ((element.repeat == 'monthly' && element.startDateTime!.day == DateTime.now().day)))
          .toList();
    } else if (tasksOption == 'custom' && customFilteredDate != null) {
      return tasks
      .where((element) => (element.startDateTime != null) &&
              (DateFormat.yMd().format(element.startDateTime!) == DateFormat.yMd().format(customFilteredDate!)) ||
              (element.repeat == 'daily') ||
              ((element.repeat == 'weekly' && element.startDateTime!.difference(customFilteredDate!).inDays % 7 == 0)) ||
              ((element.repeat == 'monthly' && element.startDateTime!.day == customFilteredDate!.day)))
          .toList();
    } else if (tasksOption == 'none') {
      return tasks.where((element) => element.startDateTime == null).toList();
    } else
      return tasks;
  }

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

  // void updateRepeatedTask(Task task){
  //   if (task.repeat == 'daily' && DateTime.now().day != task.startDateTime!.day){
  //     task.startDateTime = task.startDateTime!.add(const Duration(days: 1));
  //   }
  //   else if(task.repeat == 'monthly' && DateTime.now().month - task.startDateTime!.month == 1%30){

  //   }
  // }

  void changeTaskOption(String? value, BuildContext context, DateTime? customDate) {
    customFilteredDate = customDate;
    tasksOption = value!;
    emit(TasksOptionChanged());
    emit(TaskUpdated());
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
          // endDateTime: null,
          subtasks: List.empty(growable: true),
        ),
      );
      taskNameController.text = '';
      counter++;
      emit(TaskUpdated());
    }
  }
}
