// admin_data_creation_screen.dart

import 'package:flutter/material.dart';
import 'product.dart';
import 'user_data_selection_screen.dart';

class AdminDataCreationScreen extends StatefulWidget {
  const AdminDataCreationScreen({super.key});

  @override
  _AdminDataCreationScreenState createState() =>
      _AdminDataCreationScreenState();
}

class _AdminDataCreationScreenState extends State<AdminDataCreationScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  List<Product> admin_products = [];

  void addProduct() {
    String name = productNameController.text;
    double price = double.tryParse(productPriceController.text) ?? 0.0;

    if (name.isNotEmpty && price > 0) {
      setState(() {
        admin_products.add(Product(name: name, price: price));
      });
      productNameController.clear();
      productPriceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Data Creation")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: productNameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextFormField(
              controller: productPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Product Price"),
            ),
            ElevatedButton(
              onPressed: addProduct,
              child: const Text("Add Product"),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: admin_products.length,
              itemBuilder: (context, index) {
                final product = admin_products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("Price: \$${product.price}"),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDataSelectionScreen(
                            user_products: admin_products,
                          )),
                );
              },
              // Call the function to navigate
              child: const Text("Continue to User Selection"),
            ),
          ],
        ),
      ),
    );
  }
}
