import 'package:flutter/material.dart';
import 'screens/book_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book List',
      debugShowCheckedModeBanner: false,
      home: BookList(),
    );
  }
}
