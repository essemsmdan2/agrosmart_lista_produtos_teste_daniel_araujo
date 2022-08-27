class Produto {
  String filename;
  String title;
  String description;

  String type;
  int rating;
  double price;
  dynamic created;

  Produto(
      {required this.filename,
      required this.description,
      required this.created,
      required this.price,
      required this.rating,
      required this.title,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "created": DateTime.now(),
      "type": type,
      "description": description,
      "filename": filename,
      "price": price,
      "rating": rating,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
        filename: map["filename"],
        created: map["created"],
        description: map["description"],
        price: map["price"].toDouble(),
        rating: map["rating"],
        title: map["title"],
        type: map["type"]);
  }
}
