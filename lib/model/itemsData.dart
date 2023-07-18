class ItemsData {
  String id;
  String description;
  int quantity;
  String unit;
  String brand;
  String titleName;
  List<String> imageUrl;
  bool isFav;
  bool isAddedToCart;
  String webUrl;
  double productRating;

  ItemsData(
      this.brand,
      this.description,
      this.id,
      this.quantity,
      this.titleName,
      this.unit,
      this.imageUrl,
      this.isFav,
      this.isAddedToCart,
      this.webUrl,
      this.productRating);
}
