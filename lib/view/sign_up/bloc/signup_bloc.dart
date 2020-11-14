import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/music/test_app/lib/data_base/database_operation/user_data_base_operation.dart';
import 'package:test_app/data_base/user_info.dart';
import 'package:test_app/provider/login_and_signup_provider.dart';
import 'package:test_app/provider/todo_list_item.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/user_global_variable_provider.dart';
import 'package:test_app/view/todo/todo_view.dart';
import 'package:test_app/widget/show_message.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is AddUserEvent) {
      UserDataBaseOperation myDataBase = UserDataBaseOperation();
      LoginAndSignupProvider loginAndSignupProvider =
          Provider.of<LoginAndSignupProvider>(event.context, listen: false);
      UserGlobalVariableProvider globalVariableProvider =
          Provider.of<UserGlobalVariableProvider>(event.context, listen: false);
      if (loginAndSignupProvider.emailController.text.trim().isEmpty)
        showMessage("Please enter your email", true);
      else if (loginAndSignupProvider.passwordController.text.trim().isEmpty)
        showMessage("Please enter your password", true);
      else if (loginAndSignupProvider.confirmPasswordController.text
          .trim()
          .isEmpty)
        showMessage("Please enter your confirm password", true);
      else if (loginAndSignupProvider.passwordController.text.trim() !=
          loginAndSignupProvider.confirmPasswordController.text.trim()) {
        showMessage("Password and confirm not same", true);
      } else {
        bool userContain = await myDataBase.checkUserContain(
            UserInfo().userTable(),
            loginAndSignupProvider.emailController.text);
        if (userContain)
          showMessage("This account is found", false);
        else {
          showMessage("add Account success", false);

          int userId = await myDataBase.insertUser(UserInfo(
              password:loginAndSignupProvider.confirmPasswordController.text.trim(),
              email: loginAndSignupProvider.emailController.text.trim()));
          globalVariableProvider.setUserIdValues(userId);
          globalVariableProvider.setLoginIsDone(true);
          Navigator.of(event.context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => TodoView()),
              (Route<dynamic> route) => false);
        }
      }
    }
  }
}
