import 'package:flutter/cupertino.dart';

class UserGlobalVariableProvider extends ChangeNotifier{

  int userId;

  bool loginDone;

  setUserIdValues(int id)
  {
    userId=id;
    notifyListeners();

  }

  setLoginIsDone(bool val){
    loginDone=val;
    notifyListeners();
  }
}