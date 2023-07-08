import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/http_helper.dart';
import '../widgets/textinput.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  double balance = 0;
  bool isLoading = false;
  
  bool setallData = true;
  String name = '';
  String showMoney = '';
  double money = 00.0;
  getMyData() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var db = FirebaseFirestore.instance;
    final docRef =
        await db.collection("users").doc(firebaseAuth.currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          setallData = false;
          name = '${data["name"]}';
          //points = data["points"];
          money = double.parse(data['balance']);
          showMoney = money.toStringAsFixed(2);
          setState(() {
            setallData = false;
          });

          print("HomePage Name: $name, balance ");

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {}
  }

  Future<void> getUserBalance() async {}

  @override
  void initState() {
    super.initState();
    getMyData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumber.dispose();
    amount.dispose();
  }

  bool selected = false;
  List<String> images = [
    'assets/mtnlogo.jpg',
    'assets/airtel.png',
    'assets/glo.png',
    'assets/9mobile.png',
  ];

  int selectedChipIndex = 0;
  List<String> label = [
    'MTN',
    'Airtel',
    'Glo',
    '9Mobile',
  ];

  void selectChip(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  HttpHelper httpHelper = HttpHelper();

  Future<void> purchaseAirtime(
      double amount, double balance, String phoneNumber) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Purchase Airtime',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 0),
            child:
                Row(children: [Text('Please Select the network for airtime')]),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(
              spacing: 8.0,
              children: [
                ChoiceChip(
                  selectedColor: Colors.green,
                  label: Text('MTN'),
                  avatar: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/mtnlogo.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  selected: selectedChipIndex == 0,
                  onSelected: (isSelected) {
                    selectChip(0);
                  },
                ),
                ChoiceChip(
                  selectedColor: Colors.green,
                  avatar: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/airtel.png'),
                            fit: BoxFit.cover)),
                  ),
                  label: Text('AIRTEL'),
                  selected: selectedChipIndex == 1,
                  onSelected: (isSelected) {
                    selectChip(1);
                  },
                ),
                ChoiceChip(
                  selectedColor: Colors.green,
                  avatar: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/glo.png'),
                            fit: BoxFit.cover)),
                  ),
                  label: Text('GLO'),
                  selected: selectedChipIndex == 2,
                  onSelected: (isSelected) {
                    selectChip(2);
                  },
                ),
                ChoiceChip(
                  avatar: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/9mobile.png'),
                            fit: BoxFit.cover)),
                  ),
                  label: Text('9MOBILE'),
                  selectedColor: Colors.green,
                  selected: selectedChipIndex == 3,
                  onSelected: (isSelected) {
                    selectChip(3);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          //TODO: dropdown button here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyTextInput(
              textEditingController: amount,
              hint: 'Enter Airtime Amount',
              textInputType: TextInputType.number,
              ispassword: false,
              maxlength: 4,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyTextInput(
              textEditingController: phoneNumber,
              hint: 'Enter phone number',
              textInputType: TextInputType.number,
              ispassword: false,
              maxlength: 11,
            ),
          ),
          SizedBox(
            height: 15,
          ),

          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : GestureDetector(
            onTap: () async {
              if (amount.text == '' || phoneNumber.text == '') {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: "Please check inputs",
                );
              } else if (double.parse(amount.text) > money) {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: "Low balance",
                );
              } else {
                setState(() {
                  isLoading = true;
                });
                await httpHelper.airtimePurchase(amount: double.parse(amount.text), context: context, currentBalance: money,
                 networdId: selectedChipIndex, phoneNumber: phoneNumber.text);
                // purchaseAirtime(
                //     double.parse(amount.text), balance, phoneNumber.text);
                  await getMyData();
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                          'Purchase Airtime',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
          )
          // MyButton(
          //   isLoading: isLoading,
          //   onTap: () {
          //     if (amount.text == '' || phoneNumber.text == '') {
          //     } else if (double.parse(amount.text) >= balance) {
          //     } else {
          //       purchaseAirtime(
          //           double.parse(amount.text), balance, phoneNumber.text);
          //     }
          //   },
          //   text: 'Purchase Airtime',
          // )
        ],
      ),
    );
  }
}
