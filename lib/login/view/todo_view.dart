import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cubit_/login/service/todo_service.dart';
import 'package:app_cubit_/login/viewmodel/todo_cubit.dart';

class BlocCatsView extends StatefulWidget {
  @override
  _BlocCatsViewState createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(
          service: TodoService(Dio(
              BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com')))),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("To do List"),
        ),
        body: BlocConsumer<TodoCubit, TodoState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TodoInitial) {
              return buildCenterInitialChild(context);
            } else if (state is TodoLoading) {
              return buildCenterLoading();
            } else if (state is TodoCompleted) {
              return buildListViewCats(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Text buildError(TodoState state) {
    final error = state as TodoError;
    return Text(error.response);
  }

  ListView buildListViewCats(TodoCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        color: Colors.lightBlue[100],
        child: ListTile(
            title: Text(state.todoList[index].title.toString()),
            subtitle: Text(
                'Complete status: ${state.todoList[index].completed.toString()}'),
            leading: const Icon(Icons.list_alt_outlined)),
      ),
      itemCount: state.todoList.length,
    );
  }

  Center buildCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildCenterInitialChild(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
