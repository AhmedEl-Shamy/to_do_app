import 'package:flutter/material.dart';
import '../Models/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/theme_cubit/theme_cubit.dart';
import '../Cubits/task_cubit/task_cubit.dart';
import '../Widgets/task_widget.dart';

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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return ListView(
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
