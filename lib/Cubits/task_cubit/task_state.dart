part of 'task_cubit.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}
final class TaskUpdated extends TaskState {}
final class TasksOptionChanged extends TaskState {}
final class AddTaskDateChanged extends TaskState {}
final class AddTaskEndDateChanged extends TaskState {}
final class AddTaskStartTimeChanged extends TaskState {}
final class AddTaskEndTimeChanged extends TaskState {}
final class AddTaskColorChanged extends TaskState {}
final class AddTaskRepeatedChanged extends TaskState {}
final class AddTaskReminderChanged extends TaskState {}
