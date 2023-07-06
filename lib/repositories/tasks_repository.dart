// ignore_for_file: unnecessary_null_comparison

import 'package:municipal_cms/service/api_provider.dart';

import '../models/task_model_dio.dart';

class TasksRespository {
  void getTasks({
    required Function() beforeSend,
    required Function(Tasks tasks) onSuccess,
    required Function (dynamic error) onError,
    required String? token,
  }) {
    ApiClient(url: "/tasks", token: token).fetch(
        beforeSend: () => {if (beforeSend != null) beforeSend()},
        onSuccess: (data) {
          onSuccess(Tasks.fromJson(data));
        },
        onError: (error) => {if (onError != null) onError(error)});
  }

  void getTask({
    required Function() beforeSend,
    required Function(Task meter) onSuccess,
    required Function(dynamic error) onError,
    required String? token,
    required int taskId,
  }) {
    ApiClient(url: "/tasks/$taskId", token: token).fetch(
        beforeSend: () => {if (beforeSend != null) beforeSend()},
        onSuccess: (data) {
          onSuccess(Task.fromJson(data));
        },
        onError: (error) => {if (onError != null) onError(error)});
  }
}
