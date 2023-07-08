import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:newapp_one/screens/school.dart';
import 'package:newapp_one/screens/tv.dart';

import '../constants/constants.dart';
import 'airtime.dart';
import 'data.dart';
import 'electricity.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> nameList = [
    'Airtime',
    'VTU & share',
    'Data',
    'Tv',
    'Electricity',
    'School&Exam',
  ];

  List<IconData> icons = [
    EvaIcons.phoneCall,
    EvaIcons.phoneCallOutline,
    Icons.signal_cellular_connected_no_internet_0_bar,
    Icons.cable_outlined,
    EvaIcons.charging,
    EvaIcons.bookOpen,
  ];

  @override
  void initState() {
    super.initState();
    greetings();
    getMyData();
  }

  String _greeting = '';

  greetings() {
    final currentTime = DateTime.now();
    final formatter = DateFormat('HH');

    final hour = int.parse(formatter.format(currentTime));

    if (hour >= 0 && hour < 12) {
      setState(() {
        _greeting = 'Good Morning';
      });
    } else if (hour >= 12 && hour < 18) {
      setState(() {
        _greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        _greeting = 'Good Night';
      });
    }
  }

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

  goScreeb(int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Airtime()));
    } else if (index == 1) {
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DataPage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TvSub()));
    } else if (index == 4) {
      //electricity
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Electricity()));
    } else if (index == 5) {
      //exam pin

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ExamPin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          } else if (snapshot.hasData && snapshot.data!.exists) {
            final name = snapshot.data!.get('name');
            final balance = double.parse(snapshot.data!.get('balance'));
            showMoney = balance.toStringAsFixed(2);
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  //my app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$_greeting $name'),
                      Row(
                        children: [
                          Icon(Icons.support_agent),
                          SizedBox(
                            width: 15,
                          ),
                          FaIcon(FontAwesomeIcons.bell)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //home box
                  Container(
                    height: 180,
                    width: size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //!st child
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '$showMoney',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              //2nd child
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HistoryPage()));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Transaction History',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        //Expanded(child: child)
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // add money
                              GestureDetector(
                                onTap: () {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      text:
                                          "Access bank\nIkenna collins obetta\n0826903668",
                                      title:
                                          "Please make transfer to your personal account below");
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: FaIcon(FontAwesomeIcons.add,
                                            color: Colors.red),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Add money',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              //transfer
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.transfer_within_a_station_rounded,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Transfer',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),

                              //withdraw
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: FaIcon(FontAwesomeIcons.download,
                                          color: Colors.red),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Withdraw',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )

                  //money box
                  ,
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Payments',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: GridView.builder(
                        itemCount: nameList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => goScreeb(index),
                            child: Container(
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(icons[index], color: Colors.red),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(nameList[index]),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [Text("History")],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('history')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      // .collection('history')
                      // .doc(FirebaseAuth.instance.currentUser!.uid)
                      // .collection('MyHistory')
                      // .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        } else if (snapshot.hasData && snapshot.data!.exists) {
                          final title = snapshot.data!.get('title');
                          final des = snapshot.data!.get('des');
                          final imagePath = snapshot.data!.get('imagePath');
                          final amount =
                              double.parse(snapshot.data!.get('amount'));
                          final time = snapshot.data!.get('time');
                          bool isDebit = snapshot.data!.get('isDebit') as bool;
                          return Expanded(
                            child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 5, left: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: isDebit
                                                  ? Colors.redAccent
                                                  : Color.fromARGB(
                                                      255, 233, 233, 233)),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          '$imagePath'),
                                                      fit: BoxFit.fill)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '$title',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                    '$des'),
                                              ],
                                            ),
                                            Center(
                                                child: Text(
                                              isDebit?'-\₦$amount': '+\₦$amount',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: isDebit
                                                      ? Colors.red
                                                      : Colors.green),
                                            )),
                                          ]),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Center(
                            child: Text('History is empty'),
                          );
                        }
                      })
                ]),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        });
    // setallData
    //     ? Center(
    //         child: CircularProgressIndicator(
    //         color: Colors.red,
    //       ))
    //     :
  }
}
