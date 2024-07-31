import 'package:belajar_layouting/model/product_model.dart';
import 'package:belajar_layouting/widgets/detail_information.dart';
import 'package:belajar_layouting/dialog/dialog_cart.dart';
import 'package:belajar_layouting/widgets/review_product.dart';
import 'package:flutter/material.dart';

class DetailProduct extends StatelessWidget {
  final Product product;

  const DetailProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Product",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: const DialogCart(),
      body: ListView(
        children: [
          DetailInformation(product: product),
          ReviewProduct(product: product),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
