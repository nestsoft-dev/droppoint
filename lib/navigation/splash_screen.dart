import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp_one/navigation/pageview_page.dart';

import '../auth/register.dart';
import '../constants/constants.dart';
import 'bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Future.delayed(Duration(seconds: 4)).then(
      (value) {
       if(firebaseAuth.currentUser != null){
         Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
       }else{
         Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PageViewpage()));
       }
      },
    );

    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Icon(
          Icons.lock,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
