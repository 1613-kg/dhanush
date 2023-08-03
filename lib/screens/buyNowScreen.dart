import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/model/orderData.dart';
import 'package:dhanush/screens/success.dart';
import 'package:dhanush/services/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../services/databaseServices.dart';

class buyNowScreen extends StatefulWidget {
  int quantity;
  double totalAmount;
  ItemsData itemsData;
  buyNowScreen(
      {super.key,
      required this.itemsData,
      required this.totalAmount,
      required this.quantity});

  @override
  State<buyNowScreen> createState() => _buyNowScreenState();
}

class _buyNowScreenState extends State<buyNowScreen> {
  TextEditingController _houseNumber = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _locality = TextEditingController();
  String floorNumber = "";
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  int _value = 0;
  String email = "";
  var _razorpay = Razorpay();
  String order_Id = "";

  void _handlerPaymentSuccess(PaymentSuccessResponse response) {
    _addOrderData();
    // print("Pament success😂😂😂");
    //Toast.show("Pament success", context);
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    //showSnackbar(context, Colors.red, "Payment failed");
    //print("Error😂😂😂");
    //Toast.show("Pament error", context);
  }

  void _handlerExternalWallet(ExternalWalletResponse response) {}

  getUser() async {
    QuerySnapshot snapshot =
        await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
            .gettingUserIdData(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      email = snapshot.docs[0]['email'];
    });
  }

  getOrderId(double amount) async {
    await generateOrderId(amount).then((value) {
      setState(() {
        order_Id = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
    //print("Working😂😂😂😂");
    getUser();
    getOrderId(widget.totalAmount);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() {
    //print("Working😂😂😂😂");
    Map<String, dynamic> options = {
      "key": "rzp_test_TTMLTDLLI43xpE",
      "amount": widget.totalAmount * 100,
      "order_id": order_Id,
      "name": "Dhanush App",
      "description": "Payment for the ${widget.itemsData.titleName}",
      "prefill": {"email": email},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      //print("${e.toString()}😂😂");
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.all(10),
        child: (_value == 1)
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: colorTheme),
                onPressed: () {
                  _addOrderData();
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: colorTheme),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    openCheckout();
                  }
                },
                child: Text(
                  'Proceed To Pay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 80),
            padding: EdgeInsets.all(5),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address*",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "House No.*",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              textField(
                                hint: "House No./Flat No.",
                                inputType: TextInputType.number,
                                controller: _houseNumber,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Street Name*",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              textField(
                                hint: "Locality",
                                inputType: TextInputType.multiline,
                                controller: _locality,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Landmark",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                cursorColor: colorTheme,
                                controller: _landmark,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    hintText: "Nearby place",
                                    //helperText: titleText,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colorTheme)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colorTheme),
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
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Floor",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    floorNumber = value;
                                  });
                                },
                                cursorColor: colorTheme,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Floor Number",
                                    //helperText: titleText,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: colorTheme)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colorTheme),
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
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City*",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              textField(
                                hint: "Jaipur",
                                inputType: TextInputType.multiline,
                                controller: _city,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "State*",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              textField(
                                hint: "Rajasthan",
                                inputType: TextInputType.multiline,
                                controller: _state,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pincode*",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textField(
                                    hint: "Enter pincode",
                                    inputType: TextInputType.number,
                                    controller: _pincode,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Type*",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: colorTheme,
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (val) {
                                    setState(() {
                                      _value = val!;
                                    });
                                  }),
                              Text("Cash on Delivery"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: colorTheme,
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (val) {
                                    setState(() {
                                      _value = val!;
                                    });
                                  }),
                              Text("Pay Online"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Amount: "),
                          AutoSizeText("₹${widget.totalAmount.toString()}"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({
    required TextInputType inputType,
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: TextFormField(
        validator: (val) {
          if (val!.isNotEmpty) {
            return null;
          } else {
            return "Field cannot be empty";
          }
        },
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: hint,
            //helperText: titleText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
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

  _addOrderData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .savingOrderData(OrderData(
              orderId: '',
              address: _houseNumber.text.trim() +
                  ' ' +
                  floorNumber +
                  ' ' +
                  _locality.text.trim() +
                  ' ' +
                  _landmark.text.trim() +
                  ' ' +
                  _city.text.trim() +
                  ' ' +
                  _state.text.trim() +
                  ' ' +
                  _pincode.text.trim(),
              itemId: widget.itemsData.id,
              buyerId: FirebaseAuth.instance.currentUser!.uid,
              date: DateTime.now(),
              paymentType: (_value == 1) ? "Cash on delivery" : "Paid Online",
              price: widget.totalAmount,
              quantity: widget.quantity))
          .whenComplete(() => isLoading = false);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => successScreen(
                    itemsData: widget.itemsData,
                  )),
          (route) => false);
    }
  }
}
