import 'package:book_recommender/common/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookCollection extends ChangeNotifier {
  DatabaseReference? _dbRef;
  Map<String, Book> _books = {};

  BookCollection() : super() {
    _dbRef = FirebaseDatabase.instance
        .ref("libraries/${FirebaseAuth.instance.currentUser!.uid}");
    _dbRef!.get().then((snapshot) {
      _books = snapshot.value as Map<String, Book>;
    });
  }

  List<Book> get books => List<Book>.from(_books.values);

  int get length => _books.length;

  bool contains(Book book) {
    return _books.containsKey(book.googleId);
  }

  void add(Book book) {
    if (!contains(book)) {
      _books[book.googleId] = book;
      _dbRef!.child(book.googleId).set(book);
      notifyListeners();
    }
  }

  void remove(String googleId) {
    if (_books.containsKey(googleId)) {
      _books.remove(googleId);
      _dbRef!.child(googleId).remove();
      notifyListeners();
    }
  }
}
