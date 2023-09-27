import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:to_do/Cubits/theme_cubit/theme_cubit.dart';
import 'package:to_do/Models/config.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Widgets/add_task_widget.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key});
  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)!.settings.arguments as Task;
    BlocProvider.of<EditTaskCubit>(context).setDataFromTask(task);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBar(
                foregroundColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  task.name,
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
              Expanded(
                child: SingleChildScrollView(
                  child: AddTaskWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Cancel'),
                    ),
                    SizedBox(width: SizeConfig.widthBlock * 2),
                    FilledButton(
                      onPressed: () {
                        BlocProvider.of<EditTaskCubit>(context).editTask(context, task);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
