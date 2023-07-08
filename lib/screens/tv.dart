import 'package:flutter/material.dart';

class TvSub extends StatefulWidget {
  const TvSub({super.key});

  @override
  State<TvSub> createState() => _TvSubState();
}

class _TvSubState extends State<TvSub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Purchase Cable Subscription',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
    );
  }
}
