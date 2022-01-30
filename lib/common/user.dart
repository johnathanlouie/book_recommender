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

  Future<bool> _readLocal() async {
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

  Future<void> _writeLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', _firstName);
    await prefs.setString('lastName', _lastName);
    await prefs.setString('userID', FirebaseAuth.instance.currentUser!.uid);
  }

  Future<bool> _readDatabase() async {
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

  Future<void> _writeDatabase() async {
    await FirebaseDatabase.instance
        .ref()
        .child("users/${FirebaseAuth.instance.currentUser!.uid}")
        .set({
      'firstName': _firstName,
      'lastName': _lastName,
    });
  }

  Future<bool> register(String firstName, String lastName) async {
    if (!isLoggedIn || firstName == '' || lastName == '') {
      return false;
    }
    _firstName = firstName;
    _lastName = lastName;
    await _writeLocal();
    await _writeDatabase();
    return true;
  }

  Future<void> logIn() async {
    if (!isLoggedIn) {
      return;
    }
    if (!await _readLocal()) {
      if (!await _readDatabase()) {
        return;
      }
      await _writeLocal();
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    if (await (await SharedPreferences.getInstance()).clear()) {
      _firstName = '';
      _lastName = '';
      notifyListeners();
    }
  }
}
