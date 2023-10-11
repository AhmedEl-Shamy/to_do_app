import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/config.dart';
import 'package:to_do/Widgets/subtask_widget.dart';
import 'package:to_do/Widgets/task_info_widget.dart';
import '../Models/task.dart';

@immutable
class TaskWidget extends StatelessWidget {
  const TaskWidget({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${task.id}'),
      onDismissed: (direction) =>
          BlocProvider.of<TaskCubit>(context).deleteTask(task.id),
      direction: DismissDirection.horizontal,
      background: const SizedBox(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      child: BlocBuilder<TaskCubit, TaskState>(
        buildWhen: (previous, current) =>
            current is TaskStatusUpdated && current.taskId == task.id,
        builder: (context, state) => (task.getSubtasks.isEmpty)
            ? _normalTask(context)
            : _advancedTask(context),
      ),
    );
  }

  Checkbox _checkBox(BuildContext context) => Checkbox(
        value: task.isFinished,
        onChanged: (value) {
          BlocProvider.of<TaskCubit>(context).updateTaskStatus(task.id);
        },
        checkColor: Colors.white,
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
          if (task.startDateTime != null)
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
                Text(
                  DateFormat('hh:mm a').format(task.startDateTime!),
                  style: const TextStyle(color: Colors.white),
                )
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

  Container _advancedTask(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: task.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: Hero(
            tag: '${task.id}',
            child: Text(
              task.name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: _infoSection(),
          leading: _checkBox(context),
          trailing: _moreInfoButton(context, task.id),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          children: [
            Divider(
              color: Colors.white.withOpacity(0.75),
              indent: SizeConfig.widthBlock * 8,
              endIndent: 10,
              thickness: 1,
            ),
            ...task.getSubtasks
                .map((e) => SubtaskWidget(task: task, subtask: e))
                .toList()
          ],
        ),
      );

  Container _normalTask(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: task.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: _checkBox(context),
          title: Hero(
            tag: '${task.id}',
            child: Text(
              task.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: _moreInfoButton(context, task.id),
          subtitle: _infoSection(),
        ),
      );

  IconButton _moreInfoButton(BuildContext context, int taskId) => IconButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return BlocBuilder<TaskCubit, TaskState>(
              buildWhen: (previous, current) => current is TaskUpdated,
              builder: (context, state) {
                Task task = BlocProvider.of<TaskCubit>(context)
                    .tasks
                    .firstWhere((element) => element.id == taskId);
                return TaskInfoWidget(task: task);
              },
            );
          },
        ),
        icon: const Icon(Icons.more_horiz_rounded),
        style: IconButton.styleFrom(foregroundColor: Colors.white),
      );
}
