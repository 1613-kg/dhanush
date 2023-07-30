import 'dart:io';

import 'package:dhanush/screens/loginScreen.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _adminPasswordController = TextEditingController();

  String profilePic = "";
  final adminKey = "dhanush";
  List<String> list = ['User', 'Admin'];
  late String dropDownValue = list.first;
  File? img;

  AuthService authService = AuthService();
  bool _isLoading = false;
  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(
              _userNameController.text,
              _emailController.text,
              _passwordController.text,
              (dropDownValue == 'Admin') ? true : false,
              profilePic)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await LoginData.saveUserLoggedInStatus(true);
          await LoginData.saveUserEmailSF(_emailController.text);
          await LoginData.saveUserNameSF(_userNameController.text);
          await LoginData.saveUserProfilenSF(profilePic);
          await LoginData.saveUserPasswordSF(_passwordController.text);
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
        centerTitle: true,
      ),
      body: (_isLoading)
          ? loading()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialogOpt(context);
                        },
                        child: (img == null)
                            ? CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 60,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(img!),
                                radius: 60,
                              ),
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      Row(
                        children: [
                          Text(
                            "Register as a",
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
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                      SizedBox(
                        height: 25,
                      ),
                      textField(
                          color: Theme.of(context).primaryColor,
                          validate: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                          hintText: "Name",
                          icon: Icons.person,
                          inputType: TextInputType.multiline,
                          controller: _userNameController,
                          action: TextInputAction.next),
                      SizedBox(
                        height: 10,
                      ),

                      textField(
                        color: Theme.of(context).primaryColor,
                        validate: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                        hintText: "Email",
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                        action: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textField(
                          color: Theme.of(context).primaryColor,
                          validate: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Feild cannot be empty";
                            }
                          },
                          hintText: "Password",
                          icon: Icons.lock,
                          inputType: TextInputType.multiline,
                          controller: _passwordController,
                          action: TextInputAction.next),
                      SizedBox(
                        height: 10,
                      ),
                      textField(
                          color: Theme.of(context).primaryColor,
                          validate: (val) {
                            if (val == _passwordController.text) {
                              return null;
                            } else {
                              return "Password do not match";
                            }
                          },
                          hintText: "Confrim Password",
                          icon: Icons.lock,
                          inputType: TextInputType.multiline,
                          controller: _confirmPasswordController,
                          action: (dropDownValue == "User")
                              ? TextInputAction.done
                              : TextInputAction.next),

                      (dropDownValue == 'Admin')
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(
                              height: 0,
                            ),

                      // adminKey
                      (dropDownValue == 'Admin')
                          ? textField(
                              validate: (val) {
                                if (val == adminKey) {
                                  return null;
                                } else {
                                  return "Wrong admin key";
                                }
                              },
                              hintText: "Admin Password",
                              icon: Icons.lock,
                              inputType: TextInputType.multiline,
                              controller: _adminPasswordController,
                              action: TextInputAction.done,
                              color: Theme.of(context).primaryColor,
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (img != null) {
                              await authService.uploadProPic(img).then((value) {
                                setState(() {
                                  profilePic = value;
                                });
                              });
                            }
                            register();
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Have an existing account? ",
                          style: textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Login now",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                loginScreen()));
                                  }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required TextEditingController controller,
    required TextInputAction action,
    required final validate,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: validate,
        cursorColor: color,
        controller: controller,
        keyboardType: inputType,
        textInputAction: action,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: color,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: color)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            border: InputBorder.none),
      ),
    );
  }

  void pickImage(ImageSource src, BuildContext context) async {
    final file = await ImagePicker().pickImage(source: src);
    File image = File(file!.path);
    File compressedImage = await customCompressed(image);

    setState(() {
      img = compressedImage;
    });
  }

  Future<File> customCompressed(File imagePath) async {
    var path = await FlutterNativeImage.compressImage(imagePath.absolute.path,
        quality: 100, percentage: 10);
    return path;
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    pickImage(ImageSource.camera, context);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Camera"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    pickImage(ImageSource.gallery, context);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.album),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Close"),
                    ],
                  ),
                )
              ],
            ));
  }
}
