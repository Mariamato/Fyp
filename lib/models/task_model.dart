
class Task {
  int? id;
  String? customerName;
  String? taskType;
  String? description;
  String? priority;
  String? dueDate;
  String? completedAt;
  String? location;

  Task({
    this.id,
    this.customerName,
    this.taskType,
    this.description,
    this.priority,
    this.dueDate,
    this.completedAt,
    this.location,
  });

  DateTime get parsedDueDate {
    return DateTime.parse(dueDate!);
  }
}
