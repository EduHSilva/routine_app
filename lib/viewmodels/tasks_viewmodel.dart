import 'package:routineapp/models/task_model.dart';
import 'package:routineapp/services/tasks_service.dart';

class TasksViewmodel {
  final TasksService _tasksService = TasksService();

  Future<Map<String, List<Task>>?> getWeekTasks() async {
    return await _tasksService.getWeekTasks();
  }
}
