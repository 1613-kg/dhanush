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

  Future<List<String>> uploadFactoryPictures(
      List<File> images, DateTime timeStamp, String name) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('factoryImages')
        .child(name)
        .child(timeStamp.toString());

    List<String> _imagesUrl = [];
    for (int i = 0; i < images.length; i++) {
      UploadTask uploadTask = ref.child(i.toString()).putFile(images[i]);
      TaskSnapshot snapshot = await uploadTask;
      String imageDwnUrl = await snapshot.ref.getDownloadURL();
      _imagesUrl.add(imageDwnUrl);
    }

    return _imagesUrl;
  }

  Future<void> deleteFactoryPic(DateTime timeStamp, String name) async {
    // Reference photoRef = await FirebaseStorage.instance.refFromURL(imageUrl);
    // await photoRef.delete();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('factoryImages')
        .child(name)
        .child(timeStamp.toString());

    await ref.delete();
  }

  Future<List<String>> uploadItemPictures(
      List<File> images, DateTime timeStamp, String name) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('itemImages')
        .child(name)
        .child(timeStamp.toString());

    List<String> _imagesUrl = [];
    for (int i = 0; i < images.length; i++) {
      UploadTask uploadTask = ref.child(i.toString()).putFile(images[i]);
      TaskSnapshot snapshot = await uploadTask;
      String imageDwnUrl = await snapshot.ref.getDownloadURL();
      _imagesUrl.add(imageDwnUrl);
    }

    return _imagesUrl;
  }

  Future<String> uploadProPic(File? image) async {
    if (image == null) return "";
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  Future<void> deleteProPic() async {
    // Reference photoRef = await FirebaseStorage.instance.refFromURL(imageUrl);
    // await photoRef.delete();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    await ref.delete();
  }

  Future<void> deleteItemPic(DateTime timeStamp, String name) async {
    // Reference photoRef = await FirebaseStorage.instance.refFromURL(imageUrl);
    // await photoRef.delete();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('itemImages')
        .child(name)
        .child(timeStamp.toString());

    await ref.delete();
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
