import 'package:book_recommender/common.dart';
import 'package:book_recommender/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Library')),
      body: Consumer<BookCollection>(
        builder: (context, collection, child) {
          return ListView.builder(
            itemCount: collection.length,
            itemBuilder: (context, index) {
              Book book = collection.get(index);
              return ExpandedListTile(book);
            },
          );
        },
      ),
      bottomNavigationBar: const MyBottomBar(MyBottomBar.library),
    );
  }
}
