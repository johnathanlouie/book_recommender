import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tuple/tuple.dart';

class UserDao {
  static Future<Tuple2<String, String>> get() async {
    DataSnapshot userInfo = await FirebaseDatabase.instance
        .ref("users/${FirebaseAuth.instance.currentUser!.uid}")
        .get();
    String firstName = userInfo.child('firstName').value as String? ?? 'null';
    String lastName = userInfo.child('lastName').value as String? ?? 'null';
    return Tuple2<String, String>(firstName, lastName);
  }

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
