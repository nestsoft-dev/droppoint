import 'package:flutter/material.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Claim free discounts',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
