import 'package:book_recommender/common.dart' as common;
import 'package:book_recommender/screens.dart';
import 'package:book_recommender/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Consumer<common.User>(builder: (context, user, child) {
        return Column(
          children: [
            Text(
              "Hello ${user.firstName} ${user.lastName}!",
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  FirebaseAuth.instance.signOut();
                  user.logOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } catch (e) {
                  // TODO: Add real error handling.
                  print(e);
                }
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      }),
      bottomNavigationBar: const MyBottomBar(MyBottomBar.account),
    );
  }
}
