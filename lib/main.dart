import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/theme_cubit/theme_cubit.dart';
import 'package:to_do/Models/config.dart';
import 'package:to_do/Models/database_helper.dart';
import 'package:to_do/UI/task_edit_page.dart';
import 'package:to_do/UI/task_info_page.dart';
import 'Cubits/task_cubit/task_cubit.dart';
import 'UI/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => TaskCubit()),
      ],
      child: const ToDoApp(),
    ));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'ToDo App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ThemeColors.lightScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ThemeColors.darkScheme,
            useMaterial3: true,
          ),
          themeMode: (BlocProvider.of<ThemeCubit>(context).isDark)
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const HomePage(),
          routes: {
            '/task_info':(context) => const TaskInfoPage(),
            '/task_edit':(context) => const TaskEditPage(),
          },
        );
      },
    );
  }
}
