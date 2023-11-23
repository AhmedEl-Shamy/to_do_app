import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/edit_task_cubit/edit_task_cubit.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {required this.title, required this.addTaskButton, super.key});
  final String title;
  final bool addTaskButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          if (addTaskButton)
            IconButton(
              onPressed: () {
                BlocProvider.of<EditTaskCubit>(context).restoreDefaults();
                Navigator.of(context).pushNamed('/task_add');
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
