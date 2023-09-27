import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:to_do/Cubits/theme_cubit/theme_cubit.dart';
import 'package:to_do/Models/config.dart';
import 'package:to_do/Models/task.dart';

class TaskInfoPage extends StatelessWidget {
  const TaskInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)!.settings.arguments as Task;
    BlocProvider.of<EditTaskCubit>(context).setDataFromTask(task);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.primary,
          title: Hero(
            tag: '${task.id}',
            child: Text(
              task.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed('/task_edit', arguments: task),
              icon: const Icon(Icons.edit_document),
            ),
            IconButton(
              onPressed: BlocProvider.of<ThemeCubit>(context).changeTheme,
              icon: (!BlocProvider.of<ThemeCubit>(context).isDark)
                  ? const Icon(Icons.dark_mode_sharp)
                  : const Icon(Icons.light_mode_sharp),
            ),
            SizedBox(
              width: SizeConfig.widthBlock,
            ),
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                        text: 'Note',
                        children: [
                          TextSpan(
                              text: '\n${task.note}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.heightBlock * 5,
                  ),
                  _addInfo(
                    type: 'Start Date',
                    value: '\t${DateFormat('d/M/y').format(task.startDateTime)}',
                    context: context,
                  ),
                  SizedBox(height: SizeConfig.heightBlock * 2),
                  _addInfo(
                    type: 'End Date',
                    value: (task.endDateTime != null)
                        ? '\t${DateFormat('d/M/y').format(task.endDateTime!)}'
                        : '\tNone',
                    context: context,
                  ),
                  SizedBox(
                    height: SizeConfig.heightBlock * 5,
                  ),
                  _addInfo(
                      type: 'Start Time',
                      value: '\t${DateFormat('h:m a').format(task.startDateTime)}',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 2),
                  _addInfo(
                      type: 'End Time',
                      value: (task.endDateTime != null)
                          ? '\t${DateFormat('h:m a').format(task.endDateTime!)}'
                          : '\tNone',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 5),
                  _addInfo(
                      type: 'Repeat',
                      value: (task.repeat != 'none')? '\t${task.repeat}' : '\tNone',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 4),
                  _addInfo(
                      type: 'Reminder',
                      value: (task.reminder != 0)? '\t${task.reminder} minutes early' : '\tNone',
                      context: context),
                  SizedBox(height: SizeConfig.heightBlock * 4),
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Ok'),
                  ),
                ],
              )
            ],
          ),
        ),
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
}
