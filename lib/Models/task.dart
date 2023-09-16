
import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  String note;
  Color color;
  String repeat;
  DateTime date;
  DateTime? endDate;
  DateTime startTime;
  DateTime? endtTime;
  int reminder;
  bool isFinished = false;

  Task({
    required this.name,
    required this.date,
    required this.endDate,
    required this.startTime,
    required this.endtTime,
    this.id = 0,
    this.note = '',
    this.color = Colors.redAccent,
    this.repeat = 'none',
    this.reminder = 0,
  });
}
