import 'package:shared_preferences/shared_preferences.dart';

class LoginData {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String isAdminKey = "false";
  static String profilePicKey = "PROFILEPICKEY";
  static String passwordKey = "Password";

  // saving the data to SF

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserAdminSF(bool isAdmin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(isAdminKey, isAdmin);
  }

  static Future<bool> saveUserProfilenSF(String profilePic) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(profilePicKey, profilePic);
  }

  static Future<bool> saveUserPasswordSF(String password) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(passwordKey, password);
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<bool?> getAdminFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(isAdminKey);
  }

  static Future<String?> getUserProfileFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(profilePicKey);
  }

  static Future<String?> getUserPasswordFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(passwordKey);
  }
}
