part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginValueEvent extends  LoginEvent{
  BuildContext context;
  LoginValueEvent({this.context});
  @override
  List<Object> get props => [];
}

class loginInit extends LoginEvent{
  @override
  List<Object> get props => [];

}