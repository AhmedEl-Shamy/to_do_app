
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
  // List<Subtask> Subtasks = List.empty();
  List<Subtask> Subtasks = [Subtask(id: 1, name: 'name')];
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
  });

  void addSubtask({required String name, required int id}) {
    Subtasks.add(Subtask(id: id, name: name));
    subtaskId++;
  }

  void deleteSubtask(Subtask Subtask) {
    Subtasks.removeWhere((element) => element.id ==  Subtask.id);
  }

  List<Subtask> get getSubtasks => Subtasks;
}

class Subtask{
  int id;
  String name;
  bool isFinished = false;

  Subtask ({
    required this.id,
    required this.name,
  });
}
