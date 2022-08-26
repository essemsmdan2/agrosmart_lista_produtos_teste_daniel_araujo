import 'package:agrosmart_lista_produtos_teste_daniel_araujo/produtos_agrosmart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/produto_model.dart';

class FireStorageHandler extends ChangeNotifier {
  FireStorageHandler() {
    _startLista();
  }
  _startLista() async {
    _listaProdutosFirestore = await getUpdatedFireStorageProducts;
  }

  //instancia Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // instancia Firestore até a collection
  CollectionReference _firestorageCollectionAgroSmartProdutos =
      FirebaseFirestore.instance.collection('agrosmart_produtos');

  remove(Produto produto) async {
    await _firestorageCollectionAgroSmartProdutos
        .doc(produto.filename)
        .delete();
    _listaProdutosFirestore.remove(produto);
    notifyListeners();
  }

  //envia produtos para o banco de dados da loja
  Future<void> EnviaProdutosParaBancoFirebase(
      List<Produto> listaProdutosAgrosmart) async {
    try {
      for (final produto in listaProdutosAgrosmart) {
        if (!_listaProdutosFirestore
            .any((atual) => atual.filename == produto.filename)) {
          _listaProdutosFirestore.add(produto);
        }
        ;
      }
    } catch (e) {
      print(e);
    }
  }

  List<Produto> _listaProdutosFirestore = [];

  List<Produto> get listaProdutosFirestore => _listaProdutosFirestore;

  // retorna os produtos disponíveis na loja/banco de dados
  Future<List<Produto>> get getUpdatedFireStorageProducts async {
    final agroSmartProductsFromGet =
        await _firestorageCollectionAgroSmartProdutos.get();
    agroSmartProductsFromGet.docs.forEach((doc) {
      Produto produto = ProdutosAgroSmart.MappedListaProdutos.firstWhere(
          (produto) => produto.filename == doc.get("filename"));
      _listaProdutosFirestore.add(produto);

      notifyListeners();
    });

    return _listaProdutosFirestore;
  }
}
