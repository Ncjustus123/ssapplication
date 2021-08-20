import 'dart:convert';

import 'package:driver_salary/model/getClaimsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_models.dart';
import '../model/profilemodel.dart';

class AppPreference {
  AppPreference(this.preferences);

  static Future<AppPreference> getInstance() async {
    if (instance != null) {
      return instance;
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return AppPreference(preferences);
    }
  }

  static AppPreference instance;
  SharedPreferences preferences;

  static const String isWalletCreated = "wallet_created";
  static const String walletId = "walletID";
  static const String loggedIn = "logged_In";
  static const String firstName = "firstName";
  static const String lastName = "surname";
  static const String password = "password";
  static const String phoneNumber = "phone";
  static const String gender = "gender";
  static const String userType = "userType";

  static const String email = "email";
  static const String token = 'token';
  static const String username = 'username';
  static const String fullName = 'fullName';
  static const String userId = "userId";
  static const String claims = "claims";

  bool getBool(String key) {
    return preferences.getBool(key) == null ? false : preferences.getBool(key);
  }

  String getString(String key) {
    return preferences.getString(key);
  }

  int getInt(String key) {
    return preferences.getInt(key);
  }

  void setPref(String key, String value) {
    preferences.setString(key, value);
  }

  void setBoolPref(String key, bool value) {
    preferences.setBool(key, value);
  }

  void setListPref(String key, List<String> value) {
    preferences.setStringList(key, value);
  }

  void setInt(String key, int value) {
    preferences.setInt(key, value);
  }

  void setDouble(String key, double value) {
    preferences.setDouble(key, value);
  }

  double getDouble(String key) {
    return preferences.getDouble(key);
  }

  //method to save List<ClaimsObject>
  static String encodeClaims(List<ClaimsObject> obj) {
    return json.encode(
        obj.map<Map<String, dynamic>>((i) => ClaimsObject.toMap(i)).toList());
  }

  //decode
  static List<ClaimsObject> decodeClaims(String claimsString) =>
      (json.decode(claimsString) as List<dynamic>)
          .map<ClaimsObject>((i) => ClaimsObject.fromJson(i))
          .toList();

  void saveUserDetails(ProfileModelObject s) {
    preferences.setString(firstName, s.firstName);
    preferences.setString(lastName, s.lastName);
    preferences.setString(phoneNumber, s.phoneNumber);
    preferences.setInt(userType, s.userType);
    preferences.setString(email, s.email);
    preferences.setString(claims, encodeClaims(s.claimsObject));

    // preferences.setString(userId, s.userId);
  }

  ProfileModelObject getUseDetails() {
    return ProfileModelObject(
      firstName: preferences.getString(firstName),
      lastName: preferences.getString(lastName),
      phoneNumber: preferences.get(phoneNumber),
      email: preferences.getString(email),
      userType: preferences.getInt(userType),
      claimsObject: decodeClaims(preferences.getString(claims)),
    );
  }

  TokenRequestObject getUserCredentials() {
    return TokenRequestObject(
        preferences.getString(password), preferences.getString(username));
  }

  void setUserCredentials(TokenRequestObject t) {
    preferences.setString(password, t.password);
    preferences.setString(username, t.username);
  }

  void updateUserDetails() {
    //TODO no endpoint available for updating user profile
  }

  void changePassword() {
    //TODO no endpoint available for changing user password
  }

  void setLoggedInState(bool isLoggedIn) {
    preferences.setBool(loggedIn, isLoggedIn);
  }

  bool isLoggedIn() {
    return preferences.getBool(loggedIn);
  }
}
