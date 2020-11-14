part of 'add_new_todo_bloc.dart';

abstract class AddNewTodoState extends Equatable {
  const AddNewTodoState();
}

class AddNewTodoInitial extends AddNewTodoState {
  @override
  List<Object> get props => [];
}
