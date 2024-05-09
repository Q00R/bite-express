import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/product.dart';
import '../providers/productsProvider.dart';
import '../widgets/productCard.dart';

class RelatedProductsList extends StatefulWidget {
  final String productId;
  final String subCategory;

  const RelatedProductsList(
      {Key? key, required this.subCategory, required this.productId})
      : super(key: key);

  @override
  State<RelatedProductsList> createState() => _RelatedProductsListState();
}

class _RelatedProductsListState extends State<RelatedProductsList> {
  @override
  Widget build(BuildContext context) {
    final List<Product> relatedProducts = Provider.of<ProductProvider>(context)
        .getProductsBySubCategory(widget.productId, widget.subCategory);

    if (relatedProducts.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text('No related products'),
        ),
      );
    }

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: relatedProducts.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProductCard(
                product: relatedProducts[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
