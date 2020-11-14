import 'package:flutter/cupertino.dart';
import 'package:test_app/data_base/todo_info.dart';

class TodoListItemProvider extends ChangeNotifier{

  List<TodoInfo> todoListItem =List<TodoInfo>();

  addItemToTodoList(TodoInfo item){
    todoListItem.add(item);
    notifyListeners();
  }

  void cleanTodoArray()
  {
    print("Theheh");
    todoListItem.clear();
    notifyListeners();
  }
  List<TodoInfo> getTodoItemList(){
    return todoListItem;
  }

  void updateSelectedItem(int index,TodoInfo todoInfo){
    todoListItem[index]=todoInfo;
    notifyListeners();
  }
}