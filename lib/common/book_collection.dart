import 'package:book_recommender/common/book.dart';
import 'package:flutter/material.dart';

class BookCollection extends ChangeNotifier {
  final List<Book> _books = [];

  List<Book> get books => _books;

  Book get(int index) {
    return _books[index];
  }

  int get length => _books.length;

  bool contains(Book book) {
    for (Book b in _books) {
      if (book.equals(b)) {
        return true;
      }
    }
    return false;
  }

  void add(Book book) {
    if (!contains(book)) {
      _books.add(book);
      notifyListeners();
    }
  }

  void remove(String googleId) {
    for (Book b in _books) {
      if (b.googleId == googleId) {
        _books.remove(b);
        notifyListeners();
      }
    }
  }
}
