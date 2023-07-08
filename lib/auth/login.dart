import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../functions/firebase_fun.dart';
import '../widgets/textinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

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
      body: Column(
        children: [
          SizedBox(height: 50),
          Icon(
            Icons.person,
            color: Colors.red,
            size: 55,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Login Account',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Welcome back user',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          //mytextfield
         
          SizedBox(
            height: 5,
          ),
          //mytextfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyTextInput(
              textEditingController: email,
              hint: 'Enter Email',
              textInputType: TextInputType.text,
              ispassword: false,
              maxlength: 45,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //mytextfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyTextInput(
              textEditingController: password,
              hint: 'Enter password',
              textInputType: TextInputType.text,
              ispassword: true,
              maxlength: 10,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //mytextfield
        

          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    if (email.text == '' ||
                       
                        password.text == '' 
                       ) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: "Please check user inputs",
                          title: "Please check input");
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      await firebaseFun.loginUser(email.text, password.text, context);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
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
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18,
                  //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  print('login');
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
