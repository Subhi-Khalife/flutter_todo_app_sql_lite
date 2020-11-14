import 'package:flutter/cupertino.dart';

class AddUpdateTodoProvider extends ChangeNotifier {
  TextEditingController titleTodoController;
  TextEditingController descriptionController;
  TextEditingController createAtController;
  int selectedCheckBox = -100;
  int todoId;
  void initData() {
    titleTodoController = new TextEditingController();
    descriptionController = new TextEditingController();
    createAtController = new TextEditingController();
    selectedCheckBox = -100;
  }

  setCreateAtController(String val) {
    createAtController.text = val;
    notifyListeners();
  }

  setDescriptionController(String val) {
    descriptionController.text = val;
    notifyListeners();
  }

  setTitleTodoController(String val) {
    titleTodoController.text = val;
    notifyListeners();
  }

  setTodoID(int id) {
    todoId = id;
    notifyListeners();
  }

  void changeSelectedCheckBox(int index) {
    if (index == selectedCheckBox)
      selectedCheckBox = -1;
    else
      selectedCheckBox = index;
    notifyListeners();
  }

  int getSelectedCheckBox() {
    return selectedCheckBox;
  }
}
