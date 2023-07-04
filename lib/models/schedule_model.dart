import 'package:intl/intl.dart';

class Schedule {
  int? id;
  String? startTime;
  String? endTime;
  String? day;
  String? location;
  String? description;
  String? createdBy;

  Schedule({
    this.id,
    this.startTime,
    this.endTime,
    this.day,
    this.location,
    this.description,
    this.createdBy,
  });

  DateTime get parsedStartTime {
    if (startTime == null) return DateTime.now();

    final timeFormat = DateFormat('HH:mm:ss');
    final parsedTime = timeFormat.parse(startTime!);

    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      parsedTime.hour,
      parsedTime.minute,
      parsedTime.second,
    );
  }

  DateTime get parsedDate{
    return DateTime.parse(day!);
  }

  DateTime get parsedEndTime {
    if (endTime == null) return DateTime.now();

    final timeFormat = DateFormat('HH:mm:ss');
    final parsedTime = timeFormat.parse(endTime!);

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
