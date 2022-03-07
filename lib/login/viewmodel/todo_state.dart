
part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {
  TodoLoading();
}

class TodoCompleted extends TodoState {
  final List<TodoModel> todoList;
  TodoCompleted({required this.todoList});
}

class TodoError extends TodoState{
  final String response;
  TodoError(this.response);
}