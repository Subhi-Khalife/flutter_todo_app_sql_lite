import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/provider/login_and_signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_app/view/login/login_view.dart';
import 'package:test_app/view/sign_up/bloc/signup_bloc.dart';
import 'package:test_app/widget/TextFieldApp.dart';
import 'package:test_app/widget/constant.dart';
import 'package:test_app/widget/fontStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpView();
  }
}

class _SignUpView extends State<SignUpView> {
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
      body: Padding(
        padding:  EdgeInsets.only(left: 9,right: 9),
        child: Column(
          children: [
            space(),
            emailTextFields(),
            space(),
            passwordTextFields(),
            space(),
            confirmPasswordTextFields(),
            space(),
            appButton(),
            space(),
            signUpText(),
          ],
        ),
      ),
    );
  }

  Widget signUpText() {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginView()),
              (Route<dynamic> route) => false);
        },
        child: Text(
          "Go to Login screen",
          style: boldStyle(fontSize: Constant.smallFont, color: Colors.black),
        ));
  }

  Widget appButton() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          BlocProvider.of<SignupBloc>(context)..add(AddUserEvent(context: context));
        },
        child: Text(" Sign Up "),
      ),
    );
  }

  Widget showAppBar() {
    return AppBar(
      backgroundColor: Constant.colorThemApp,
      title: Center(
        child: Text(
          "Sign up View Screen",
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

  Widget confirmPasswordTextFields() {
    return Selector<LoginAndSignupProvider, bool>(
      selector: (context, getShowPassword) =>
          getShowPassword.getConfirmShowPassword,
      builder: (context, value, _) {
        return TextFieldApp(
          controller: _loginProvider.confirmPasswordController,
          isTextFieldPassword: true,
          isLookAtPassword: value,
          onPressedLookAtPassword: () {
            _loginProvider.setShowConfirmPasswordValue();
          },
          hintText: "Confirm Password",
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
