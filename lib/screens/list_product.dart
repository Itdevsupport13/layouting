import 'package:belajar_layouting/dialog/encrypt_dialog.dart';
import 'package:belajar_layouting/provider/cart_provider.dart';
import 'package:belajar_layouting/screens/cart_screen.dart';
import 'package:belajar_layouting/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "List Product",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Badge(
                  label: Text(
                    value.getCounter().toString(),
                    textAlign: TextAlign.start,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()),
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: const EncryptDialog(),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, data) {
          if (data.hasError) {
            return Center(
              child: Text("${data.error}"),
            );
          } else if (data.hasData) {
            var products = data.data as List<Product>;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: ProductItem(product: product),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
