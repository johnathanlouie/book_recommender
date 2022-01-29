import 'package:book_recommender/screens/account.dart';
import 'package:book_recommender/screens/library.dart';
import 'package:book_recommender/screens/results.dart';
import 'package:book_recommender/screens/search.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  static const int library = 0;
  static const int search = 1;
  static const int results = 2;
  static const int account = 3;
  final int currentIndex;

  const MyBottomBar(this.currentIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.book),
            onPressed: () {
              if (currentIndex != library) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return LibraryScreen();
                  }),
                );
              }
            },
          ),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (currentIndex != search) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return SearchScreen();
                  }),
                );
              }
            },
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.saved_search),
            onPressed: () {
              if (currentIndex != results) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ResultsScreen();
                  }),
                );
              }
            },
          ),
          label: 'Results',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.account_box),
            onPressed: () {
              if (currentIndex != account) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return AccountScreen();
                  }),
                );
              }
            },
          ),
          label: 'Account',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
