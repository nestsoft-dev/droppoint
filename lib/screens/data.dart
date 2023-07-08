import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/http_helper.dart';
import '../widgets/textinput.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  TextEditingController phoneNumber = TextEditingController();
  double balance = 0;
  bool isLoading = false;
  List<Map<String, dynamic>> getDataList = [];
  List<Map<String, dynamic>> mtnData = [];
  List<Map<String, dynamic>> airtelData = [];
  List<Map<String, dynamic>> gloData = [];
  List<Map<String, dynamic>> mobileData = [];
  Future<void> fillAllList() async {}
  Future<void> getUserBalance() async {}

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

  @override
  void initState() {
    super.initState();
    getUserBalance();
    fillAllList();
    getMyData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumber.dispose();
  }

  bool selected = false;
  List<String> images = [
    'assets/mtnlogo.jpg',
    'assets/airtel.png',
    'assets/glo.png',
    'assets/9mobile.png',
  ];

  int selectedChipIndex = 0;
  double planAmount = 0;
  List<String> label = [
    'MTN',
    'Airtel',
    'Glo',
    '9Mobile',
  ];
  HttpHelper httpHelper = HttpHelper();

  void selectChip(int index) async {
    List<Map<String, dynamic>> myplan =
        await httpHelper.getPlanList(networkId: index, context: context);
    setState(() {
      selectedChipIndex = index;
      getDataList = myplan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Purchase Data',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: setallData
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 0),
                  child: Row(children: [
                    Text('Please Select the network for Data purchase')
                  ]),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MyTextInput(
                    textEditingController: phoneNumber,
                    hint: 'Enter Mobile Number',
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
                    if (phoneNumber.text == '') {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: "Please check inputs",
                      );
                    } else if (planAmount > money) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: "Low balance",
                      );
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      httpHelper.dataPlan(
                          context: context,
                          currenBalance: money,
                          networkId: selectedChipIndex,
                          phoneNumber: phoneNumber.text,
                          planAmount: planAmount);

                      await getMyData();

                      // purchaseAirtime(
                      //     double.parse(amount.text), balance, phoneNumber.text);
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
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Purchase Data Plan',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
