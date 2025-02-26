import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailsDialog extends StatelessWidget {
  final Book book;

  const BookDetailsDialog({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: const Color.fromARGB(255, 237, 228, 252),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Book Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      125,
                      30,
                      233,
                    ).withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  book.imageUrl,
                  width: 120,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 160,
                      color: const Color.fromARGB(255, 187, 241, 248),
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Color.fromARGB(255, 156, 255, 64),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Book Title
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 118, 255, 64),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Author Name
            Text(
              "By: ${book.author.name}",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 78, 194, 24),
              ),
            ),
            Text(
              "Email: ${book.author.email}",
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 59, 136, 14),
              ),
            ),
            const SizedBox(height: 10),

            // Book Description
            Text(
              book.body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 20, 173, 20),
              ),
            ),
            const SizedBox(height: 16),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 4,
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
