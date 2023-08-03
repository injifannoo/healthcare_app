// user_data_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:healthcare_app/admin_create_user_select/admin_data_creation_screen.dart';
import 'package:healthcare_app/admin_create_user_select/product_details_screen.dart';
import 'product.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'product.dart';

class UserDataSelectionScreen extends StatefulWidget {
  final List<Product> user_products;

  const UserDataSelectionScreen({super.key, required this.user_products});

  @override
  State<UserDataSelectionScreen> createState() =>
      _UserDataSelectionScreenState();
}

class _UserDataSelectionScreenState extends State<UserDataSelectionScreen> {
  String selectedSlot = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Data Selection")),
        body: ListView.builder(
          itemCount: widget.user_products.length,
          itemBuilder: (context, index) {
            final product = widget.user_products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text("Price: \$${product.price}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: product),
                  ),
                );
              },
            );
          },
        ));
  }
}
