import 'package:routineapp/models/tasks/task_model.dart';
import 'package:routineapp/services/tasks_service.dart';

class TasksViewModel {
  final TasksService _tasksService = TasksService();

  Future<Map<String, List<Task>>?> getWeekTasks() async {
    return await _tasksService.getWeekTasks();
  }

  Future<TaskResponse?> deleteRule(int id) async {
    // TODO
    return null;
  }

  Future<List<Task>> getRules() async {
    List<Task> response = await _tasksService.getRules();

    return response;
  }

  Future<Task>? addRule(CreateTaskRequest task) {
    return null;
  }
}
