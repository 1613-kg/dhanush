import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/authServices.dart';
import '../services/databaseServices.dart';
import '../services/loginData.dart';
import '../widgets/loading.dart';
import 'homeScreen.dart';
import 'registerScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String adminPassword = "";
  final adminKey = "dhanush";
  List<String> list = ['User', 'Admin'];
  late String dropDownValue = list.first;
  bool _isLoading = false;

  AuthService authService = AuthService();
  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          // saving the shared preference state
          await LoginData.saveUserLoggedInStatus(true);
          await LoginData.saveUserEmailSF(email);
          await LoginData.saveUserProfilenSF(snapshot.docs[0]['profilePic']);
          await LoginData.saveUserPasswordSF(password);
          await LoginData.saveUserNameSF(snapshot.docs[0]['userName']);
          await LoginData.saveUserAdminSF(
              (dropDownValue == 'Admin') ? true : false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => homeScreen()));
        } else {
          showSnackbar(context, Colors.red, "Error in Logging in");
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: (_isLoading)
          ? loading()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 50, 15, 30),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      //borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logoDhanush.jpg',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Login as a",
                          style: textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                            padding: EdgeInsets.all(10),
                            value: dropDownValue,
                            borderRadius: BorderRadius.circular(10),
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropDownValue = value!;
                              });
                            }),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email",
                                labelStyle: textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.mail,
                                )),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter a valid email";
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // password

                          TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                labelStyle: textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.lock,
                                )),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            validator: (val) {
                              if (val!.length < 6) {
                                return "Password must be at least 6 characters";
                              } else {
                                return null;
                              }
                            },
                          ),

                          (dropDownValue == 'Admin')
                              ? SizedBox(
                                  height: 40,
                                )
                              : SizedBox(
                                  height: 0,
                                ),

                          // adminKey
                          (dropDownValue == 'Admin')
                              ? TextFormField(
                                  obscureText: true,
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Admin Password",
                                      labelStyle: textTheme.bodySmall,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                      )),
                                  onChanged: (val) {
                                    setState(() {
                                      adminPassword = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val != adminKey) {
                                      return "Incorrect admin key";
                                    } else {
                                      return null;
                                    }
                                  },
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor)),
                    ),
                    (dropDownValue == 'User')
                        ? SizedBox(
                            height: 140,
                          )
                        : SizedBox(
                            height: 80,
                          ),
                    Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: textTheme.bodySmall,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Create",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              registerScreen()));
                                }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
