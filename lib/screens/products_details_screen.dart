import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/produto_model.dart';

class ProductsDetailsScreen extends StatelessWidget {
  Produto produto;
  ProductsDetailsScreen({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Edit - ${produto.title}"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyCustomForm(
            produto: produto,
          ),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  Produto produto;
  MyCustomForm({super.key, required this.produto});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  RegExp _regExp = RegExp(r'^[0-9]+$');
  late String? title;
  late String? type;
  late String? price;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onSaved: (value) => title = value,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the new "Title"',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            onSaved: (value) => type = value,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the new "Type"',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            onSaved: (value) => price = value,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the new "Price"',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || !_regExp.hasMatch(value)) {
                return 'Please enter some number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  Provider.of<FireStorageHandler>(context, listen: false)
                      .atualizaValorProduto(
                          widget.produto, title!, type!, price!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
