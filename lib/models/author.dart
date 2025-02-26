class Author {
  final String name;
  final String email;

  Author({required this.name, required this.email});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(name: json['name'], email: json['email']);
  }
}
