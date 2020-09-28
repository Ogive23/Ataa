import 'package:flutter/material.dart';

Widget textField(controller,labelText, selectedColor,bool status, type,hint,[errorMessage]) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 10),
    child: TextField(
      maxLines: 3,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color.fromRGBO(255, 216, 3, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 1, color: Color.fromRGBO(255, 216, 3, 1)),
          gapPadding: 4,
        ),
        hintText: hint,
        errorText: errorMessage
      ),
      obscureText: status,
      keyboardType: type,
    ),
  );
}