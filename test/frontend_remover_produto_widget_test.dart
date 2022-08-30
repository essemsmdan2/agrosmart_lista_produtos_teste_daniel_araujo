import 'package:agrosmart_lista_produtos_teste_daniel_araujo/models/produto_model.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/produtos_agrosmart.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("verifica a remoção do produto", (WidgetTester tester) async {
    //find widgets needed
    final deleteButton = find.byKey(const ValueKey("deleteButton"));
    final alertDialog = find.byKey(const ValueKey("alertDialog"));

    //execute the actual test
    await tester.pumpWidget(MaterialApp(
      home: ProductsDetailsScreen(
        produto: ProdutosAgroSmart.mappedListaProdutosTest[0],
      ),
    ));
    await tester.tap(deleteButton);
    await tester.pump(const Duration(seconds: 2));
//check outputs
    expect(alertDialog, findsOneWidget);
  });
}
