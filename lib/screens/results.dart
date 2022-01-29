import 'package:book_recommender/common.dart';
import 'package:book_recommender/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Results')),
      body: Consumer<SearchResults>(
        builder: (context, results, child) {
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              Book book = results.get(index);
              return ExpandedListTile(book);
            },
          );
        },
      ),
      bottomNavigationBar: const MyBottomBar(MyBottomBar.results),
    );
  }
}
