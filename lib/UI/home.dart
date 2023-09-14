import 'package:flutter/material.dart';
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
    BlocProvider.of<TaskCubit>(context).getTasks();
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Tasks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                onPressed: BlocProvider.of<ThemeCubit>(context).changeTheme,
                icon: (!BlocProvider.of<ThemeCubit>(context).isDark)
                    ? const Icon(Icons.dark_mode_sharp)
                    : const Icon(Icons.light_mode_sharp),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
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
                builder: (context) =>  AddTaskWidget(),
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
                          DropdownMenuItem(value: 'all',child: Text('All'),),
                          DropdownMenuItem(value: 'day',child: Text('Day'),),
                          DropdownMenuItem(value: 'custom',child: Text('Custom'),),
                        ],
                        onChanged: BlocProvider.of<TaskCubit>(context).changeTaskOption,
                      ),
                      SizedBox(height: SizeConfig.heightBlock * 2,),
                      Expanded(
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
                      ),
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
}
