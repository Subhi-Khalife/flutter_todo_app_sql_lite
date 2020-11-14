import 'package:flutter/cupertino.dart';

regularStyle({@required double fontSize, @required Color color}){
  return TextStyle(fontSize: fontSize,color: color,letterSpacing: 0.5);
}

boldStyle({@required double fontSize, @required Color color}){
  return TextStyle(fontSize: fontSize,color: color,fontWeight: FontWeight.bold,letterSpacing: 0.5);
}