import 'package:flutter/material.dart';

import '../functions/firebase_fun.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  FirebaseFun firebaseFun = FirebaseFun();

  loginUser(String email, String password) async {
    await firebaseFun.loginUser(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
