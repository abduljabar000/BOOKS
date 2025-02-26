import 'package:flutter/material.dart';
import 'package:project_books/widgets/book_details_dailog.dart';
import 'dart:convert';
import '../models/book.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  BookListState createState() => BookListState();
}

class BookListState extends State<BookList> {
  final String bookData = '''
[
  {
    "userId": 1,
    "id": 1,
    "title": "The Great Gatsby",
    "body": "A story about the mysterious Jay Gatsby and his unrelenting love for Daisy Buchanan.",
    "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmkHKwNvkL0uA9AC7Xie-PVEImYpyLiYyN_g&s",
    "author": {
      "name": "Alice Johnson",
      "email": "alice@example.com"
    }
  },
  {
    "userId": 2,
    "id": 2,
    "title": "To Kill a Mockingbird",
    "body": "A gripping novel about racial injustice in the Deep South, seen through the eyes of Scout Finch.",
    "imageUrl": "https://www.alvahnbeldinglibrary.org/site-assets/book-images/to-kill-a-mockingbird.jpg/@@images/image.jpeg",
    "author": {
      "name": "Bob Smith",
      "email": "bob@example.com"
    }
  },
  {
    "userId": 3,
    "id": 3,
    "title": "1984",
    "body": "A dystopian novel depicting a totalitarian regime that controls every aspect of life.",
    "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxibw6d9pEQ78A-DPrxghpZIcLyqEJ7ZavJodkkrpyEEEU2MhI80cyQFXCtYfIcp7Loow&usqp=CAU",
    "author": {
      "name": "Charlie Brown",
      "email": "charlie@example.com"
    }
  },
  {
    "userId": 4,
    "id": 4,
    "title": "Pride and Prejudice",
    "body": "A romantic novel exploring the themes of love, reputation, and class distinctions.",
    "imageUrl": "https://rukminim2.flixcart.com/image/850/1000/kkec4280/book/d/h/d/pride-prejudice-original-imafzra6pfewjjwb.jpeg?q=20&crop=false",
    "author": {
      "name": "Diana Prince",
      "email": "diana@example.com"
    }
  },
  {
    "userId": 5,
    "id": 5,
    "title": "Moby-Dick",
    "body": "The thrilling tale of Captain Ahab's obsessive quest to hunt the great white whale.",
    "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl4pxbBl0oV5KqSOYnRjZmM-pE--gntwggGw&s",
    "author": {
      "name": "Ethan Hunt",
      "email": "ethan@example.com"
    }
  },
  {
    "userId": 6,
    "id": 6,
    "title": "The Hobbit",
    "body": "A fantastical journey of Bilbo Baggins as he sets off on an adventure with dwarves.",
    "imageUrl": "https://upload.wikimedia.org/wikipedia/en/b/b3/The_Hobbit-_An_Unexpected_Journey.jpeg",
    "author": {
      "name": "Fiona Gallagher",
      "email": "fiona@example.com"
    }
  },
  {
    "userId": 7,
    "id": 7,
    "title": "War and Peace",
    "body": "An epic historical novel that intertwines the lives of five families during the Napoleonic Wars.",
    "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXlBdgOc4kUHOboqtlcS91SLy--JYj2N9zEg&s",
    "author": {
      "name": "George Lucas",
      "email": "george@example.com"
    }
  },
  {
    "userId": 8,
    "id": 8,
    "title": "The Catcher in the Rye",
    "body": "A coming-of-age novel following the experiences of the rebellious Holden Caulfield.",
    "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM4NToGqFGG0WzWr58n9i_zcGehrIrbU1Saw&s",
    "author": {
      "name": "Hannah Baker",
      "email": "hannah@example.com"
    }
  },
  {
    "userId": 9,
    "id": 9,
    "title": "Brave New World",
    "body": "A futuristic novel that explores a world of genetic engineering and mind control.",
    "imageUrl": "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1685133828i/162412555.jpg",
    "author": {
      "name": "Ian Malcolm",
      "email": "ian@example.com"
    }
  },
  {
    "userId": 10,
    "id": 10,
    "title": "Frankenstein",
    "body": "A gothic novel about a scientist who creates a living creature, leading to unforeseen consequences.",
    "imageUrl": "https://rukminim2.flixcart.com/image/750/900/xif0q/book/n/j/v/frankenstein-original-imahfj8e5nqsgmta.jpeg?q=20&crop=false",
    "author": {
      "name": "Jessica Jones",
      "email": "jessica@example.com"
    }
  }
]
''';

  List<Book> books = [];
  List<Book> filteredBooks = [];
  final TextEditingController searchController = TextEditingController();
  String selectedAuthor = 'All';

  @override
  void initState() {
    super.initState();
    List<dynamic> jsonList = jsonDecode(bookData);
    books = jsonList.map((json) => Book.fromJson(json)).toList();
    filteredBooks = books;
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks =
          books.where((book) {
            final titleLower = book.title.toLowerCase();
            final searchLower = query.toLowerCase();
            return titleLower.contains(searchLower);
          }).toList();
    });
  }

  void filterByAuthor(String author) {
    setState(() {
      selectedAuthor = author;
      filteredBooks =
          author == 'All'
              ? books
              : books.where((book) => book.author.name == author).toList();
    });
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter by Author'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedAuthor,
                items:
                    [
                      'All',
                      ...books.map((book) => book.author.name).toSet(),
                    ].map((author) {
                      return DropdownMenuItem(
                        value: author,
                        child: Text(author),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    filterByAuthor(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showBookDetails(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) => BookDetailsDialog(book: book),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 27, 62, 216), // Deep Pink
                Color.fromARGB(255, 255, 236, 128), // Light Pink
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.library_books, size: 30, color: Colors.white),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Book Library",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ],
              ),
            ),
            Text(
              "${filteredBooks.length} Books Available",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              showFilterDialog();
            },
          ),
        ],
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search books...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 233, 44, 30),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 71, 233, 30),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 255, 64, 64),
                  ),
                ),
              ),
              onChanged: filterBooks,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 230, 228, 252),
                    const Color.fromARGB(255, 209, 248, 187),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    elevation: 8,
                    shadowColor: const Color.fromARGB(255, 255, 64, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => showBookDetails(context, book),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.pink[50]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Book Cover Image with shadow
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                        255,
                                        233,
                                        30,
                                        30,
                                        // ignore: deprecated_member_use
                                      ).withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    book.imageUrl,
                                    width: 90,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 90,
                                        height: 130,
                                        color: const Color.fromARGB(
                                          255,
                                          208,
                                          187,
                                          248,
                                        ),
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 40,
                                          color: Color.fromARGB(
                                            255,
                                            125,
                                            30,
                                            233,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 64, 64),
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "By ${book.author.name}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: const Color.fromARGB(
                                          255,
                                          194,
                                          24,
                                          24,
                                        ),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      book.body,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                          255,
                                          136,
                                          14,
                                          14,
                                        ),
                                        height: 1.3,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
