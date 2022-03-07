import 'package:bloc/bloc.dart';
import '../service/todo_service.dart';
import 'package:meta/meta.dart';
import '../model/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.service}) : super(TodoInitial()){
    getTodoData();
  }

  final ITodoService service;

  Future<void> getTodoData() async {
    try {
      emit(TodoLoading());
      final response=await service.getTodoData();
      emit(TodoCompleted(todoList:response));
    } catch (e) {
      emit(TodoError('API doesnt work'));
    }
  }
}
