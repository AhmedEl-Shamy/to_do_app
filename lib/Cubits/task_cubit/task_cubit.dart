import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Models/config.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  late List<Task> tasks;

  void setNewTask(){}

  void getTasks(){
    tasks = constTasks;
    emit(TaskUpdated());
  }
  
  void deleteTasks(){}
  
  void editTask(){}
}
