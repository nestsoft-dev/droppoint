import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  MyTextInput({
    super.key,
    required this.textEditingController,
    required this.hint,
    required this.textInputType,
    required this.ispassword,
    required this.maxlength,
  });
  TextEditingController textEditingController;
  String hint;
  TextInputType textInputType;
  bool ispassword;
  int maxlength;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        keyboardType: textInputType,
        obscureText: ispassword,
        style: TextStyle(color: Colors.black),
        controller: textEditingController,
        maxLength: maxlength,
        decoration: InputDecoration(
          labelText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Color.fromARGB(138, 252, 232, 232),
          filled: true,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
