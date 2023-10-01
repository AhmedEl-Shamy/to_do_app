import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/config.dart';

import 'package:to_do/Models/task.dart';

class SubtaskWidget extends StatelessWidget {
  const SubtaskWidget({required this.task, required this.subtask, super.key});
  final Subtask subtask;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      buildWhen: (previous, current) =>
          current is SubtaskStatusUpdated &&
          current.taskId == task.id &&
          current.subtaskId == subtask.id,
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: SizeConfig.widthBlock * 8,
            ),
            _checkBox(context),
            SizedBox(
              width: SizeConfig.widthBlock * 4,
            ),
            Text(
              subtask.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration:
                    (subtask.isFinished) ? TextDecoration.lineThrough : null,
                decorationColor: Colors.white,
                decorationThickness: 3,
              ),
            ),
          ],
        );
      },
    );
  }

  Checkbox _checkBox(BuildContext context) => Checkbox(
        value: subtask.isFinished,
        onChanged: (value) => BlocProvider.of<TaskCubit>(context)
            .updateSubtaskStatus(taskId: task.id, subtaskId: subtask.id),
        fillColor: MaterialStateProperty.all(Colors.transparent),
        checkColor: Colors.white,
        side: const BorderSide(
            color: Colors.white, width: 1.5, style: BorderStyle.solid),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
      );
}
