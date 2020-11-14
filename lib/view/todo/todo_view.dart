import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/data_base/todo_info.dart';
import 'package:test_app/provider/add_update_todo_provider.dart';
import 'package:test_app/provider/todo_list_item.dart';
import 'package:test_app/view/login/login_view.dart';
import 'package:test_app/view/todo/new_update_todo_item/new_update_todo_item_view.dart';
import 'package:test_app/widget/constant.dart';
import 'package:provider/provider.dart';
import 'package:test_app/widget/fontStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoView();
  }
}

class _TodoView extends State<TodoView> {
  AddUpdateTodoProvider addNewTodoProvider;
  TodoListItemProvider todoListItemProvider;
  @override
  void initState() {
    super.initState();
    addNewTodoProvider = Provider.of<AddUpdateTodoProvider>(context, listen: false);
    todoListItemProvider = Provider.of<TodoListItemProvider>(context, listen: false);
    addNewTodoProvider.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showFloatingActionButton(),
      appBar: showAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: showTitle("title", "description", "created time", -1,
                withCheckBox: false),
          ),
          Consumer<TodoListItemProvider>(
            builder: (_, values, __) {
              return Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: values.todoListItem.length,
                  itemBuilder: (context, index) {
                    return showTitle(
                        values.todoListItem[index].title,
                        values.todoListItem[index].description,
                        values.todoListItem[index].createdAt,
                        index,
                        withCheckBox: true);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget showAppBar() {
    return AppBar(
      actions: [
        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        IconButton(
          icon: Icon(Icons.backspace_outlined, color: Colors.white),
          onPressed: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setInt("user_id", -100);
            sharedPreferences.setBool("loginDone", false);
            todoListItemProvider.cleanTodoArray();

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginView()),
                (Route<dynamic> route) => false);
          },
        )
      ],
      backgroundColor: Constant.colorThemApp,
      title: Center(
        child: Text("Your ToDo Item List"),
      ),
    );
  }

  Widget showFloatingActionButton() {
    return Selector<AddUpdateTodoProvider, int>(
        selector: (_, values) => values.getSelectedCheckBox(),
        builder: (context, val, _) {
          return FloatingActionButton(
            onPressed: () {
              print("hello");
              if (val >= 0) {
                TodoInfo todoInfo = todoListItemProvider.todoListItem[val];
                addNewTodoProvider.setTodoID(todoInfo.todoId);
                addNewTodoProvider.setCreateAtController(todoInfo.createdAt);
                addNewTodoProvider.setDescriptionController(todoInfo.description);
                addNewTodoProvider.setTitleTodoController(todoInfo.title);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewTodoItemView(
                          isToDoValuesScreen: true,
                        )));
              } else
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewTodoItemView()));
            },
            heroTag: "1",
            child: (val < 0) ? Icon(Icons.add) : Icon(Icons.edit),
            backgroundColor: Constant.colorThemApp,
          );
        });
  }

  Widget showTitle(
    String first,
    String second,
    String third,
    int currentIndex, {
    bool withCheckBox = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  first,
                  style: boldStyle(
                      fontSize: Constant.verySmallFont, color: Colors.black),
                ),
              )),
          Spacer(),
          Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  second,
                  style: boldStyle(
                      fontSize: Constant.verySmallFont, color: Colors.black),
                ),
              )),
          Spacer(),
          Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  third,
                  style: boldStyle(
                      fontSize: Constant.verySmallFont, color: Colors.black),
                ),
              )),
          SizedBox(width: 5),
          Flexible(
              flex: 1,
              child: (withCheckBox) ? checkBox(currentIndex) : Container())
        ],
      ),
    );
  }

  Widget checkBox(int currentIndex) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
      child: Selector<AddUpdateTodoProvider, int>(
        selector: (_, values) => values.getSelectedCheckBox(),
        builder: (context, values, __) {
          return InkWell(
            onTap: () {
              addNewTodoProvider.changeSelectedCheckBox(currentIndex);
            },
            child: Center(
              child: Container(
                decoration: new BoxDecoration(
                  color: (values == currentIndex)
                      ? Constant.colorThemApp
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: 30,
                height: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
