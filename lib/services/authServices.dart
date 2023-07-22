import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'databaseServices.dart';
import 'loginData.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login function

  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(String fullName, String email,
      String password, bool isAdmin, String profilePic) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseServices(user.uid)
            .savingUserData(fullName, email, isAdmin, profilePic, password);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<List<String>> uploadFactoryPictures(List<File> images) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Factory')
        .child(FirebaseAuth.instance.currentUser!.uid);

    List<String> _imagesUrl = [];
    for (int i = 0; i < images.length; i++) {
      UploadTask uploadTask = ref.child(i.toString()).putFile(images[i]);
      TaskSnapshot snapshot = await uploadTask;
      String imageDwnUrl = await snapshot.ref.getDownloadURL();
      _imagesUrl.add(imageDwnUrl);
    }

    return _imagesUrl;
  }

  // signout
  Future signOut() async {
    try {
      await LoginData.saveUserLoggedInStatus(false);
      await LoginData.saveUserEmailSF("");
      await LoginData.saveUserNameSF("");
      await LoginData.saveUserAdminSF(false);
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
