class FactoryData {
  String id;
  String description;
  String location;
  String name;
  List<String> imageUrl;
  List<String> stockData;
  List<String> partyData;
  List<String> transportData;
  DateTime timeStamp;

  FactoryData(
      this.id,
      this.location,
      this.description,
      this.imageUrl,
      this.name,
      this.partyData,
      this.stockData,
      this.transportData,
      this.timeStamp);
}
