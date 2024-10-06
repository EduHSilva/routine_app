import '../../config/app_config.dart';
import '../response.dart';

class Task {
  final String category;
  final String createAt;
  final String dateEnd;
  final String dateStart;
  final String endTime;
  final String frequency;
  final int id;
  final String priority;
  final String startTime;
  final String title;
  final String updateAt;
  final bool done;

  Task({
    required this.category,
    required this.createAt,
    required this.dateEnd,
    required this.dateStart,
    required this.endTime,
    required this.frequency,
    required this.id,
    required this.priority,
    required this.startTime,
    required this.title,
    required this.updateAt,
    this.done = false
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        category: json['category'],
        createAt: json['createAt'],
        dateEnd: json['date_end'],
        dateStart: json['date_start'],
        endTime: json['end_time'],
        frequency: json['frequency'],
        id: json['id'],
        priority: json['priority'],
        startTime: json['start_time'],
        title: json['title'],
        updateAt: json['updateAt'],
        done: json['done']
    );
  }
}

// "category_id": 0,
// "date_end": "string",
// "date_start": "string",
// "end_time": "string",
// "frequency": "string",
// "priority": "string",
// "start_time": "string",
// "title": "string",
// "user_id": 0
class CreateTaskRequest {
  final int userID = AppConfig.user!.id;
  final int categoryID;
  final String dateStart;
  final String dateEnd;
  final String frequency;
  final String priority;
  final String startTime;
  final String title;

  CreateTaskRequest({required this.title, required this.categoryID, required this.dateStart, required this.dateEnd, required this.frequency,
    required this.priority, required this.startTime});
}

class TaskResponse extends DefaultResponse {
  Task? task;

  TaskResponse({
    this.task,
    required super.message,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      task: Task?.fromJson(json['data']),
      message: json['message'],
    );
  }
}