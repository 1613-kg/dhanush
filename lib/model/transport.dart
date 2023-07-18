class TransportData {
  String transportId;
  String truckNumber;
  String driverName;
  String driverContact;
  String owner;
  String deliveredTo;
  String deliveredFrom;
  DateTime leavingTime;

  TransportData(
    this.transportId,
    this.truckNumber,
    this.driverContact,
    this.driverName,
    this.owner,
    this.deliveredFrom,
    this.deliveredTo,
    this.leavingTime,
  );
}
