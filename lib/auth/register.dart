import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../functions/firebase_fun.dart';
import '../widgets/mybutton.dart';
import '../widgets/textinput.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  FirebaseFun firebaseFun = FirebaseFun();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    name.dispose();
    password.dispose();
    confirmpassword.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  'Create Account',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Fill the form below to create account as new user',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                //mytextfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MyTextInput(
                    textEditingController: name,
                    hint: 'Enter Full name',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MyTextInput(
                    textEditingController: confirmpassword,
                    hint: 'Enter Confirm password',
                    textInputType: TextInputType.text,
                    ispassword: true,
                    maxlength: 10,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

               isLoading?Center(child: CircularProgressIndicator(color: Colors.red,),): GestureDetector(
                  onTap: () async {
                    if (email.text == '' ||
                        name.text == '' ||
                        password.text == '' ||
                        confirmpassword.text == '') {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: "Please check user inputs",
                          title: "Please check input");
                    } else if (password.text != confirmpassword.text) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text:
                              "Please password and confirmpassword don't match",
                          title: "Password not a match");
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      await firebaseFun.register(
                          name.text, email.text, password.text, context);
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
                              'Register',
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
              ]),
        ),
      ))),
    );
  }
}
