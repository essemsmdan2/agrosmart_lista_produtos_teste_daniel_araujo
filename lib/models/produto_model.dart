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
}
