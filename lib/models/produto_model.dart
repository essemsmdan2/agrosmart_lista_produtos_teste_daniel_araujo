class Produto {
  String filename;
  String title;
  String description;

  String type;
  int rating;
  double price;
  //dynamic Created (Data do upload do produto a nova base de datos);

  Produto(
      {required this.filename,
      required this.description,
      required this.price,
      required this.rating,
      required this.title,
      required this.type});
}
