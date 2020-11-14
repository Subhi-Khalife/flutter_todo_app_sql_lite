import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/widget/constant.dart';
showMessage(String msg , bool isError) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor:isError ? Constant.grayColor: Constant.colorThemApp,
      textColor: Colors.white,
      fontSize: 16.0);
}