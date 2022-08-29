import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/produtos_agrosmart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../models/produto_model.dart';

class FirestoreRepository extends ChangeNotifier {
  List<Produto> _listaProdutosFirestore = [];
  List<Produto> get listaProdutosFirestore => _listaProdutosFirestore;

  FirestoreRepository() {
    _startUpdateProdutosLoja();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference _firestorageCollectionAgroSmartProdutos =
      FirebaseFirestore.instance.collection('agrosmart_produtos');

  _startUpdateProdutosLoja() async {
    _firestorageCollectionAgroSmartProdutos.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        Map<String, dynamic> map = change.doc.data()! as Map<String, dynamic>;
        Produto produto = Produto.fromMap(map);
        if (change.type == DocumentChangeType.added) {
          _listaProdutosFirestore.add(produto);
        } else if (change.type == DocumentChangeType.modified) {
          int index =
              _listaProdutosFirestore.indexWhere((element) => element.filename == produto.filename);
          if (index < 0) {
            _listaProdutosFirestore.add(produto);
          } else {
            _listaProdutosFirestore[index] = produto;
          }
        } else if (change.type == DocumentChangeType.removed) {
          _listaProdutosFirestore.removeWhere((element) => element.filename == produto.filename);
        }
      }
      notifyListeners();
    });
  }

  atualizaValorProduto(Produto produto, String title, String type, String price) async {
    await _firestorageCollectionAgroSmartProdutos
        .doc(produto.filename)
        .update({"title": title, "type": type, "price": double.parse(price)});
    notifyListeners();
  }

  removeProduto(Produto produto) async {
    await _firestorageCollectionAgroSmartProdutos.doc(produto.filename).delete();
    _listaProdutosFirestore.remove(produto);
    notifyListeners();
  }

  //usado unicamente para enviar o json do teste para a storage
  Future<void> enviaProdutosParaBancoFirebase() async {
    List<Produto> listaProdutosAgrosmart = ProdutosAgroSmart.MappedListaProdutos;
    try {
      for (final Produto produto in listaProdutosAgrosmart) {
        _firestorageCollectionAgroSmartProdutos.doc(produto.filename).set(produto.toMap());
      }
    } catch (e) {
      print(e);
    }
  }
}
