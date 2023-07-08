import 'package:flutter/material.dart';

class ExamPin extends StatefulWidget {
  const ExamPin({super.key});

  @override
  State<ExamPin> createState() => _ExamPinState();
}

class _ExamPinState extends State<ExamPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Purchase Exam pins',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
    );
  }
}