import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/task.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitial());
  TextEditingController nameC = TextEditingController();
  TextEditingController noteC = TextEditingController();
  DateTime startDateTime = DateTime.now();
  DateTime? endTime;
  Color taskColor = Colors.red;
  String repeated = 'none';
  int reminder = 0;
  int lastTaskId = 0; //Until finishing the db

  List<Subtask> subtasks = List<Subtask>.empty(growable: true);
  TextEditingController subtaskNameC = TextEditingController();
  int lastSubtaskId = 0;

  void createNewTask(BuildContext context){
    BlocProvider.of<TaskCubit>(context).addNewTask(
    Task(
      name: nameC.text,
      note: noteC.text,
      color: taskColor,
      repeat: repeated,
      reminder: reminder,
      startDateTime: startDateTime,
      endDateTime: endTime,
      id: lastTaskId,
      subtasks: List.from(subtasks),
    ));
    lastTaskId++;
  }

  void editTask(BuildContext context, Task task){
    BlocProvider.of<TaskCubit>(context).editTask(
      Task(
      name: nameC.text,
      note: noteC.text,
      color: taskColor,
      repeat: repeated,
      reminder: reminder,
      startDateTime: startDateTime,
      endDateTime: endTime,
      id: task.id,
      subtasks: List.from(subtasks),
    ));
  }

  void changeDate(DateTime? date) {
    if (date != null)
      startDateTime = DateTime.parse(
        '${date.toString().substring(0, 10)}${startDateTime.toString().substring(10)}',
      );
    else
      date = DateTime.now();
    emit(EditTaskStartDateTimeChanged());
  }

  void intializeEndTime() {
    endTime ??= startDateTime.add(const Duration(hours: 1));
  }

  void changeEndDate(DateTime endDate) {
    intializeEndTime();
    endTime = DateTime.parse(
      '${endDate.toString().substring(0, 10)}${endTime.toString().substring(10)}',
    );
    emit(EditTaskEndDateTimeChanged());
  }

  void changeStartTime(DateTime time) {
    if (time.compareTo(DateTime.now()) < 0) {
      startDateTime = DateTime.parse(
        '${startDateTime.toString().substring(0, 10)}${time.toString().substring(10)}',
      );
      // if (endTime != null && endTime!.compareTo(startDateTime) < 0) {
      //   endTime = endTime!.add(const Duration(days: 1));
      // }
    }
    startDateTime = time;
    emit(EditTaskStartDateTimeChanged());
    emit(EditTaskEndDateTimeChanged());
  }

  void changeEndTime(DateTime time) {
    intializeEndTime();
    endTime = DateTime.parse(
      '${endTime.toString().substring(0, 10)}${time.toString().substring(10)}',
    );
    // endDate = date;
    // if (endTime.compareTo(startDateTime) < 0) {
    //   endDate = endDate!.add(const Duration(days: 1));
    // }
    emit(EditTaskEndDateTimeChanged());
  }

  void changeRepeated(String? value) {
    repeated = value!;
    emit(EditTaskRepeatedChanged());
  }

  void changeSelectedColor(Color color) {
    taskColor = color;
    emit(EditTaskColorChanged());
  }

  void changeReminder(int? reminder) {
    this.reminder = reminder!;
    emit(EditTaskReminderChanged());
  }

  void addSubtask(){
    subtasks.add(Subtask(id: lastSubtaskId, name: subtaskNameC.text));
    lastSubtaskId++;
    restoreSubtaskDefaults();
    emit(EditTaskSubtasksChanged());
  }

void deleteSubtask(int subtaskID){
    subtasks.removeWhere((element) => element.id == subtaskID,);
    emit(EditTaskSubtasksChanged());
  }

  void restoreSubtaskDefaults() => subtaskNameC.text = '';

  void restoreDefaults() {
    nameC.text = '';
    noteC.text = '';
    startDateTime = DateTime.now().add(const Duration(hours: 1));
    endTime = null;
    taskColor = Colors.red;
    repeated = 'none';
    reminder = 0;
    subtasks.clear();
  }

  void setDataFromTask(Task task) {
    nameC.text = task.name;
    noteC.text = task.note;
    startDateTime = task.startDateTime;
    endTime = task.endDateTime;
    taskColor = task.color;
    repeated = task.repeat;
    reminder = task.reminder;
    subtasks = List.from(task.getSubtasks);
  }
}
