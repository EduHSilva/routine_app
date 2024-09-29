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
    required this.done
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
