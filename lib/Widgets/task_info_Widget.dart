import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:to_do/Models/config.dart';
import 'package:to_do/Models/task.dart';

class TaskInfoWidget extends StatelessWidget {
  const TaskInfoWidget({required this.task, super.key});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              task.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
            indent: SizeConfig.widthBlock * 5,
            endIndent: SizeConfig.widthBlock * 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  if(task.description != '' || task.description != ' ') SizedBox(
                    height: SizeConfig.heightBlock * 3,
                  ),
                  _addInfo(
                    type: 'Start Date',
                    value: (task.startDateTime != null)
                        ? '\t${DateFormat('d/M/y').format(task.startDateTime!)}'
                        : '\tNone',
                    context: context,
                  ),
                  SizedBox(
                    height: SizeConfig.heightBlock * 3,
                  ),
                  _addInfo(
                      type: 'Start Time',
                      value: (task.startDateTime != null)
                          ? '\t${DateFormat('hh:mm a').format(task.startDateTime!)}'
                          : '\tNone',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 2),
                  _addInfo(
                      type: 'Repeat',
                      value: (task.repeat != 'none')
                          ? '\t${task.repeat}'
                          : '\tNone',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 3),
                  _addInfo(
                      type: 'Reminder',
                      value: (task.reminder != 0)
                          ? '\t${task.reminder} minutes early'
                          : '\tNone',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 3),
                  Row(
                    children: [
                      Icon(Icons.color_lens,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary),
                      SizedBox(width: SizeConfig.widthBlock * 2),
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: SizeConfig.widthBlock * 4),
                      CircleAvatar(
                        backgroundColor: task.color,
                        radius: 12,
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightBlock * 3,
                  ),
                  if (task.getSubtasks.isNotEmpty) _subTasks(context, task),
                  if (task.getSubtasks.isNotEmpty)
                    SizedBox(
                      height: SizeConfig.heightBlock * 3,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () {
                    BlocProvider.of<EditTaskCubit>(context)
                        .setDataFromTask(task);
                    Navigator.of(context)
                        .pushNamed('/task_edit', arguments: task);
                  },
                  child: Row(
                    children: [
                      const Text('Edit'),
                      SizedBox(width: SizeConfig.widthBlock),
                      const Icon(
                        Icons.edit,
                        size: 18,
                      )
                    ],
                  ),
                ),
                SizedBox(width: SizeConfig.widthBlock * 2),
                FilledButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Ok'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _addInfo({
    required String type,
    required String value,
    required BuildContext context,
  }) {
    return Row(
      children: [
        if (type == 'Start Date' || type == 'End Date')
          Icon(Icons.calendar_month_outlined,
              size: 18, color: Theme.of(context).colorScheme.primary)
        else if (type == 'Start Time' || type == 'End Time')
          Icon(Icons.access_time,
              size: 18, color: Theme.of(context).colorScheme.primary)
        else if (type == 'Repeat')
          Icon(Icons.repeat,
              size: 18, color: Theme.of(context).colorScheme.primary)
        else
          Icon(Icons.notifications_active,
              size: 18, color: Theme.of(context).colorScheme.primary),
        SizedBox(
          width: SizeConfig.widthBlock * 2,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: type,
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _subTasks(BuildContext context, Task task) => Column(
        children: [
          Row(
            children: [
              Icon(Icons.account_tree_rounded,
                  size: 18, color: Theme.of(context).colorScheme.primary),
              SizedBox(
                width: SizeConfig.widthBlock * 2,
              ),
              const Text(
                'Subtasks',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ...task.getSubtasks
              .map((e) => Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.widthBlock * 4,
                      ),
                      Icon(Icons.remove,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary),
                      SizedBox(
                        width: SizeConfig.widthBlock * 4,
                      ),
                      Expanded(
                        child: Text(
                          e.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ))
              .toList()
        ],
      );
}
