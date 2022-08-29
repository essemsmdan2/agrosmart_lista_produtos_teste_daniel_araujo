import 'package:agrosmart_lista_produtos_teste_daniel_araujo/services/firestorage_service.dart';

class Produto {
  String filename;
  String title;
  String description;
  String type;
  int rating;
  double price;
  dynamic created;
  String url;

  Produto(
      {required this.filename,
      required this.description,
      required this.created,
      required this.price,
      required this.rating,
      required this.title,
      required this.type,
      required this.url});

  Future<Map<String, dynamic>> toMap() async {
    return {
      "title": title,
      "url": await FireStorageService.loadRepositoryReturnUrlRepository(filename),
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
        url: map["url"],
        filename: map["filename"],
        created: map["created"],
        description: map["description"],
        price: map["price"].toDouble(),
        rating: map["rating"],
        title: map["title"],
        type: map["type"]);
  }
  factory Produto.fromMapTest(Map<String, dynamic> map) {
    return Produto(
        url: "test",
        filename: map["filename"],
        created: map["created"],
        description: map["description"],
        price: map["price"].toDouble(),
        rating: map["rating"],
        title: map["title"],
        type: map["type"]);
  }
}
