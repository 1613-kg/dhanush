class StockData {
  String stockId;
  String stock;
  String type;
  DateTime buyingDate;
  bool labCheck;
  String buyingParty;
  String addedById;

  StockData(this.stockId, this.stock, this.type, this.buyingDate,
      this.buyingParty, this.labCheck, this.addedById);
}
