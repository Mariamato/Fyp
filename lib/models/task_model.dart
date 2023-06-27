class Tasks {
  List<Task>? data;
  Meta? meta;
  String? status;
  String? message;
  int? statusCode;

  Tasks({this.data, this.meta, this.status, this.message, this.statusCode});

  Tasks.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Task>[];
      json['data'].forEach((v) {
        data!.add(new Task.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

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

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['name'];
    taskType = json['task_type'];
    description = json['description'];
    priority = json['priority'];
    dueDate = json['due_date'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.customerName;
    data['task_type'] = this.taskType;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['due_date'] = this.dueDate;
    data['completed_at'] = this.completedAt;

    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
