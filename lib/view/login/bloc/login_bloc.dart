import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/data_base/todo_info.dart';
import 'file:///D:/music/test_app/lib/data_base/database_operation/user_data_base_operation.dart';
import 'package:test_app/data_base/user_info.dart';
import 'package:test_app/provider/login_and_signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/todo_list_item.dart';
import 'package:test_app/provider/user_global_variable_provider.dart';
import 'package:test_app/view/todo/todo_view.dart';
import 'package:test_app/data_base/database_operation/todo_data_base_operation.dart';
import 'package:test_app/widget/show_message.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginValueEvent) {
      UserDataBaseOperation myDataBase = UserDataBaseOperation();

      LoginAndSignupProvider loginAndSignupProvider =
          Provider.of<LoginAndSignupProvider>(event.context, listen: false);

      if (loginAndSignupProvider.emailController.text.trim().isEmpty)
        showMessage("Please enter your email", true);
      else if (loginAndSignupProvider.passwordController.text.trim().isEmpty)
        showMessage("Please enter your password", true);
      else {
        int userContain = await myDataBase.checkUserLogin(
          UserInfo().userTable(),
          loginAndSignupProvider.emailController.text,
          loginAndSignupProvider.passwordController.text,
        );

        if (userContain == 0)
          showMessage("email or password not correct", false);
        else {
          showMessage("login success", false);
          UserGlobalVariableProvider globalVariableProvider =
          Provider.of<UserGlobalVariableProvider>(event.context, listen: false);
          TodoListItemProvider todoListItemProvider =
              Provider.of<TodoListItemProvider>(event.context, listen: false);

          globalVariableProvider.setUserIdValues(userContain);

          TodoDatabaseOperation todoDatabaseOperation = TodoDatabaseOperation();

          await todoDatabaseOperation.userInfoDatBase();

          todoListItemProvider.todoListItem = await todoDatabaseOperation.getAllPost(TodoInfo().userTable(), userContain);
          Navigator.of(event.context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => TodoView()),
              (Route<dynamic> route) => false);
        }
      }
    }
  }
}
