part of 'edit_task_cubit.dart';

sealed class EditTaskState {}

final class EditTaskInitial extends EditTaskState {}
final class EditTaskStartDateTimeChanged extends EditTaskState {}
final class EditTaskEndDateTimeChanged extends EditTaskState {}
final class EditTaskColorChanged extends EditTaskState {}
final class EditTaskRepeatedChanged extends EditTaskState {}
final class EditTaskReminderChanged extends EditTaskState {}