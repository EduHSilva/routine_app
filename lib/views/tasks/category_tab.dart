import 'package:flutter/material.dart';
import 'package:routineapp/models/task_model.dart';

class CategoryTab extends StatelessWidget {
  final Map<String, List<Task>>? tasksByDay;

  const CategoryTab({super.key, required this.tasksByDay});

  @override
  Widget build(BuildContext context) {
    if (tasksByDay == null || tasksByDay!.isEmpty) {
      return const Center(child: Text('No tasks available.'));
    }

    return ListView.builder(
      itemCount: tasksByDay!.length,
      itemBuilder: (context, index) {
        final dayKey = tasksByDay!.keys.elementAt(index);
        final tasks = tasksByDay![dayKey]!;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ExpansionTile(
            title: Text(dayKey),
            children: tasks.map((task) {
              return ListTile(
                title: Text(task.title),
                subtitle: Text(
                  'Start: ${task.startTime} | End: ${task.endTime}\n'
                  'Priority: ${task.priority} | Category: ${task.category}',
                ),
                isThreeLine: true,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
