import 'package:flutter/material.dart';

class Task{
  String name;
  String? description;
  Color? color;

  Task({required this.name, this.description = '', this.color = Colors.blue});
}