import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Models/config.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  late List<Task> tasks;
  String tasksOption = 'all';
  TextEditingController nameC = TextEditingController();
  TextEditingController noteC = TextEditingController();
  DateTime date = DateTime.now();
  DateTime? endDate;
  DateTime startTime = DateTime.now();
  DateTime? endTime;
  Color taskColor = Colors.red;
  String repeated = 'none';
  int reminder = 0;

  void setNewTask() {

  }

  void getTasks() {
    tasks = constTasks;
    emit(TaskUpdated());
  }

  void changeTaskOption(String? value) {
    tasksOption = value!;
    emit(TasksOptionChanged());
  }

  void deleteTasks() {}

  void editTask() {}

  void changeDate(DateTime date) {
    this.date = date;
    emit(AddTaskDateChanged());
  }

  void changeEndDate(DateTime endDate) {
    this.endDate = endDate;
    emit(AddTaskEndDateChanged());
  }

  void changeStartTime(DateTime startTime) {
    this.startTime = startTime;
    emit(AddTaskStartTimeChanged());
  }

  void changeEndTime(DateTime endTime) {
    this.endTime = endTime;
    emit(AddTaskEndTimeChanged());
  }

  void changeRepeated(String? value) {
    repeated = value!;
    emit(AddTaskRepeatedChanged());
  }

  void changeSelectedColor(Color color) {
    taskColor = color;
    emit(AddTaskColorChanged());
  }

  void changeReminder(int? reminder) {
    this.reminder = reminder!;
    emit(AddTaskReminderChanged());
  }

  void restoreDefaults() {
    nameC = TextEditingController();
    noteC = TextEditingController();
    date = DateTime.now();
    startTime = DateTime.now();
    endDate = null;
    endTime = null;
    taskColor = Colors.red;
    repeated = 'none';
    reminder = 0;
  }
}
