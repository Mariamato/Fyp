class Task {
  int? id;
  String? customerName;
  String? taskType;
  String? description;
  String? priority;
  String? dueDate;
  String? completedAt;

  Task({
    this.id,
    this.customerName,
    this.taskType,
    this.description,
    this.priority,
    this.dueDate,
    this.completedAt,
  });

  DateTime get parsedDueDate {
    return DateTime.parse(dueDate!);
  }
}
