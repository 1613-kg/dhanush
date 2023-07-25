class OrderData {
  String orderId;
  String address;
  String buyerId;
  String itemId;
  double price;
  int quantity;
  DateTime date;
  String paymentType;

  OrderData(
      {required this.orderId,
      required this.address,
      required this.itemId,
      required this.buyerId,
      required this.date,
      required this.paymentType,
      required this.price,
      required this.quantity});
}
