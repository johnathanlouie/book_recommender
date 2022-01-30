import 'package:book_recommender/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

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
      Tuple2<String, String> name = await UserDao.get();
      _firstName = name.item1;
      _lastName = name.item2;
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
