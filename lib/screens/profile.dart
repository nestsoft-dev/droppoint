import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: Icon(
          EvaIcons.logOut,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Good Afternoon Ikenna',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 15,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //balance box
            Container(
              height: 90,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'User Available Balance',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\₦215.55',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Become a reseller?',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 30,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set Transaction pin',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Show balance',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Customer Care',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reset password',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  EvaIcons.email,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contact support',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.support_agent_sharp,
                  color: Colors.blue,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delete Account?',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
