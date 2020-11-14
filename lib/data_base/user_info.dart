import 'package:test_app/model/data_base_model.dart';

class UserInfo implements DataBaseModel {
  int id;
  String email;
  String password;

  UserInfo({this.password, this.email, this.id});

  UserInfo.fromMap(Map<String, dynamic> map) {
    this.id = map['user_id'];
    this.email = map['email'];
    this.password = map['password'];
  }

  @override
  String userTable() {
    return 'user_info';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'user_id':this.id,
      'email':this.email,
      'password':this.password
    };

  }

  @override
  String database() {
    return "user_info_db";
  }

  @override
  int getId() {
    return this.id;
  }

  @override
  String toString() {
    return "the id is :: $id the email is $email the pasword is $password";
  }

  @override
  String getUserEmail() {
    return email;
  }
}
