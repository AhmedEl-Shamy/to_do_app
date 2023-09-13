import 'package:flutter/material.dart';
import 'package:to_do/Models/config.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameC = TextEditingController();
    TextEditingController noteC = TextEditingController();
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Container(
        width: SizeConfig.widthBlock * 80,
        height: SizeConfig.heightBlock * 60,
        child: Column(
          children: [
            addTaskTextField(label: 'Name' ,controller: nameC, context:context),
            addTaskTextField(label: 'Note' ,controller: noteC, context:context),
            
          ],
        ),
      ),
      actions: [
        FilledButton(
            onPressed: Navigator.of(context).pop, child: Text('Cancel')),
        FilledButton(
            onPressed: Navigator.of(context).pop, child: Text('Add Task')),
      ],
    );
  }

  TextField addTaskTextField({
    required label,
    required TextEditingController controller,
    required BuildContext context,
  }) =>
      TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter Task $label',
          contentPadding: const EdgeInsets.all(8),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2),
          ),
        ),
      );
}
