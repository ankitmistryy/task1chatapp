import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPrefLoginKey= "ISLOGGEDIN";
  static String sharedPrefUserNameKey = "USERNAMEKEY";
  static String sharedPrefEmailKey= " EMAILKEY";

  //saving data  to sharedpreference

  static Future <bool> savedUserLoggedIn(bool isUserLoggedIn)
   async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefLoginKey, isUserLoggedIn);
  }
  static Future <bool> savedUserName(String userName)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserNameKey, userName);
  }

  static Future <bool> savedUserEmail(String userEmail)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefEmailKey, userEmail);
  }
// getting data from sharedpreference

  static Future <bool?> getLoggedIn()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPrefLoginKey);
  }

  static Future <String?> getUserEmail()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefEmailKey);
  }
  static Future <String?> getUserName()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefUserNameKey);
  }


}