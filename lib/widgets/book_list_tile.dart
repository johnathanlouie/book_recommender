import 'package:book_recommender/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListTile extends StatefulWidget {
  final Book _book;

  const BookListTile(this._book, {Key? key}) : super(key: key);

  @override
  _BookListTileState createState() => _BookListTileState();
}

class _BookListTileState extends State<BookListTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      isThreeLine: true,
      leading: Image.network(widget._book.thumbnail),
      title: Text(widget._book.title),
      subtitle: Text(
        widget._book.author.join(', ') + '\n' + widget._book.description,
        overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
      trailing: Consumer<BookCollection>(
        builder: (context, books, child2) {
          return IconButton(
            icon: books.contains(widget._book)
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border_outlined),
            onPressed: () {
              if (books.contains(widget._book)) {
                books.remove(widget._book.googleId);
              } else {
                books.add(widget._book);
              }
            },
          );
        },
      ),
    );
  }
}
