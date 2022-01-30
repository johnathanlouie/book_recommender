import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';

  String get firstName => _firstName;

  String get lastName => _lastName;

  static bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  Future<bool> readLocal() async {
    if (!isLoggedIn) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser!.uid != prefs.getString('userID')) {
      return false;
    }
    String? firstName = prefs.getString('firstName');
    if (firstName == null) {
      return false;
    }
    _firstName = firstName;
    String? lastName = prefs.getString('lastName');
    if (lastName == null) {
      return false;
    }
    _lastName = lastName;
    return true;
  }

  Future<bool> writeLocal() async {
    if (!isLoggedIn || _firstName == '' || _lastName == '') {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', _firstName);
    await prefs.setString('lastName', _lastName);
    await prefs.setString('userID', FirebaseAuth.instance.currentUser!.uid);
    return true;
  }

  Future<bool> readDatabase() async {
    if (!isLoggedIn) {
      return false;
    }
    DataSnapshot userInfo = await FirebaseDatabase.instance
        .ref("users/${FirebaseAuth.instance.currentUser!.uid}")
        .get();
    Object? firstName = userInfo.child('firstName').value;
    if (firstName == null) {
      return false;
    }
    Object? lastName = userInfo.child('lastName').value;
    if (lastName == null) {
      return false;
    }
    _firstName = firstName as String;
    _lastName = lastName as String;
    return true;
  }

  void logIn() async {
    if (!isLoggedIn) {
      return;
    }
    if (await readLocal()) {
      return;
    }
    await readDatabase();
    await writeLocal();
    notifyListeners();
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userID');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    _firstName = '';
    _lastName = '';
    notifyListeners();
  }
}
