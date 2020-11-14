import 'dart:async';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_app/data_base/todo_info.dart';
import 'package:test_app/provider/add_update_todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/todo_list_item.dart';
import 'package:test_app/provider/user_global_variable_provider.dart';
import 'package:test_app/widget/show_message.dart';
import 'file:///D:/music/test_app/lib/data_base/database_operation/todo_data_base_operation.dart';
part 'add_new_todo_event.dart';
part 'add_new_todo_state.dart';

class AddNewTodoBloc extends Bloc<AddNewTodoEvent, AddNewTodoState> {
  AddNewTodoBloc() : super(AddNewTodoInitial());

  @override
  Stream<AddNewTodoState> mapEventToState(AddNewTodoEvent event) async* {
    if (event is AddNewTodoItemEvent) {
      AddUpdateTodoProvider addNewTodoProvider = Provider.of<AddUpdateTodoProvider>(event.context, listen: false);
      TodoListItemProvider todoListItemProvider = Provider.of<TodoListItemProvider>(event.context, listen: false);
      UserGlobalVariableProvider globalVariableProvider = Provider.of<UserGlobalVariableProvider>(event.context, listen: false);
      if (addNewTodoProvider.descriptionController.text.trim().isEmpty)
        showMessage("please enter the descriptoion", true);
      else if (addNewTodoProvider.titleTodoController.text.trim().isEmpty)
        showMessage("please enter the title", false);
      else {
        DateTime dateTime = DateTime.now();
        addNewTodoProvider.createAtController.text = DateFormat('yyyy/MM/dd').format(dateTime);
        TodoDatabaseOperation myDataBase = TodoDatabaseOperation();
        await myDataBase.userInfoDatBase();
        TodoInfo todoInfo = TodoInfo(
          userId:globalVariableProvider.userId,
          title: addNewTodoProvider.titleTodoController.text,
          description: addNewTodoProvider.descriptionController.text,
          createdAt: addNewTodoProvider.createAtController.text,
        );
        todoInfo.todoId=    await myDataBase.insertTodoInfo(todoInfo);
        todoListItemProvider.addItemToTodoList(todoInfo);
        Navigator.of(event.context).pop();
      }
    }

    if (event is UpdateTodoItemEvent) {
      AddUpdateTodoProvider addNewTodoProvider = Provider.of<AddUpdateTodoProvider>(event.context, listen: false);
      TodoListItemProvider todoListItemProvider =Provider.of<TodoListItemProvider>(event.context, listen: false);
      UserGlobalVariableProvider globalVariableProvider = Provider.of<UserGlobalVariableProvider>(event.context, listen: false);
      if (addNewTodoProvider.descriptionController.text.trim().isEmpty)
        showMessage("please enter the descriptoion", true);
      else if (addNewTodoProvider.titleTodoController.text.trim().isEmpty)
        showMessage("please enter the title", false);
      else {
        DateTime dateTime = DateTime.now();
        addNewTodoProvider.createAtController.text = DateFormat('yyyy/MM/dd').format(dateTime);
        TodoDatabaseOperation myDataBase = TodoDatabaseOperation();
        await myDataBase.userInfoDatBase();

        TodoInfo todoInfo = TodoInfo(
            userId: globalVariableProvider.userId,
            title: addNewTodoProvider.titleTodoController.text,
            description: addNewTodoProvider.descriptionController.text,
            createdAt: addNewTodoProvider.createAtController.text,
            todoId: addNewTodoProvider.todoId);

        await myDataBase.updateTodoInfo( todoInfo, globalVariableProvider.userId, todoInfo.todoId);


        todoListItemProvider.updateSelectedItem(addNewTodoProvider.selectedCheckBox,todoInfo);

        showMessage("update success",true);

        Navigator.of(event.context).pop();
      }
    }
  }
}
