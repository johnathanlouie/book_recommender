class Book {
  String googleId;
  String title;
  List<String> author;
  String description;
  String publishedDate;
  String genre;
  double rating;
  String thumbnail;

  Book(this.googleId, this.title, this.author, this.description,
      this.publishedDate, this.genre, this.rating, this.thumbnail);

  bool equals(Book other) {
    return (other.googleId == googleId);
  }

  static Book fromGoogle(Map<String, dynamic> google) {
    double rating = 0.0;
    if (google['volumeInfo']['averageRating'] != null) {
      rating = google['volumeInfo']['averageRating'].toDouble();
    }
    return Book(
      google['id'],
      google['volumeInfo']['title'],
      List<String>.from(google['volumeInfo']['authors'] ?? []),
      google['volumeInfo']['description'] ?? '',
      google['volumeInfo']['publishedDate'],
      google['volumeInfo']['mainCategory'] ?? '',
      rating,
      google['volumeInfo']['imageLinks']['thumbnail'],
    );
  }
}
