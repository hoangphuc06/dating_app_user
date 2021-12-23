import 'package:flutter/material.dart';

Widget TagButton(func, bool isActive, String labelText) {
  return ButtonTheme(
    minWidth: 80,
    height: 30,
    child: RaisedButton(
      onPressed: func,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        //side: BorderSide(color: orange)
      ),
      color: isActive ? Colors.deepPurple : Colors.grey.withOpacity(0.2),
      elevation: 0.5,
      child: Text(
        labelText,
        style: TextStyle(
            fontSize: 15
        ),
      ),
    ),
  );
}