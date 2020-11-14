part of 'add_new_todo_bloc.dart';

abstract class AddNewTodoEvent extends Equatable {
  const AddNewTodoEvent();
}

class AddNewTodoItemEvent extends AddNewTodoEvent{
  BuildContext context;
  AddNewTodoItemEvent({this.context});
  @override
  List<Object> get props => [];
}

class UpdateTodoItemEvent extends AddNewTodoEvent{
  BuildContext context;
  UpdateTodoItemEvent({this.context});
  @override
  List<Object> get props => [];
}

class initTodoEvent extends AddNewTodoEvent{
  @override
  List<Object> get props =>[];

}
