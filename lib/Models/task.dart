import 'package:flutter/material.dart';

class Task {
  String name;
  String note;
  Color color;
  String repeat;
  String date;
  String startTime;
  String endtTime;

  Task({
    required this.name,
    this.note = '',
    this.color = Colors.redAccent,
    this.date = 'none',
    this.repeat = 'none',
    this.startTime = 'none',
    this.endtTime = 'none',
  });
}
