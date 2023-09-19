import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Cubits/task_cubit/task_cubit.dart';
import 'package:to_do/Models/config.dart';
import '../Models/task.dart';

@immutable
class TaskWidget extends StatefulWidget {
  const TaskWidget({required this.task, super.key});
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  // with SingleTickerProviderStateMixin {
  // late AnimationController animationController;
  // late Animation<AlignmentGeometry> animation;

  // @override
  // void initState() {
  //   super.initState();
  //   animationController =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
  //   animation = Tween(
  //           begin: AlignmentDirectional.centerEnd,
  //           end: AlignmentDirectional.centerEnd)
  //       .animate(
  //     CurvedAnimation(parent: animationController, curve: Curves.linear),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${widget.task.id}'),
      onDismissed: (direction) =>
          BlocProvider.of<TaskCubit>(context).deleteTasks(widget.task.id),
      direction: DismissDirection.horizontal,
      background: const SizedBox(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      secondaryBackground: const SizedBox(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/task_info', arguments: widget.task),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.task.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _upperSection(),
              SizedBox(height: SizeConfig.heightBlock),
              _bottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Row _upperSection() {
    return Row(
      children: [
        Checkbox(
          value: widget.task.isFinished,
          onChanged: (value) {
            setState(() {
              widget.task.isFinished = !widget.task.isFinished;
              // BlocProvider.of<TaskCubit>(context)
              //     .deleteTasks(widget.task.id);
            });
          },
          fillColor: MaterialStateProperty.all(Colors.transparent),
          side: const BorderSide(
              color: Colors.white, width: 1.5, style: BorderStyle.solid),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
        ),
        Expanded(
          child: Hero(
            tag: '${widget.task.id}',
            child: Text(
              widget.task.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Row _bottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(
              width: SizeConfig.widthBlock,
            ),
            (widget.task.endDate != null &&
                    DateTime.now().compareTo(widget.task.startTime) >= 0)
                ? Text(
                    DateFormat('d/M/y').format(widget.task.endDate!),
                    style: const TextStyle(color: Colors.white),
                  )
                : Text(
                    DateFormat('d/M/y').format(widget.task.date),
                    style: const TextStyle(color: Colors.white),
                  )
          ],
        ),
        if (widget.task.note != '')
          const Icon(
            Icons.notes_rounded,
            color: Colors.white,
            size: 16,
          ),
        if (widget.task.repeat != 'none')
          const Icon(
            Icons.repeat_outlined,
            color: Colors.white,
            size: 16,
          ),
        Row(
          children: [
            const Icon(
              Icons.access_time,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(
              width: SizeConfig.widthBlock,
            ),
            (widget.task.endtTime != null &&
                    DateTime.now().compareTo(widget.task.startTime) >= 0)
                ? Text(
                    DateFormat('h:m a').format(widget.task.endtTime!),
                    style: const TextStyle(color: Colors.white),
                  )
                : Text(
                    DateFormat('h:m a').format(widget.task.startTime),
                    style: const TextStyle(color: Colors.white),
                  )
          ],
        ),
      ],
    );
  }

  // @override
  // void dispose(){
  //   super.dispose();
  //   animationController.dispose();
  // }
}
