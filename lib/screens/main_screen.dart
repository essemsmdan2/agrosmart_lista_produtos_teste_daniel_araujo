import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firebase_repository.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FireStorageHandler>(
            builder: (BuildContext context, products, Widget? child) {
          return products.listaProdutosFirestore.isEmpty
              ? const ListTile(
                  leading: Icon(Icons.remove_shopping_cart_rounded),
                  title: Text('Ainda não há Produtos'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, int index) {
                    return Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.blueGrey, width: 2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        // ignore: prefer_interpolation_to_compose_strings
                                        image: AssetImage("images/" +
                                            products
                                                .listaProdutosFirestore[index]
                                                .filename)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Wrap(
                                        runSpacing: 5,
                                        children: [
                                          Material(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                            color: Colors.lightBlueAccent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                products
                                                    .listaProdutosFirestore[
                                                        index]
                                                    .title,
                                                style: kTextsInfo,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Material(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                            color: Colors.lightBlueAccent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                products
                                                    .listaProdutosFirestore[
                                                        index]
                                                    .type,
                                                style: kTextsInfo,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Material(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      color: Colors.lightBlueAccent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Created Implementar",
                                          style: kTextsInfo,
                                        ),
                                      ),
                                    ),
                                    RatingBar.builder(
                                      itemSize: 25,
                                      initialRating: products
                                          .listaProdutosFirestore[index].rating
                                          .toDouble(),
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.more_horiz,
                                  size: 40,
                                ),
                                Text(
                                  "R\$${products.listaProdutosFirestore[index].price}",
                                  style: kTextsInfo.copyWith(
                                      fontSize: 18,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: products.listaProdutosFirestore.length);
        }),
      ),
    );
  }
}
