import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  late List<Task> tasks;


  void setNewTask(){}

  void getTasks(){}

  void deleteTasks(){}
  
  void editTask(){}
}
