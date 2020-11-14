import 'package:test_app/model/data_base_model.dart';

class TodoInfo implements DataBaseModel {

  String title;
  String description;
  String createdAt;
  int userId;
  int todoId;
  TodoInfo({this.title,this.createdAt,this.description,this.userId,this.todoId});

  TodoInfo.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.description = map['description'];
    this.createdAt = map['created_time'];
    this.userId=map['user_id'];
    this.todoId=map['todo_id'];
  }

  @override
  String database() {
    throw UnimplementedError();
  }

  @override
  int getId() {
    return this.todoId;
  }

  @override
  String getUserEmail() {
    throw UnimplementedError();
  }
  @override
  Map<String, dynamic> toMap() {

    return {
      'title':this.title,
      'description':this.description,
      'created_time':this.createdAt,
      'user_id':this.userId,
    };
  }
  @override
  String userTable() {
    return "user_todo_info";
  }


}