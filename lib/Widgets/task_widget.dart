import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/theme_cubit/theme_cubit.dart';
import 'package:to_do/Models/config.dart';

import '../Models/task.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({required this.task, super.key});
  Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: task.color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            task.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          if (task.note != '') SizedBox(height: SizeConfig.heightBlock),
          if (task.note != '')
            Text(task.note, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
