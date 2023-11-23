import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:to_do/Models/notification_service.dart';
import 'package:to_do/Widgets/appbar_widget.dart';
import 'package:flutter/services.dart';

import '../Models/config.dart';
import '../Cubits/theme_cubit/theme_cubit.dart';
import '../Cubits/task_cubit/task_cubit.dart';
import '../Widgets/task_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.background,
        statusBarIconBrightness: (BlocProvider.of<ThemeCubit>(context).isDark) ? Brightness.light : Brightness.dark,
      ),
    );
    BlocProvider.of<TaskCubit>(context).getTasks();
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const Drawer(),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     NotificationService.pushScheduleNotification(
          //       notificationId: 0,
          //       notificationTitle: 'Test Notification',
          //       notificationBody: 'This is test Notification body',
          //       dateTime: DateTime.now().add(const Duration(seconds: 5)),
          //     );
          //   },
          //   child: const Icon(Icons.add),
          // ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  const AppBarWidget(title: 'Tasks', addTaskButton: true),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: BlocProvider.of<TaskCubit>(context).taskNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Create Quick Task',
                            isDense: true,
                            contentPadding: const EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthBlock * 2,
                      ),
                      FilledButton(
                        onPressed: BlocProvider.of<TaskCubit>(context).addQuickTask,
                        style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // padding: const EdgeInsets.all(10),
                            visualDensity: VisualDensity.compact),
                        child: const Icon(Icons.add),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightBlock * 2,
                  ),
                  BlocBuilder<TaskCubit, TaskState>(
                    buildWhen: (previous, current) => current is TasksOptionChanged,
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          underline: const SizedBox(),
                          // borderRadius: BorderRadius.circular(20),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          isExpanded: true,
                          focusColor: Colors.transparent,
                          value: BlocProvider.of<TaskCubit>(context).tasksOption,
                          items: [
                            const DropdownMenuItem(
                              value: 'all',
                              child: Text('All'),
                            ),
                            const DropdownMenuItem(
                              value: 'today',
                              child: Text('To Day'),
                            ),
                            DropdownMenuItem(
                              value: 'custom',
                              child: (BlocProvider.of<TaskCubit>(context).customFilteredDate != null)
                                  ? Text(DateFormat('d/M/y').format(BlocProvider.of<TaskCubit>(context).customFilteredDate!))
                                  : const Text('Custom'),
                            ),
                            const DropdownMenuItem(
                              value: 'none',
                              child: Text('No Date'),
                            ),
                          ],
                          onChanged: (value) async {
                            DateTime? customDate;
                            if (value == 'custom')
                              customDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)));
                            if (context.mounted) BlocProvider.of<TaskCubit>(context).changeTaskOption(value, context, customDate);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.heightBlock * 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<TaskCubit, TaskState>(
                            buildWhen: (previous, current) => current is TaskUpdated,
                            builder: (context, state) {
                              return (BlocProvider.of<TaskCubit>(context).tasks.isNotEmpty)
                                  ? _displayTasks(context: context)
                                  : _noTasksMsg(context: context);
                            },
                          ),
                          SizedBox(
                            key: BlocProvider.of<TaskCubit>(context).bottomWidgetKey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Expanded _noTasksMsg({required BuildContext context}) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.heightBlock * 15,
          ),
          SvgPicture.asset(
            'images/task.svg',
            width: 125,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            height: SizeConfig.heightBlock * 2,
          ),
          const Text(
            'You don\'t have tasks to Display!\nAdding new tasks to make your days more productive.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Column _displayTasks({required BuildContext context}) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 600),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 300,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: [
          ...BlocProvider.of<TaskCubit>(context)
              .getFilteredTasks()
              .map(
                (task) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: TaskWidget(
                    task: task,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
