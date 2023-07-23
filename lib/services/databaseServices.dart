import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/model/partyData.dart';
import 'package:dhanush/model/stockData.dart';
import 'package:dhanush/model/transport.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference stockCollection =
      FirebaseFirestore.instance.collection("stocks");

  final CollectionReference partyCollection =
      FirebaseFirestore.instance.collection("party");

  final CollectionReference transportCollection =
      FirebaseFirestore.instance.collection("transport");

  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection("items");

  final CollectionReference factoryCollection =
      FirebaseFirestore.instance.collection("factory");

  Future savingUserData(String userName, String email, bool isAdmin,
      String profilePic, String password) async {
    return await userCollection.doc(uid).set({
      "userName": userName,
      "email": email,
      "isAdmin": isAdmin,
      "uid": uid,
      "profilePic": profilePic,
      "password": password,
      "isFav": [],
      "isAddedToCart": []
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future savingStockData(String stockType, String amount, String purchasedFrom,
      bool labCheck, DateTime purchasedDate, String factoryId) async {
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

    DocumentReference factoryDocumentReference =
        factoryCollection.doc(factoryId);
    return await factoryDocumentReference.update({
      "stocks": FieldValue.arrayUnion(
          ["${factoryDocumentReference.id}_${stockDocumentReference.id}"])
    });
  }

  Future updatingStockData(StockData stockData) async {
    await stockCollection.doc(stockData.stockId).update({
      "stockType": stockData.type,
      "stockId": stockData.stockId,
      "amount": stockData.stock,
      "labCheck": stockData.labCheck,
      "purchasedFrom": stockData.buyingParty,
      "addedById": uid,
      "purchasedDate": stockData.buyingDate,
    });
  }

  Future deletingStockData(StockData stockData, String factoryId) async {
    await stockCollection.doc(stockData.stockId).delete();

    DocumentReference factoryDocumentReference =
        factoryCollection.doc(factoryId);
    return await factoryDocumentReference.update({
      "stocks": FieldValue.arrayRemove(
          ["${factoryDocumentReference.id}_${stockData.stockId}"])
    });
  }

  getStockData(String stockId) async {
    return stockCollection.doc(stockId).snapshots();
  }

  Future savingFactoryData(FactoryData factoryData) async {
    DocumentReference factoryDocumentReference = await factoryCollection.add({
      "name": factoryData.name,
      "factoryId": '',
      "location": factoryData.location,
      "description": factoryData.description,
      "image": [],
      "stocks": [],
      "party": [],
      "transport": [],
    });
    await factoryDocumentReference.update({
      "factoryId": factoryDocumentReference.id,
    });
  }

  Future updatingFactoryData(FactoryData factoryData) async {
    await factoryCollection.doc(factoryData.id).update({
      "name": factoryData.name,
      "factoryId": factoryData.id,
      "location": factoryData.location,
      "description": factoryData.description,
      "image": factoryData.imageUrl,
      "stocks": factoryData.stockData,
      "party": factoryData.partyData,
      "transport": factoryData.transportData,
    });
  }

  Future deletingFactoryData(FactoryData factoryData) async {
    await factoryCollection.doc(factoryData.id).delete();
  }

  getFactoryData() async {
    return factoryCollection.snapshots();
  }

  getFactorySPT(String factoryId) async {
    return factoryCollection.doc(factoryId).snapshots();
  }

  Future savingPartyData(String partyName, String partyLocation,
      String paymentLeft, String paymentDone, String factoryId) async {
    DocumentReference partyDocumentReference = await partyCollection.add({
      "partyName": partyName,
      "partyId": '',
      "partyLocation": partyLocation,
      "paymentLeft": paymentLeft,
      "paymentDone": paymentDone,
    });
    await partyDocumentReference.update({
      "partyId": partyDocumentReference.id,
    });

    DocumentReference factoryDocumentReference =
        factoryCollection.doc(factoryId);
    return await factoryDocumentReference.update({
      "party": FieldValue.arrayUnion(
          ["${factoryDocumentReference.id}_${partyDocumentReference.id}"])
    });
  }

  Future updatingPartyData(PartyData partyData) async {
    await partyCollection.doc(partyData.partyId).update({
      "partyName": partyData.partyName,
      "partyId": partyData.partyId,
      "partyLocation": partyData.partyLocation,
      "paymentLeft": partyData.paymentLeft,
      "paymentDone": partyData.paymentDone,
    });
  }

  Future deletingPartyData(PartyData partyData, String factoryId) async {
    await partyCollection.doc(partyData.partyId).delete();

    DocumentReference factoryDocumentReference =
        factoryCollection.doc(factoryId);
    return await factoryDocumentReference.update({
      "party": FieldValue.arrayRemove(
          ["${factoryDocumentReference.id}_${partyData.partyId}"])
    });
  }

  getPartyData() async {
    return partyCollection.snapshots();
  }

  Future savingTransportData(
      String truckNumber,
      String driverName,
      String driverContact,
      String owner,
      String deliveredTo,
      String deliveredFrom,
      DateTime leavingTime,
      String factoryId) async {
    DocumentReference transportDocumentReference =
        await transportCollection.add({
      "truckNumber": truckNumber,
      "transportId": '',
      "driverName": driverName,
      "driverContact": driverContact,
      "owner": owner,
      "deliveredTo": deliveredTo,
      "deliveredFrom": deliveredFrom,
      "leavingTime": leavingTime,
    });
    await transportDocumentReference.update({
      "transportId": transportDocumentReference.id,
    });

    DocumentReference factoryDocumentReference =
        factoryCollection.doc(factoryId);
    return await factoryDocumentReference.update({
      "transport": FieldValue.arrayUnion(
          ["${factoryDocumentReference.id}_${transportDocumentReference.id}"])
    });
  }

  Future updatingTransportData(TransportData transportData) async {
    await transportCollection.doc(transportData.transportId).update({
      "truckNumber": transportData.truckNumber,
      "transportId": transportData.transportId,
      "driverName": transportData.driverName,
      "driverContact": transportData.driverContact,
      "owner": transportData.owner,
      "deliveredTo": transportData.deliveredTo,
      "deliveredFrom": transportData.deliveredFrom,
      "leavingTime": transportData.leavingTime,
    });
  }

  Future deletingTransportData(
      TransportData transportData, String factoryId) async {
    await transportCollection.doc(transportData.transportId).delete();

    DocumentReference factoryDocumentReference =
        factoryCollection.doc(factoryId);
    return await factoryDocumentReference.update({
      "transport": FieldValue.arrayRemove(
          ["${factoryDocumentReference.id}_${transportData.transportId}"])
    });
  }

  getTransportData() async {
    return transportCollection.snapshots();
  }

  Future savingItemsData(ItemsData itemsData) async {
    DocumentReference itemsDocumentReference = await itemsCollection.add({
      "description": itemsData.description,
      "itemsId": '',
      "unit": itemsData.unit,
      "brand": itemsData.brand,
      "titleName": itemsData.titleName,
      "webUrl": itemsData.webUrl,
      "quantity": itemsData.quantity,
      "isFav": itemsData.isFav,
      "isAddedToCart": itemsData.isAddedToCart,
      "productRating": itemsData.productRating,
      "imageUrl": itemsData.imageUrl,
    });
    await itemsDocumentReference.update({
      "itemsId": itemsDocumentReference.id,
    });
  }

  Future updatingItemsData(ItemsData itemsData) async {
    await transportCollection.doc(itemsData.id).update({
      "description": itemsData.description,
      "itemsId": '',
      "unit": itemsData.unit,
      "brand": itemsData.brand,
      "titleName": itemsData.titleName,
      "webUrl": itemsData.webUrl,
      "quantity": itemsData.quantity,
      "isFav": itemsData.isFav,
      "isAddedToCart": itemsData.isAddedToCart,
      "productRating": itemsData.productRating,
      "imageUrl": itemsData.imageUrl,
    });
  }

  Future<bool?> isFav(String itemsId) async {
    DocumentReference userDocumentRefernce = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentRefernce.get();

    List<dynamic> isFav = await documentSnapshot['isFav'];
    if (isFav.contains(itemsId)) {
      return true;
    } else {
      return false;
    }
  }

  Future toggleFav(String itemsId) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference itemsDocumentReference = itemsCollection.doc(itemsId);

    DocumentSnapshot documentSnapshot = await itemsDocumentReference.get();
    List<dynamic> isFav = await documentSnapshot['isFav'];

    // if user has our groups -> then remove then or also in other part re join
    if (isFav.contains("$uid")) {
      await itemsDocumentReference.update({
        "isFav": FieldValue.arrayRemove([uid])
      });
      await userDocumentReference.update({
        "isFav": FieldValue.arrayRemove([itemsId])
      });
    } else {
      await userDocumentReference.update({
        "isFav": FieldValue.arrayUnion([itemsId])
      });
      await itemsDocumentReference.update({
        "isFav": FieldValue.arrayUnion([uid])
      });
    }
  }

  Future<bool?> isAddedToCart(String itemsId) async {
    DocumentReference userDocumentRefernce = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentRefernce.get();

    List<dynamic> isAddedToCart = await documentSnapshot['isAddedToCart'];
    if (isAddedToCart.contains(itemsId)) {
      return true;
    } else {
      return false;
    }
  }

  Future toggleIsAddedToCart(String itemsId) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference itemsDocumentReference = itemsCollection.doc(itemsId);

    DocumentSnapshot documentSnapshot = await itemsDocumentReference.get();
    List<dynamic> isAddedToCart = await documentSnapshot['isAddedToCart'];

    // if user has our groups -> then remove then or also in other part re join
    if (isAddedToCart.contains("$uid")) {
      await itemsDocumentReference.update({
        "isAddedToCart": FieldValue.arrayRemove([uid])
      });
      await userDocumentReference.update({
        "isAddedToCart": FieldValue.arrayRemove([itemsId])
      });
    } else {
      await userDocumentReference.update({
        "isAddedToCart": FieldValue.arrayUnion([itemsId])
      });
      await itemsDocumentReference.update({
        "isAddedToCart": FieldValue.arrayUnion([uid])
      });
    }
  }

  getItemsData() async {
    return itemsCollection.snapshots();
  }
}
