import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/provider/login_and_signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/todo_list_item.dart';
import 'file:///D:/music/test_app/lib/view/sign_up/signup_view.dart';
import 'package:test_app/widget/TextFieldApp.dart';
import 'package:test_app/widget/constant.dart';
import 'package:test_app/widget/fontStyle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/view/login/bloc/login_bloc.dart';
class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginView();
  }
}

class _LoginView extends State<LoginView> {
  LoginAndSignupProvider _loginProvider;
  @override
  void initState() {
    super.initState();
    _loginProvider =
        Provider.of<LoginAndSignupProvider>(context, listen: false);
    _loginProvider.initializationValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: Column(
        children: [
          space(),
          emailTextFields(),
          space(),
          passwordTextFields(),
          space(),
          appButton(),
          space(),
          signUpText(),
        ],
      ),
    );
  }

  Widget signUpText() {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignUpView()),
              (Route<dynamic> route) => false);
        },
        child: Text(
          "Go to Sign up screen",
          style: boldStyle(fontSize: Constant.smallFont, color: Colors.black),
        ));
  }

  Widget appButton() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          BlocProvider.of<LoginBloc>(context)..add(LoginValueEvent(context: context));

        },
        child: Text(" Sign in "),
      ),
    );
  }

  Widget showAppBar() {
    return AppBar(
      backgroundColor: Constant.colorThemApp,
      title: Center(
        child: Text(
          "Login View Screen",
          style: boldStyle(fontSize: Constant.mediumFont, color: Colors.white),
        ),
      ),
    );
  }

  Widget space() {
    return SizedBox(
      height: 30,
    );
  }

  Widget passwordTextFields() {
    return Selector<LoginAndSignupProvider, bool>(
      selector: (context, getShowPassword) => getShowPassword.getShowPassword,
      builder: (context, value, _) {
        return TextFieldApp(
          controller: _loginProvider.passwordController,
          isTextFieldPassword: true,
          isLookAtPassword: value,
          onPressedLookAtPassword: () {
            _loginProvider.setShowPasswordValue();
          },
          hintText: "Password",
          maxLines: 1,
          filled: true,
          withIcon: true,
          icon: Icons.arrow_back_ios_outlined,
          suffixIcon: Icon(Icons.email),
        );
      },
    );
  }

  Widget emailTextFields() {
    return TextFieldApp(
      controller: _loginProvider.emailController,
      isTextFieldPassword: false,
      isLookAtPassword: false,
      hintText: "email",
      maxLines: 1,
      filled: true,
      withIcon: true,
      icon: Icons.arrow_back_ios_outlined,
      textInputType: TextInputType.emailAddress,
      suffixIcon: Icon(
        Icons.email,
        color: Constant.grayColor,
      ),
    );
  }
}
