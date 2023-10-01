import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  String note;
  Color color;
  String repeat;
  DateTime startDateTime;
  DateTime? endDateTime;
  int reminder;
  bool isFinished = false;
  bool isOpened = true;
  List<Subtask> subtasks;
  int subtaskId = 0;
  Task({
    required this.name,
    required this.startDateTime,
    required this.endDateTime,
    this.id = 0,
    this.note = '',
    this.color = Colors.redAccent,
    this.repeat = 'none',
    this.reminder = 0,
    required this.subtasks,
  });

  void deleteSubtask(Subtask subtask) {
    subtasks.removeWhere((element) => element.id == subtask.id);
  }

  void finish() => isFinished = !isFinished;

  List<Subtask> get getSubtasks => subtasks;
}

class Subtask {
  int id;
  String name;
  bool isFinished = false;

  Subtask({
    required this.id,
    required this.name,
  });

  void finish() => isFinished = !isFinished;
}
