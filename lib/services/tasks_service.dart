import 'package:routineapp/config/app_config.dart';
import 'package:routineapp/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TasksService {
  Future<Map<String, List<Task>>> getWeekTasks() async {
    http.Client client = await AppConfig.getHttpClient();
    final response = await client.get(Uri.parse('${AppConfig.apiUrl}tasks/week?currentDate=${DateTime.now()}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      Map<String, List<Task>> tasksByDay = {};

      data['data'].forEach((key, value) {
        if (value['tasks'] != null) {
          tasksByDay[key] = (value['tasks'] as List).map((taskJson) {
            return Task.fromJson(taskJson);
          }).toList();
        }
      });

      return tasksByDay;
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
