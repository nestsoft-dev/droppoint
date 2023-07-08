import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp_one/auth/login.dart';
import '../navigation/bottom_nav.dart';

class FirebaseFun {
  FirebaseAuth firebase = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> register(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebase
          .createUserWithEmailAndPassword(email: email, password: password);
      const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      final random = Random();
      final randomIndex = random.nextInt(chars.length);
      // final codeUnit = List.generate(8, (index) {
      //   final randomIndex = random.nextInt(chars.length);
      // });
      await firestore.collection('users').doc(firebase.currentUser!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'balance': 00.0,
        'points': 00.0,
        'reseller': false,
        'totalTransaction': 0,
        'referralCode': randomIndex,
        'pin': '',
        'pinset': false,
      });
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Your Account creation was successful",
          title: "Account created");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNav()));

      // await firebase.
      return userCredential;
    } on FirebaseAuthException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    } on SocketException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    } catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAcct(BuildContext context) async {
    await firestore.collection('users').doc(firebase.currentUser!.uid).delete();
    await firebase.currentUser!.delete();
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Account Deleted",
        title: "Your account was deleted");
  }

  Future<void> forgetPasswoord(String email, BuildContext context) async {
    try {
      await firebase.sendPasswordResetEmail(email: email);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: 'Password Reset',
          title: "Password reset email was sent to $email");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    } catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    }
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      await firebase.signInWithEmailAndPassword(
          email: email, password: password);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Login success',
          title: "Login was a success!");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseAuthException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    } on SocketException catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    } catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: e.toString(),
          title: "Something went wrong");
      throw Exception(e.toString());
    }
  }

  Future<void> uploadhistory(String title, String desc, String imagePath,
      double amount, bool isDebit, String time, BuildContext context) async {
    try {
       // .collection(firebase.currentUser!.uid)
      await firestore
          .collection('history')
          .doc(firebase.currentUser!.uid)
          .set({
        'title': title,
        'des': desc,
        'imagePath': imagePath,
        'amount': amount,
        'time': time,
        'isDebit': isDebit,
      }).whenComplete(() {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 15,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$desc',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Done'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            });
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getHistory() async {
    var history = await firestore
        .collection('history')
        .doc(firebase.currentUser!.uid)
        .collection('MyHistory')
        .orderBy(
          'time',
          descending: true,
        )
        .get();
    return history;
  }

  Future<void> debitUserAccount(double balance, double debitAmount) async {
    double cal = balance - debitAmount;
    await firestore
        .collection('users')
        .doc(firebase.currentUser!.uid)
        .update({'balance': cal});
  }

  Future<void> creditUserAccount(double balance, double creditAmount) async {
    double cal = balance + creditAmount;
    await firestore
        .collection('users')
        .doc(firebase.currentUser!.uid)
        .update({'balance': cal});
  }
}
