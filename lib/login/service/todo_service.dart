import 'dart:io';

import 'package:dio/dio.dart';

import '../model/todo_model.dart';

abstract class ITodoService {
  final Dio dio;

  ITodoService(this.dio);
  final todopath = ITodoServicePath.todo.rawValue;

  Future<List<TodoModel>> getTodoData();
}

class TodoService extends ITodoService {
  TodoService(Dio dio) : super(dio);

  @override
  Future<List<TodoModel>> getTodoData() async {
    try {
      final response = await dio.get(todopath);
      List<TodoModel> _todolist = [];
      if (response.statusCode == HttpStatus.ok) {
        _todolist =
            (response.data as List).map((e) => TodoModel.fromJson(e)).toList();
      }
      return _todolist;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}

enum ITodoServicePath { todo }

extension ITodoServicePAthExtension on ITodoServicePath {
  String get rawValue {
    switch (this) {
      case ITodoServicePath.todo:
        return '/todos';
    }
  }
}
