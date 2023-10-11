import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';
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
          controller: BlocProvider.of<EditTaskCubit>(context).nameC,
          context: context,
          lines: 1,
          hasMultilineInput: false,
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        _addTaskTextField(
          label: 'Description',
          controller: BlocProvider.of<EditTaskCubit>(context).noteC,
          context: context,
          lines: 4,
          hasMultilineInput: true,
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        BlocBuilder<EditTaskCubit, EditTaskState>(
          buildWhen: (previous, current) =>
              current is EditTaskStartDateTimeChanged,
          builder: (context, state) {
            return _pickerButton(
              type: 'Date',
              str: (BlocProvider.of<EditTaskCubit>(context).startDateTime !=
                      null)
                  ? DateFormat('d/M/y').format(
                      BlocProvider.of<EditTaskCubit>(context).startDateTime!)
                  : 'None',
              context: context,
            );
          },
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        // BlocBuilder<EditTaskCubit, EditTaskState>(
        //   buildWhen: (previous, current) =>
        //       current is EditTaskEndDateTimeChanged,
        //   builder: (context, state) {
        //     return _pickerButton(
        //       type: 'End Date',
        //       str: (BlocProvider.of<EditTaskCubit>(context).endDateTime == null)
        //           ? 'None'
        //           : DateFormat('d/M/y').format(
        //               BlocProvider.of<EditTaskCubit>(context).endDateTime!),
        //       context: context,
        //     );
        //   },
        // ),
        // SizedBox(height: SizeConfig.heightBlock * 2),
        BlocBuilder<EditTaskCubit, EditTaskState>(
          buildWhen: (previous, current) =>
              current is EditTaskStartDateTimeChanged,
          builder: (context, state) {
            return _pickerButton(
              type: 'Start Time',
              str: (BlocProvider.of<EditTaskCubit>(context).startDateTime !=
                      null)
                  ? DateFormat('hh:mm a').format(
                      BlocProvider.of<EditTaskCubit>(context).startDateTime!)
                  : 'None',
              context: context,
            );
          },
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: BlocBuilder<EditTaskCubit, EditTaskState>(
        //         buildWhen: (previous, current) =>
        //             current is EditTaskStartDateTimeChanged,
        //         builder: (context, state) {
        //           return _pickerButton(
        //             type: 'Start Time',
        //             str: (BlocProvider.of<EditTaskCubit>(context)
        //                         .startDateTime !=
        //                     null)
        //                 ? DateFormat('hh:mm a').format(
        //                     BlocProvider.of<EditTaskCubit>(context)
        //                         .startDateTime!)
        //                 : 'None',
        //             context: context,
        //           );
        //         },
        //       ),
        //     ),
        //     const SizedBox(width: 10),
        //     Expanded(
        //       child: BlocBuilder<EditTaskCubit, EditTaskState>(
        //         buildWhen: (previous, current) =>
        //             current is EditTaskEndDateTimeChanged,
        //         builder: (context, state) {
        //           return _pickerButton(
        //             type: 'End Time',
        //             str: (BlocProvider.of<EditTaskCubit>(context).endDateTime ==
        //                     null)
        //                 ? 'None'
        //                 : DateFormat('hh:mm a').format(
        //                     BlocProvider.of<EditTaskCubit>(context)
        //                         .endDateTime!,
        //                   ),
        //             context: context,
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
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
                border: Border.all(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: BlocBuilder<EditTaskCubit, EditTaskState>(
                buildWhen: (previous, current) =>
                    current is EditTaskRepeatedChanged,
                builder: (context, state) {
                  return DropdownButton(
                    value: BlocProvider.of<EditTaskCubit>(context).repeated,
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
                        BlocProvider.of<EditTaskCubit>(context).changeRepeated,
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
                  border: Border.all(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
              child: BlocBuilder<EditTaskCubit, EditTaskState>(
                buildWhen: (previous, current) =>
                    current is EditTaskReminderChanged,
                builder: (context, state) {
                  return DropdownButton(
                    value: BlocProvider.of<EditTaskCubit>(context).reminder,
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
                        BlocProvider.of<EditTaskCubit>(context).changeReminder,
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
                        child: BlocBuilder<EditTaskCubit, EditTaskState>(
                          buildWhen: (previous, current) =>
                              current is EditTaskColorChanged,
                          builder: (context, state) {
                            return CircleAvatar(
                              backgroundColor: e,
                              child: (BlocProvider.of<EditTaskCubit>(context)
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
                        onTap: () => BlocProvider.of<EditTaskCubit>(context)
                            .changeSelectedColor(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
        BlocBuilder<EditTaskCubit, EditTaskState>(
          buildWhen: (previous, current) => current is EditTaskSubtasksChanged,
          builder: (context, state) {
            return _addSubtasksSection(context);
          },
        ),
        SizedBox(height: SizeConfig.heightBlock * 2),
      ],
    );
  }

  TextField _addTaskTextField({
    required label,
    required TextEditingController controller,
    required BuildContext context,
    required int lines,
    required bool hasMultilineInput,
  }) =>
      TextField(
        controller: controller,
        maxLines: lines,
        keyboardType:
            (hasMultilineInput) ? TextInputType.multiline : TextInputType.text,
        decoration: InputDecoration(
          labelText: (hasMultilineInput) ? null : label,
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
          required BuildContext context}) =>
      Column(
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
            onPressed: getMethod(type, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(str),
                (type == 'Date' || type == 'End Date')
                    ? const Icon(Icons.calendar_month_outlined)
                    : const Icon(Icons.access_time),
              ],
            ),
          )
        ],
      );

  void Function()? getMethod(String type, BuildContext context) {
    if (type == 'Date') {
      return () {
        showDatePicker(
          helpText: 'Select Date',
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365 * 2),
          ),
        ).then((value) =>
            BlocProvider.of<EditTaskCubit>(context).changeDate(value));
      };
    }
    // else if (type == 'End Date' &&
    //     BlocProvider.of<EditTaskCubit>(context).startDateTime != null) {
    //   return () {
    //     showDatePicker(
    //       helpText: 'Select End Date',
    //       context: context,
    //       initialDate: BlocProvider.of<EditTaskCubit>(context).startDateTime!,
    //       firstDate: BlocProvider.of<EditTaskCubit>(context).startDateTime!,
    //       lastDate: DateTime.now().add(
    //         const Duration(days: 365 * 2),
    //       ),
    //     ).then((value) {
    //       if (value != null) {
    //         BlocProvider.of<EditTaskCubit>(context).changeEndDate(value);
    //       }
    //     });
    //   };
    // }
    else if (type == 'Start Time') {
      return () {
        showTimePicker(
                context: context,
                initialTime: (BlocProvider.of<EditTaskCubit>(context)
                            .startDateTime !=
                        null)
                    ? TimeOfDay.fromDateTime(
                        BlocProvider.of<EditTaskCubit>(context).startDateTime!)
                    : TimeOfDay.now(),
                helpText: 'Select $type')
            .then(
          (value) {
            if (value != null) {
              BlocProvider.of<EditTaskCubit>(context).changeStartTime(value);
            }
          },
        );
      };
    }
    // else if (type == 'End Time' &&
    //     BlocProvider.of<EditTaskCubit>(context).startDateTime != null) {
    //   return () {
    //     showTimePicker(
    //             context: context,
    //             initialTime: (BlocProvider.of<EditTaskCubit>(context)
    //                         .endDateTime !=
    //                     null)
    //                 ? TimeOfDay.fromDateTime(
    //                     BlocProvider.of<EditTaskCubit>(context).endDateTime!)
    //                 : TimeOfDay.fromDateTime(
    //                     BlocProvider.of<EditTaskCubit>(context)
    //                         .startDateTime!
    //                         .add(const Duration(hours: 1)),
    //                   ),
    //             helpText: 'Select $type')
    //         .then(
    //       (value) {
    //         if (value != null) {
    //           BlocProvider.of<EditTaskCubit>(context).changeEndTime(value);
    //         }
    //       },
    //     );
    //   };
    // }
    else
      return null;
  }

  Widget _addSubtaskWidget(BuildContext context) => Row(
        children: [
          Expanded(
            child: TextField(
              key: BlocProvider.of<EditTaskCubit>(context).textFieldKey,
              focusNode: BlocProvider.of<EditTaskCubit>(context).focusNode,
              controller: BlocProvider.of<EditTaskCubit>(context).subtaskNameC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Add Subtask',
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                isDense: true,
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.widthBlock * 2,
          ),
          FilledButton(
            onPressed: BlocProvider.of<EditTaskCubit>(context).addSubtask,
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // padding: const EdgeInsets.all(10),
              // visualDensity: VisualDensity.standard,
            ),
            child: const Icon(Icons.add),
          )
        ],
      );

  Widget _addSubtasksSection(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Subtasks',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...BlocProvider.of<EditTaskCubit>(context)
              .subtasks
              .map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.widthBlock * 5,
                        ),
                        Text(
                          e.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => BlocProvider.of<EditTaskCubit>(context)
                          .deleteSubtask(e.id),
                      style: IconButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          padding: EdgeInsets.zero),
                      icon: const Icon(Icons.remove),
                    )
                  ],
                ),
              )
              .toList(),
          _addSubtaskWidget(context),
        ],
      );
}
