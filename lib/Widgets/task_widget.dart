import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/config.dart';
import '../Models/task.dart';

@immutable
class TaskWidget extends StatelessWidget {
  const TaskWidget({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${task.id}'),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd)
          Navigator.pushNamed(context, '/task_info', arguments: task);
        else
          BlocProvider.of<TaskCubit>(context).deleteTask(task.id);
      },
      direction: DismissDirection.horizontal,
      background: SizedBox(
        child: Icon(
          Icons.edit_document,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      secondaryBackground: const SizedBox(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      child: (task.note == '') ? _normalTask() : _advancedTask(),
    );
  }

  Checkbox _checkBox() => Checkbox(
        value: task.isFinished,
        onChanged: (value) {
          // setState(() {
          //   task.isFinished = !task.isFinished;
          //   // BlocProvider.of<TaskCubit>(context)
          //   //     .deleteTasks(task.id);
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

  Row _infoSection() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(
                width: SizeConfig.widthBlock,
              ),
              if (task.endDateTime == null)
                Text(
                  DateFormat('h:m a').format(task.startDateTime),
                  style: const TextStyle(color: Colors.white),
                )
              else
                Text(
                  '${DateFormat('h:m a').format(task.startDateTime)} : ${DateFormat('h:m a').format(task.endDateTime!)}',
                  style: const TextStyle(color: Colors.white),
                ),
            ],
          ),
          SizedBox(
            width: SizeConfig.widthBlock * 4,
          ),
          if (task.repeat != 'none')
            const Icon(
              Icons.repeat_outlined,
              color: Colors.white,
              size: 16,
            ),
          if (task.repeat != 'none')
            SizedBox(
              width: SizeConfig.widthBlock * 4,
            ),
          if (task.reminder != 0)
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 16,
            ),
          if (task.reminder != 0)
            SizedBox(
              width: SizeConfig.widthBlock * 4,
            ),
          if (task.getSubtasks.isNotEmpty)
            const Icon(
              Icons.account_tree_rounded,
              color: Colors.white,
              size: 16,
            )
        ],
      );

  ExpansionTile _advancedTask() => ExpansionTile(
        title: Hero(
          tag: '${task.id}',
          child: Text(
            task.name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: _infoSection(),
        leading: _checkBox(),
        trailing:
            (task.note != '') ? const Icon(Icons.notes) : const SizedBox(),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        backgroundColor: task.color,
        // childrenPadding: const EdgeInsets.symmetric(horizontal: 2),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: task.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          Text(
            '\n${task.note}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: SizeConfig.heightBlock * 3),
          ...task.getSubtasks.map((e) => Container()).toList()
        ],
      );

  ListTile _normalTask() => ListTile(
        leading: _checkBox(),
        title: Hero(
          tag: '${task.id}',
          child: Text(
            task.name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: _infoSection(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: task.color,
      );
}
