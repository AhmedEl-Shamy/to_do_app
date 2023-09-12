import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubits/theme_cubit/theme_cubit.dart';
import 'Cubits/task_cubit/task_cubit.dart';
import 'Cubits/task_cubit/task_cubit.dart';
import 'UI/home.dart';

void main() => runApp(MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => ThemeCubit()),
    BlocProvider(create: (context) => TaskCubit()),
  ],
  child: const  ToDoApp(),
  ));

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}
