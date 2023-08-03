// product_details_screen.dart

import 'package:flutter/material.dart';
import 'product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Center(
        child: Text("Price: \$${product.price}"),
      ),
    );
  }
}
