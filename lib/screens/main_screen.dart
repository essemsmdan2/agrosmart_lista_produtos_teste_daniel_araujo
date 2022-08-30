import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    //reseta os produtos da loja para padrão
    //FirestoreRepository(firestore: FirebaseFirestore.instance).enviaProdutosParaBancoFirebase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Consumer<FirestoreRepository>(builder: (BuildContext context, products, Widget? child) {
          return products.listaProdutosFirestore.isEmpty
              ? const ListTile(
                  leading: Icon(Icons.remove_shopping_cart_rounded),
                  title: Text('Ainda não há Produtos'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, int index) {
                    return ProductCard(
                      key: const Key("productCards"),
                      produto: products.listaProdutosFirestore[index],
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: products.listaProdutosFirestore.length);
        }),
      ),
    );
  }
}
