class Book {
  String googleId;
  String title;
  List<String> author;
  String description;
  DateTime publishedDate;
  String genre;
  double rating;
  String thumbnail;

  Book(this.googleId, this.title, this.author, this.description,
      this.publishedDate, this.genre, this.rating, this.thumbnail);

  bool equals(Book other) {
    return (other.googleId == googleId);
  }

  static Book fromGoogle(Map google) {
    return Book(
      google['id'],
      google['volumeInfo']['title'],
      google['volumeInfo']['authors'],
      google['volumeInfo']['description'],
      DateTime(google['publishedDate']),
      google['volumeInfo']['mainCategory'],
      google['volumeInfo']['averageRating'],
      google['volumeInfo']['imageLinks']['thumbnail'],
    );
  }
}
