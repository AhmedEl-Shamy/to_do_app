import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Models/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/theme_cubit/theme_cubit.dart';
import '../Cubits/task_cubit/task_cubit.dart';
import '../Widgets/task_widget.dart';
import '../Widgets/add_task_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // BlocProvider.of<TaskCubit>(context).getTasks();
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                'Tasks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              actions: [
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<TaskCubit>(context).restoreDefaults();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    insetPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightBlock * 5,
                        horizontal: SizeConfig.widthBlock * 2),
                    title: const Text(
                      'Add New Task',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: SizedBox(
                      width: SizeConfig.widthBlock * 95,
                      height: SizeConfig.heightBlock * 90,
                      child: SingleChildScrollView(
                        child: AddTaskWidget(),
                      ),
                    ),
                    actions: [
                      FilledButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () {
                          BlocProvider.of<TaskCubit>(context).addNewTask();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add Task'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(20),
                        isExpanded: true,
                        focusColor: Colors.transparent,
                        value: BlocProvider.of<TaskCubit>(context).tasksOption,
                        items: const [
                          DropdownMenuItem(
                            value: 'all',
                            child: Text('All'),
                          ),
                          DropdownMenuItem(
                            value: 'day',
                            child: Text('Day'),
                          ),
                          DropdownMenuItem(
                            value: 'custom',
                            child: Text('Custom'),
                          ),
                        ],
                        onChanged: (value) => BlocProvider.of<TaskCubit>(context)
                            .changeTaskOption(value, context),
                      ),
                      SizedBox(
                        height: SizeConfig.heightBlock * 2,
                      ),
                      (BlocProvider.of<TaskCubit>(context)).tasks.isNotEmpty
                          ? _displayTasks(context: context)
                          : _noTasksMsg(context: context),
                    ],
                  );
                },
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

  Expanded _displayTasks({required BuildContext context}) {
    return Expanded(
      child: ListView(
        children: BlocProvider.of<TaskCubit>(context)
            .tasks
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
      ),
    );
  }
}
