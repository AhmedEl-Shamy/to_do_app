part of 'task_cubit.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}
final class TaskUpdated extends TaskState {}
final class TasksOptionChanged extends TaskState {}
final class TaskStatusUpdated extends TaskState {
  TaskStatusUpdated({required this.taskId});
  int taskId;
}
final class SubtaskStatusUpdated extends TaskState {
  SubtaskStatusUpdated({required this.taskId, required this.subtaskId});
  int taskId;
  int subtaskId;
}

