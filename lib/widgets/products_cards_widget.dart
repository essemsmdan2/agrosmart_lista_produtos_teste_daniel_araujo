import 'package:agrosmart_lista_produtos_teste_daniel_araujo/screens/products_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants.dart';
import '../models/produto_model.dart';

class ProductCard extends StatefulWidget {
  Produto produto;

  ProductCard({Key? key, required this.produto}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductsDetailsScreen(
          produto: widget.produto,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.blueGrey, width: 2),
      ),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.produto.url,
                  width: MediaQuery.of(context).size.width / 3.1,
                  height: MediaQuery.of(context).size.height / 6.6,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              MyCustomChip(
                                produtoParametro: widget.produto.title,
                              ),
                              MyCustomChip(produtoParametro: widget.produto.type),
                              MyCustomChip(produtoParametro: widget.produto.description),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: FittedBox(
                          child: RatingBar.builder(
                            itemSize: 25,
                            initialRating: widget.produto.rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blueAccent,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  abrirDetalhes();
                },
                child: Icon(
                  Icons.more_horiz,
                  size: 40,
                ),
              ),
              Text(
                "R\$${widget.produto.price.toStringAsFixed(2)}",
                style: kTextsInfo.copyWith(
                    fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyCustomChip extends StatelessWidget {
  String produtoParametro;
  MyCustomChip({Key? key, required this.produtoParametro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          produtoParametro,
          style: kTextsInfo,
        ),
      ),
    );
  }
}
