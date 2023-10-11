import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/task.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitial());
  TextEditingController nameC = TextEditingController();
  TextEditingController noteC = TextEditingController();
  DateTime? startDateTime;
  Color taskColor = Colors.red;
  String repeated = 'none';
  int reminder = 0;
  int lastTaskId = 0; //Until finishing the db

  List<Subtask> subtasks = List<Subtask>.empty(growable: true);
  TextEditingController subtaskNameC = TextEditingController();
  int lastSubtaskId = 0;

  FocusNode focusNode = FocusNode();
  GlobalKey textFieldKey = GlobalKey();

  void createNewTask(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).addNewTask(Task(
      name: nameC.text,
      description: noteC.text,
      color: taskColor,
      repeat: repeated,
      reminder: reminder,
      startDateTime: startDateTime,
      // endDateTime: endDateTime,
      id: lastTaskId,
      subtasks: List.from(subtasks),
    ));
    lastTaskId++;
  }

  void editTask(BuildContext context, Task task) {
    BlocProvider.of<TaskCubit>(context).editTask(Task(
      name: nameC.text,
      description: noteC.text,
      color: taskColor,
      repeat: repeated,
      reminder: reminder,
      startDateTime: startDateTime,
      // endDateTime: endDateTime,
      id: task.id,
      subtasks: List.from(subtasks),
    ));
  }

  void changeDate(DateTime? date) {
    if (date != null) {
      if (startDateTime == null) {
        startDateTime = DateTime.parse(
          '${date.toString().substring(0, 10)}${DateTime.now().toString().substring(10)}',
        );
      } else
        startDateTime = DateTime.parse(
          '${date.toString().substring(0, 10)}${startDateTime.toString().substring(10)}',
        );
    }
    // else
    //   date = DateTime.now();
    emit(EditTaskStartDateTimeChanged());
    // emit(EditTaskEndDateTimeChanged());
  }

  // void intializeEndTime() {
  //   endDateTime ??= startDateTime!.add(const Duration(hours: 1));
  // }

  // void changeEndDate(DateTime endDate) {
  //   intializeEndTime();
  //   endDateTime = DateTime.parse(
  //     '${endDate.toString().substring(0, 10)}${endDateTime.toString().substring(10)}',
  //   );
  //   emit(EditTaskEndDateTimeChanged());
  // }

  void changeStartTime(TimeOfDay time) {
    DateTime startTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
      DateTime.now().second,
      DateTime.now().millisecond,
      DateTime.now().microsecond,
    );
      if (startDateTime == null) {
        startDateTime = DateTime.parse(
          '${DateTime.now().toString().substring(0, 10)}${startTime.toString().substring(10)}',
        );
      } else {
        startDateTime = DateTime.parse(
          '${startDateTime.toString().substring(0, 10)}${startTime.toString().substring(10)}',
        );
      }
      if (startDateTime!.compareTo(DateTime.now()) < 0)
        startDateTime = DateTime.parse(
          '${startDateTime!.add(const Duration(days: 1)).toString().substring(0, 10)}${startDateTime!.toString().substring(10)}',
        );
    emit(EditTaskStartDateTimeChanged());
    // emit(EditTaskEndDateTimeChanged());
  }

  // void changeEndTime(TimeOfDay time) {
  //   DateTime endTime = DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day,
  //     time.hour,
  //     time.minute,
  //     DateTime.now().second,
  //     DateTime.now().millisecond,
  //     DateTime.now().microsecond,
  //   );
  //   intializeEndTime();
  //   endDateTime = DateTime.parse(
  //     '${endDateTime.toString().substring(0, 10)}${endTime.toString().substring(10)}',
  //   );
  //   if (endDateTime!.compareTo(startDateTime!) < 0)
  //       endDateTime = DateTime.parse(
  //         '${endDateTime!.add(const Duration(days: 1)).toString().substring(0, 10)}${endDateTime!.toString().substring(10)}',
  //       );
  //   // endDate = date;
  //   // if (endTime.compareTo(startDateTime) < 0) {
  //   //   endDate = endDate!.add(const Duration(days: 1));
  //   // }
  //   emit(EditTaskEndDateTimeChanged());
  // }

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

  void addSubtask() {
    subtasks.add(Subtask(id: lastSubtaskId, name: subtaskNameC.text));
    lastSubtaskId++;
    restoreSubtaskDefaults();
    focusNode.requestFocus();
    Scrollable.ensureVisible(textFieldKey.currentContext!);
    emit(EditTaskSubtasksChanged());
  }

  void deleteSubtask(int subtaskID) {
    subtasks.removeWhere(
      (element) => element.id == subtaskID,
    );
    emit(EditTaskSubtasksChanged());
  }

  void restoreSubtaskDefaults() => subtaskNameC.text = '';

  void restoreDefaults() {
    nameC.text = '';
    noteC.text = '';
    startDateTime = null;
    // endDateTime = null;
    taskColor = Colors.red;
    repeated = 'none';
    reminder = 0;
    subtasks.clear();
  }

  void setDataFromTask(Task task) {
    nameC.text = task.name;
    noteC.text = task.description;
    startDateTime = task.startDateTime;
    // endDateTime = task.endDateTime;
    taskColor = task.color;
    repeated = task.repeat;
    reminder = task.reminder;
    subtasks = List.from(task.getSubtasks);
  }
}
