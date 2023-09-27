import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:to_do/Cubits/theme_cubit/theme_cubit.dart';
import 'package:to_do/Models/config.dart';
import 'package:to_do/Widgets/add_task_widget.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBar(
              foregroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                'Add new task',
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
                      BlocProvider.of<EditTaskCubit>(context)
                          .createNewTask(context);
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
    );
  }
}
