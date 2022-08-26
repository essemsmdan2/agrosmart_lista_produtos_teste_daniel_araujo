import 'package:agrosmart_lista_produtos_teste_daniel_araujo/produtos_agrosmart.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firebase_repository.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/products_cards_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    FireStorageHandler()
        .EnviaProdutosParaBancoFirebase(ProdutosAgroSmart.MappedListaProdutos);
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
                    return ProductsCards(products: products, index: index);
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: products.listaProdutosFirestore.length);
        }),
      ),
    );
  }
}
