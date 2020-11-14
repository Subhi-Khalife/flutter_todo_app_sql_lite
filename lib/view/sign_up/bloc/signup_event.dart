part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}


class AddUserEvent extends SignupEvent{
  BuildContext context;
  AddUserEvent({this.context});
  @override
  List<Object> get props => [];

}

class SignUpInitEvent extends SignupEvent{
  @override
  List<Object> get props => [];

}