import 'package:flutter/cupertino.dart';

class LoginAndSignupProvider extends ChangeNotifier {

  TextEditingController emailController ;

  TextEditingController passwordController ;

  TextEditingController confirmPasswordController ;


  bool showPassword = false;

  bool showConfirmPassword=false;

  initializationValues(){
    emailController= TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController=TextEditingController();
    showPassword = false;
  }

  setShowPasswordValue() {
    showPassword = !showPassword;
    notifyListeners();
  }

  setShowConfirmPasswordValue() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  setPhoneController(String value) {
    emailController.text = value;
    notifyListeners();
  }

  setEmailController(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  String get getPhoneController => passwordController.text;

  String get getEmailController => emailController.text;

  bool get getShowPassword => showPassword;

  bool get getConfirmShowPassword => showConfirmPassword;


}

