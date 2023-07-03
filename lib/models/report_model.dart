import 'package:intl/intl.dart';

class Report {
  int? id;
  String? task;
  String? userName;
  String? dateOfService;
  String? timeOfService;
  int? status;

  Report(
      {this.id,
      this.task,
      this.userName,
      this.dateOfService,
      this.timeOfService,
      this.status});

  DateTime get parsedDateOfService {
    return DateTime.parse(dateOfService!);
  }

  DateTime? get parsedTimeOfService {
    if (timeOfService == null) return null;
    
    final timeFormat = DateFormat('HH:mm:ss');
    final parsedTime = timeFormat.parse(timeOfService!);
    
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      parsedTime.hour,
      parsedTime.minute,
      parsedTime.second,
    );
  }

}
