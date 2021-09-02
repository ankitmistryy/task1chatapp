import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar();
}

InputDecoration textFeildDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white38,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle textStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.white,
  );
}

TextStyle textMStyle() {
  return TextStyle(
    fontSize: 17,
    color: Colors.white,
  );
}
