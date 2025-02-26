import 'author.dart';

class Book {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String imageUrl;
  final Author author;

  Book({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['imageUrl'],
      author: Author.fromJson(json['author']),
    );
  }
}
