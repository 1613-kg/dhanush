class UserData {
  String id;
  String userName;
  String profilePic;
  bool isAdmin;
  String email;
  String password;
  List<String> isFav;
  List<String> isAddedToCart;

  UserData(this.id, this.email, this.userName, this.isAdmin, this.password,
      this.profilePic, this.isFav, this.isAddedToCart);
}
