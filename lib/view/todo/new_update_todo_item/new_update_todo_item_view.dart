import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/provider/add_update_todo_provider.dart';
import 'package:test_app/widget/TextFieldApp.dart';
import 'package:test_app/widget/constant.dart';
import 'package:test_app/widget/fontStyle.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_new_todo_bloc.dart';

class NewTodoItemView extends StatefulWidget {
  bool isToDoValuesScreen;
  NewTodoItemView({this.isToDoValuesScreen = false});
  @override
  State<StatefulWidget> createState() {
    return _NewTodoItemView();
  }
}

class _NewTodoItemView extends State<NewTodoItemView> {
  AddUpdateTodoProvider addNewTodoProvider;
  @override
  void initState() {
    super.initState();
    addNewTodoProvider =
        Provider.of<AddUpdateTodoProvider>(context, listen: false);
    if (widget.isToDoValuesScreen == false) addNewTodoProvider.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          space(),
          space(),
          showTitle(),
          space(),
          showAddTitle(),
          space(),
          showAddDescription(),
          space(),
          showButton(),
        ],
      ),
    );
  }

  Widget space() {
    return SizedBox(
      height: 20,
    );
  }

  Widget showButton() {
    return Padding(
      padding:  EdgeInsets.only(top: 14,left: 18,right: 18),
      child: MaterialButton(
        color: Colors.white12,
        onPressed: () {
          if (widget.isToDoValuesScreen == false)
            BlocProvider.of<AddNewTodoBloc>(context)..add(AddNewTodoItemEvent(context: context));
          else {
            BlocProvider.of<AddNewTodoBloc>(context)..add(UpdateTodoItemEvent(context: context));
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              (widget.isToDoValuesScreen) ? "Update Todo Values" : " Add New Todo ",
              style:
                  boldStyle(fontSize: Constant.mediumFont, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget showAddDescription() {
    return Padding(
      padding:  EdgeInsets.only(left: 9,right: 9),
      child: TextFieldApp(
        controller: addNewTodoProvider.descriptionController,
        isTextFieldPassword: false,
        paddingLeft: 10,
        withIcon: false,
        isLookAtPassword: false,
        filled: true,
        withBottomBlackLine: false,
        hintText: "Add description",
      ),
    );
  }

  Widget showAddTitle() {
    return Padding(
      padding:  EdgeInsets.only(left: 9,right: 9),
      child: TextFieldApp(
        controller: addNewTodoProvider.titleTodoController,
        isTextFieldPassword: false,
        withIcon: false,
        paddingLeft: 10,
        withBottomBlackLine: false,
        hintText: "Add title",
        isLookAtPassword: false,
        filled: true,
      ),
    );
  }

  Widget showTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          (widget.isToDoValuesScreen) ? "Update Todo Values" : " Add New Todo ",
          style: boldStyle(
              fontSize: Constant.mediumFont, color: Constant.colorThemApp),
        ),
      ),
    );
  }
}
