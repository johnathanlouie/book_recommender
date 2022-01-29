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

  void logIn() async {
    if (!isLoggedIn) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser?.uid == prefs.getString('userID')) {
      _firstName = prefs.getString('firstName') ?? 'nullFN';
      _lastName = prefs.getString('lastName') ?? 'nullLN';
    } else {
      DataSnapshot userInfo = await FirebaseDatabase.instance
          .ref("users/${FirebaseAuth.instance.currentUser!.uid}")
          .get();
      _firstName = userInfo.child('firstName').value as String? ?? 'null';
      _lastName = userInfo.child('lastName').value as String? ?? 'null';
      await prefs.setString('firstName', _firstName);
      await prefs.setString('lastName', _lastName);
      await prefs.setString('userID', FirebaseAuth.instance.currentUser!.uid);
    }
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
