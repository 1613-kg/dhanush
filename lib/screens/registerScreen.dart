import 'package:dhanush/screens/loginScreen.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/authServices.dart';
import '../services/loginData.dart';
import 'homeScreen.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String confirmPassword = "";
  String userName = "";
  String adminPassword = "";
  String profilePic = "";
  final adminKey = "dhanush";
  List<String> list = ['User', 'Admin'];
  late String dropDownValue = list.first;

  AuthService authService = AuthService();
  bool _isLoading = false;
  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(userName, email, password,
              (dropDownValue == 'Admin') ? true : false, profilePic)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await LoginData.saveUserLoggedInStatus(true);
          await LoginData.saveUserEmailSF(email);
          await LoginData.saveUserNameSF(userName);
          await LoginData.saveUserProfilenSF(profilePic);
          await LoginData.saveUserPasswordSF(password);
          await LoginData.saveUserAdminSF(
              (dropDownValue == 'Admin') ? true : false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => homeScreen()));
        } else {
          showSnackbar(context, Colors.red, "Error in Signing in");
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
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: (_isLoading)
          ? loading()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 50, 15, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logoDhanush.jpg',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Welcome to Dhanush",
                      style: textTheme.titleLarge,
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
                          // userName

                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                labelText: "UserName",
                                labelStyle: textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.person,
                                )),
                            onChanged: (val) {
                              setState(() {
                                userName = val;
                              });
                            },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return "Name cannot be empty";
                              }
                            },
                          ),

                          SizedBox(
                            height: 40,
                          ),

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

                          SizedBox(
                            height: 40,
                          ),
                          // confirmPassword

                          TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Confirm Password",
                                labelStyle: textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.lock,
                                )),
                            onChanged: (val) {
                              setState(() {
                                confirmPassword = val;
                              });
                            },
                            validator: (val) {
                              if (val != password) {
                                return "Passwords do not match";
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
                    ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 25),
                        )),
                    SizedBox(
                      height: 80,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Have an existing account? ",
                        style: textTheme.bodySmall,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login now",
                              style: const TextStyle(
                                color: Colors.orange,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => loginScreen()));
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
