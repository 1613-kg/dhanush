class FactoryData {
  String id;
  String description;
  String location;
  String name;
  String imageUrl;
  List<String> stockData;
  int loadedTrucks;
  int trucksWillLoad;
  List<String> partyData;
  List<String> transportData;

  FactoryData(
      this.id,
      this.location,
      this.description,
      this.imageUrl,
      this.name,
      this.loadedTrucks,
      this.trucksWillLoad,
      this.partyData,
      this.stockData,
      this.transportData);
}
