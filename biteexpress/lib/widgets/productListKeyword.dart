import 'package:flutter/material.dart';
import './productCard.dart';
import '../classes/product.dart';

class ProductListKeyword extends StatelessWidget {
  final List<Product> filteredProducts;

  const ProductListKeyword({
    Key? key,
    required this.filteredProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filteredProducts.isEmpty) {
      return const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('No products found '),
            Icon(
              Icons.sentiment_dissatisfied,
              color: Color.fromARGB(255, 255, 122, 70),
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 4 / 6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: filteredProducts[index],
            );
          },
        ),
      ),
    );
  }
}
