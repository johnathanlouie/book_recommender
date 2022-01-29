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
              Book book = results.books[index];
              return ListTile(
                leading: Image.network(book.thumbnail),
                title: Text(book.title),
                subtitle: Text(book.description),
                trailing: Consumer<BookCollection>(
                  builder: (context, books, child2) {
                    return IconButton(
                      icon: books.contains(book)
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_border_outlined),
                      onPressed: () {
                        if (books.contains(book)) {
                          books.removeBook(book.googleId);
                        } else {
                          books.addBook(book);
                        }
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const MyBottomBar(MyBottomBar.results),
    );
  }
}
