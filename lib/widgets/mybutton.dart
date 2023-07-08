import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    required this.isLoading,
    required this.text,
    required this.onTap,
  });
  bool isLoading;
  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      ),
    );
  }
}
