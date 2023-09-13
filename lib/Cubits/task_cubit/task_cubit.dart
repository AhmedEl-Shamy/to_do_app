import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Models/config.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  late List<Task> tasks;
  String tasksOption = 'all';
  void setNewTask(){}

  void getTasks(){
    tasks = constTasks;
    emit(TaskUpdated());
  }
  
  void changeTaskOption (String? value) {
    tasksOption = value!;
    emit(TasksOptionChanged());
  }
  void deleteTasks(){}
  
  void editTask(){}
}
