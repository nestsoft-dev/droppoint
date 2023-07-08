import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'firebase_fun.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  FirebaseFun firebaseFun = FirebaseFun();
  Constants constants = Constants();
  String imagePath = '';

  Future<void> airtimePurchase(
      {required int networdId,
      required String phoneNumber,
      required double amount,
      required double currentBalance,
      required BuildContext context}) async {
    var request = await http.post(Uri.parse('uri'),
        body: jsonEncode({
          'networkid': networdId,
          'phoneNumber': phoneNumber,
          'amount': amount,
        }),
        headers: {'': '', '': ''}).then((value) async {
      if (value.statusCode == 200) {
        print('requuest was succesfull');
        await firebaseFun.debitUserAccount(currentBalance, amount);
        if (networdId == 0) {
          imagePath = constants.mtn;
        } else if (networdId == 1) {
          imagePath = constants.airtel;
        } else if (networdId == 2) {
          imagePath = constants.glo;
        } else {
          imagePath = constants.nineMobile;
        }
        await firebaseFun.uploadhistory(
            'Airtime Purchase',
            'You have purchased airtime of $amount for $phoneNumber',
            imagePath,
            amount,
            true,
            "${Timestamp.now()}",
            context);
      } else {
        await firebaseFun.uploadhistory(
            'Airtime Purchase Failed',
            'Your purchased for airtime of $amount for $phoneNumber failed',
            imagePath,
            amount,
            true,
            "${Timestamp.now()}",
            context);
        print('something went wrong');
      }
    });
  }

  Future<void> dataPlan(
      {required int networkId,
      required double planAmount,
      required String phoneNumber,
      required double currenBalance,
      required BuildContext context}) async {
    var request = await http.post(Uri.parse('uri'),
        body: jsonEncode({
          'networkid': networkId,
          'phoneNumber': phoneNumber,
          'amount': planAmount,
        }),
        headers: {'': '', '': ''}).then((value) async {
      if (value.statusCode == 200) {
        print('request was succesfull');
        await firebaseFun.debitUserAccount(currenBalance, planAmount);
        if (networkId == 0) {
          imagePath = constants.mtn;
        } else if (networkId == 1) {
          imagePath = constants.airtel;
        } else if (networkId == 2) {
          imagePath = constants.glo;
        } else {
          imagePath = constants.nineMobile;
        }
        await firebaseFun.uploadhistory(
            'Airtime Purchase',
            'You have purchased airtime of $planAmount for $phoneNumber',
            imagePath,
            planAmount,
            true,
            "${Timestamp.now()}",
            context);
      } else {
        await firebaseFun.uploadhistory(
            'Airtime Purchase Failed',
            'Your purchased for airtime of $planAmount for $phoneNumber failed',
            imagePath,
            planAmount,
            true,
            "${Timestamp.now()}",
            context);
        print('something went wrong');
      }
    });
  }

  Future<void> electricSub() async {}

  Future<void> schoolSub() async {}

  Future<void> televisionSub() async {}

  Future<List<Map<String, dynamic>>> getPlanList(
      {required int networkId, required BuildContext context}) async {
    List<Map<String, dynamic>> planList = [];

    return planList;
  }

  Future<void> validateCable({required int cableId,required String cableNumber,required BuildContext context}) async{
    
  }
}
