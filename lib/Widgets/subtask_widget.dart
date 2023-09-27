import 'package:flutter/material.dart';

import 'package:to_do/Models/task.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({required this.subtask,super.key});
  final Subtask subtask;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _checkBox(),
      title: Text(
        subtask.name,
      ),
    );
  }

  Checkbox _checkBox() => Checkbox(
        value: subtask.isFinished,
        onChanged: (value) {
          // setState(() {
          //   subtask.isFinished = !subtask.isFinished;
          //   // BlocProvider.of<TaskCubit>(context)
          //   //     .deleteTasks(subtask.id);
          // });
        },
        fillColor: MaterialStateProperty.all(Colors.transparent),
        side: const BorderSide(
            color: Colors.white, width: 1.5, style: BorderStyle.solid),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
      );
}