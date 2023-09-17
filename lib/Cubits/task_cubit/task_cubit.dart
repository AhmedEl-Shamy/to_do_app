import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Models/config.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  late List<Task> tasks = List.empty(growable: true);
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


  int lastTaskId = 0; //Until finishing the db
  void addNewTask() {
    tasks.add(Task(
      name: nameC.text,
      note:  noteC.text,
      color: taskColor,
      repeat: repeated,
      reminder: reminder,
      startTime: startTime,
      endtTime: endTime,
      date: date,
      endDate: endDate,
      id: lastTaskId,
    ));
    lastTaskId++;
    emit(TaskUpdated());
  }

  // void getTasks() {
  //   tasks = constTasks;
  //   emit(TaskUpdated());
  // }

  void changeTaskOption(String? value) {
    tasksOption = value!;
    emit(TasksOptionChanged());
  }

  void deleteTasks(int taskId) {
    tasks.removeAt(tasks.indexWhere((element) => element.id == taskId));
    emit(TaskUpdated());
  }

  void editTask(Task task) {
    int index = tasks.indexWhere((element) => element.id == task.id);
    tasks.removeAt(index);
    tasks.insert(index, Task(
      name: nameC.text,
      note:  noteC.text,
      color: taskColor,
      repeat: repeated,
      reminder: reminder,
      startTime: startTime,
      endtTime: endTime,
      date: date,
      endDate: endDate,
      id: lastTaskId,
    ));
    emit(TaskUpdated());
  }

  void changeDate(DateTime date) {
    this.date = date;
    emit(AddTaskDateChanged());
  }

  void changeEndDate(DateTime endDate) {
    this.endDate = endDate;
    endTime = startTime.add(const Duration(hours: 1));
    emit(AddTaskEndDateChanged());
    emit(AddTaskEndTimeChanged());
  }

  void changeStartTime(DateTime time) {
    if (time.compareTo(DateTime.now()) < 0) {
      date = date.add(const Duration(days: 1));
      if (endDate != null && endDate!.compareTo(date) < 0) {
        endDate = endDate!.add(const Duration(days: 1));
      }
    }
    startTime = time;
    emit(AddTaskStartTimeChanged());
    emit(AddTaskDateChanged());
    emit(AddTaskEndDateChanged());
  }

  void changeEndTime(DateTime endTime) {
    this.endTime = endTime;
    endDate = date;
    if (endTime.compareTo(startTime) < 0) {
      endDate = endDate!.add(const Duration(days: 1));
    }
    emit(AddTaskEndTimeChanged());
    emit(AddTaskEndDateChanged());
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
    nameC.text = '';
    noteC.text = '';
    date = DateTime.now();
    startTime = DateTime.now();
    endDate = null;
    endTime = null;
    taskColor = Colors.red;
    repeated = 'none';
    reminder = 0;
  }

  void setDataFromTask (Task task){
    nameC.text = task.name;
    noteC.text = task.note;
    date = task.date;
    startTime = task.startTime;
    endDate = task.endDate;
    endTime = task.endtTime;
    taskColor = task.color;
    repeated = task.repeat;
    reminder = task.reminder;
  }
}
