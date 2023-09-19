import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Models/task.dart';
import 'package:intl/intl.dart';
// import 'package:to_do/Models/config.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  List<Task> tasks = List.empty(growable: true);
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
      note: noteC.text,
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

  // if (value == 'custom') {
  //     DateTime? customDate;
  //     showDatePicker(
  //       helpText: 'Select Date',
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime.now().add(
  //         const Duration(days: 365 * 2),
  //       ),
  //     ).then((value) {
  //       customDate = value;
  //     });
  //     if (customDate != null) {}
  //   } else if (value == 'day') {
  //     tasks = tasks.where((element) {
  //       if ((element.repeat == 'daily' && dateTimeCopmerable(element.date, DateTime.now()) <= 0) ||
  //           dateTimeCopmerable(element.date, DateTime.now()) == 0)
  //         return true;
  //       else
  //         return false;
  //     }).toList();
  //   } else {
  //   }

  // List<Task> displayTask() {
  //   if (tasksOption == 'all')
  //     return tasks;
  //   else if (tasksOption == 'day') {
  //     print(DateFormat.yM().format(DateTime.now()));
  //     return tasks.where((element) {
  //       if ((element.repeat == 'daily' &&
  //               dateTimeCopmerable(element.date, DateTime.now()) <= 0) ||
  //           DateFormat.yM().format(element.date) ==
  //               DateFormat.yM().format(DateTime.now()))
  //         return true;
  //       else if (element.repeat == 'monthly' &&
  //           DateFormat.yMd()
  //                   .format(element.date.add(const Duration(days: 30))) ==
  //               DateFormat.yMd().format(DateTime.now()))
  //         return true;
  //       else if (element.repeat == 'yearly' &&
  //           DateFormat.yMd()
  //                   .format(element.date.add(const Duration(days: 365))) ==
  //               DateFormat.yMd().format(DateTime.now()))
  //         return true;
  //       else
  //         return false;
  //     }).toList();
  //   } else {
  //     print(DateFormat.yM().format(DateTime.now()));
  //     return tasks.where((element) {
  //       if ((element.repeat == 'daily' &&
  //               dateTimeCopmerable(element.date, DateTime.now()) <= 0) ||
  //           DateFormat.yM().format(element.date) ==
  //               DateFormat.yM().format(DateTime.now()))
  //         return true;
  //       else if (element.repeat == 'monthly' &&
  //           DateFormat.yMd()
  //                   .format(element.date.add(const Duration(days: 30))) ==
  //               DateFormat.yMd().format(DateTime.now()))
  //         return true;
  //       else if (element.repeat == 'yearly' &&
  //           DateFormat.yMd()
  //                   .format(element.date.add(const Duration(days: 365))) ==
  //               DateFormat.yMd().format(DateTime.now()))
  //         return true;
  //       else
  //         return false;
  //     }).toList();
  //   }
  // }

  // void upadateRepeatedTasks() {
  //   for (int i = 0; i < tasks.length; i++) {
  //     if (tasks[i].repeat == 'daily') {
  //       tasks[i].date = tasks[i].date.add(const Duration(days: 1));
  //       if (tasks[i].endDate != null)
  //         tasks[i].endDate = tasks[i].endDate!.add(const Duration(days: 1));
  //     } else if (tasks[i].repeat == 'monthly') {
  //       if (DateFormat.yMd()
  //               .format(DateTime.now().subtract(const Duration(days: 1))) ==
  //           DateFormat.yMd().format(tasks[i].date)) {           
  //           }
  //     }
  //   }
  // }

  void deleteTasks(int taskId) {
    tasks.removeAt(tasks.indexWhere((element) => element.id == taskId));
    emit(TaskUpdated());
  }

  void editTask(Task task) {
    int index = tasks.indexWhere((element) => element.id == task.id);
    tasks.removeAt(index);
    tasks.insert(
        index,
        Task(
          name: nameC.text,
          note: noteC.text,
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

  void changeDate(DateTime? date) {
    if (date != null)
      this.date = date;
    else
      date = DateTime.now();
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

  void setDataFromTask(Task task) {
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
