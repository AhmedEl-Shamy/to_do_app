import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/config.dart';

class AddTaskWidget extends StatelessWidget {
  AddTaskWidget({super.key});
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];
  final List<int> reminders = List.generate(13, (index) => index * 5);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.heightBlock * 2),
        _addTaskTextField(
          label: 'Name',
          controller: BlocProvider.of<TaskCubit>(context).nameC,
          context: context,
          lines: 1,
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        _addTaskTextField(
          label: 'Note',
          controller: BlocProvider.of<TaskCubit>(context).noteC,
          context: context,
          lines: 3,
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        BlocBuilder<TaskCubit, TaskState>(
          buildWhen: (previous, current) => current is AddTaskDateChanged,
          builder: (context, state) {
            return _pickerButton(
              type: 'Date',
              str: DateFormat('d/M/y')
                  .format(BlocProvider.of<TaskCubit>(context).date),
              context: context,
            );
          },
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        BlocBuilder<TaskCubit, TaskState>(
          buildWhen: (previous, current) =>
              current is AddTaskEndDateChanged || current is AddTaskDateChanged,
          builder: (context, state) {
            return _pickerButton(
              type: 'End Date',
              str: (BlocProvider.of<TaskCubit>(context).endDate == null)
                  ? 'None'
                  : DateFormat('d/M/y')
                      .format(BlocProvider.of<TaskCubit>(context).endDate!),
              context: context,
            );
          },
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) =>
                    current is AddTaskStartTimeChanged,
                builder: (context, state) {
                  return _pickerButton(
                    type: 'Start Time',
                    str: DateFormat('h:m a')
                        .format(BlocProvider.of<TaskCubit>(context).startTime),
                    context: context,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) =>
                    current is AddTaskEndTimeChanged,
                builder: (context, state) {
                  return _pickerButton(
                    type: 'End Time',
                    str: (BlocProvider.of<TaskCubit>(context).endTime == null)
                        ? 'None'
                        : DateFormat('h:m a').format(
                            BlocProvider.of<TaskCubit>(context).endTime!,
                          ),
                    context: context,
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Repeated',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BorderDirectional(
                  start: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  end: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  top: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              child: BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) =>
                    current is AddTaskRepeatedChanged,
                builder: (context, state) {
                  return DropdownButton(
                    value: BlocProvider.of<TaskCubit>(context).repeated,
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    focusColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    iconEnabledColor: Theme.of(context).colorScheme.primary,
                    iconDisabledColor: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'none',
                        child: Text('None'),
                      ),
                      DropdownMenuItem(
                        value: 'daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: 'weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: 'monthly',
                        child: Text('Monthly'),
                      ),
                    ],
                    onChanged:
                        BlocProvider.of<TaskCubit>(context).changeRepeated,
                  );
                },
              ),
            )
          ],
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reminder',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BorderDirectional(
                  start: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  end: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  top: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              child: BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) =>
                    current is AddTaskReminderChanged,
                builder: (context, state) {
                  return DropdownButton(
                    value: BlocProvider.of<TaskCubit>(context).reminder,
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    focusColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    iconEnabledColor: Theme.of(context).colorScheme.primary,
                    iconDisabledColor: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    items: reminders
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: (e == 0)
                                ? const Text('None')
                                : Text('$e Minutes Early')))
                        .toList(),
                    onChanged:
                        BlocProvider.of<TaskCubit>(context).changeReminder,
                  );
                },
              ),
            )
          ],
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Color',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: colors
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        child: BlocBuilder<TaskCubit, TaskState>(
                          buildWhen: (previous, current) =>
                              current is AddTaskColorChanged,
                          builder: (context, state) {
                            return CircleAvatar(
                              backgroundColor: e,
                              child: (BlocProvider.of<TaskCubit>(context)
                                          .taskColor ==
                                      e)
                                  ? const Icon(
                                      Icons.done_outlined,
                                      color: Colors.white,
                                    )
                                  : null,
                            );
                          },
                        ),
                        onTap: () => BlocProvider.of<TaskCubit>(context)
                            .changeSelectedColor(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: SizeConfig.heightBlock * 2),
          ],
        ),
      ],
    );
  }

  TextField _addTaskTextField({
    required label,
    required TextEditingController controller,
    required BuildContext context,
    required int lines,
  }) =>
      TextField(
        controller: controller,
        maxLines: lines,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter Task $label',
          contentPadding: const EdgeInsets.all(8),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2),
          ),
        ),
      );
  Column _pickerButton(
      {required String type,
      required String str,
      required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (type == 'Date') {
              showDatePicker(
                helpText: 'Select Date',
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 2),
                ),
              ).then((value) =>
                  BlocProvider.of<TaskCubit>(context).changeDate(value!));
            } else if (type == 'End Date') {
              showDatePicker(
                helpText: 'Select End Date',
                context: context,
                initialDate: BlocProvider.of<TaskCubit>(context).date,
                firstDate: BlocProvider.of<TaskCubit>(context).date,
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 2),
                ),
              ).then((value) {
                if (value != null) {
                  BlocProvider.of<TaskCubit>(context).changeEndDate(value);
                }
              });
            } else {
              showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      helpText: 'Select $type')
                  .then((value) {
                if (type == 'Start Time') {
                  DateTime startTime = DateTime(
                    BlocProvider.of<TaskCubit>(context).date.year,
                    BlocProvider.of<TaskCubit>(context).date.month,
                    BlocProvider.of<TaskCubit>(context).date.day,
                    value == null
                        ? BlocProvider.of<TaskCubit>(context).date.hour
                        : value.hour,
                    value == null
                        ? BlocProvider.of<TaskCubit>(context).date.minute
                        : value.minute,
                    BlocProvider.of<TaskCubit>(context).date.second,
                  );
                  BlocProvider.of<TaskCubit>(context)
                      .changeStartTime(startTime);
                } else {
                  if (value != null) {
                    DateTime endTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      value!.hour,
                      value.minute,
                      DateTime.now().second,
                    );
                    BlocProvider.of<TaskCubit>(context).changeEndTime(endTime);
                  }
                }
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(str),
              (type == 'Date' || type == 'End Date')
                  ? const Icon(Icons.calendar_month_outlined)
                  : const Icon(Icons.alarm_outlined),
            ],
          ),
        )
      ],
    );
  }
}
