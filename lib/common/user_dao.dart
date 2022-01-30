import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tuple/tuple.dart';

class UserDao {

  static Future<void> set(String firstName, String lastName) async {
    return await FirebaseDatabase.instance
        .ref()
        .child("users/${FirebaseAuth.instance.currentUser!.uid}")
        .set({
      'firstName': firstName,
      'lastName': lastName,
    });
  }
}
