import 'package:flutter/material.dart';

my_decoration_textfield_style(String hint) => InputDecoration(
  hintText: hint,
  //fillColor: Color.fromRGBO(142, 142, 147, 1.2),
  fillColor: Colors.grey[200],
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: BorderSide.none
  ),
  contentPadding: EdgeInsets.only(top: 18, bottom: 18, left: 24, right: 24)
);