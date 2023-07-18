import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference stockCollection =
      FirebaseFirestore.instance.collection("stocks");

  Future savingUserData(String userName, String email, bool isAdmin,
      String profilePic, String password) async {
    return await userCollection.doc(uid).set({
      "userName": userName,
      "email": email,
      "isAdmin": isAdmin,
      "uid": uid,
      "profilePic": profilePic,
      "password": password,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future savingStockData(String stockType, String amount, String purchasedFrom,
      bool labCheck, DateTime purchasedDate) async {
    DocumentReference stockDocumentReference = await stockCollection.add({
      "stockType": stockType,
      "stockId": '',
      "amount": amount,
      "labCheck": labCheck,
      "purchasedFrom": purchasedFrom,
      "addedById": uid,
      "purchasedDate": purchasedDate,
    });
    await stockDocumentReference.update({
      "stockId": stockDocumentReference.id,
    });
  }

  getStockData() async {
    return stockCollection.snapshots();
  }
}
