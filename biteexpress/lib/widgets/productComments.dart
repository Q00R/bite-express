import 'package:flutter/material.dart';
import '../classes/product.dart';
import '../providers/productsProvider.dart';
import 'package:provider/provider.dart';

class ProductComments extends StatefulWidget {
  final Product product;

  const ProductComments({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductComments> createState() => _ProductCommentsState();
}

class _ProductCommentsState extends State<ProductComments> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final comments = productProvider.getCommentsById(widget.product.productId);

    if (comments.isEmpty) {
      return const Center(
        child: Text('No comments found'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'PRODUCT REVIEWS',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        ...comments.entries.map((entry) {
          final commentData = entry.value;
          final userFullName =
              '${commentData['firstName']} ${commentData['lastName']}';
          final comment = commentData['comment'];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(
              userFullName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(comment!),
          );
        }).toList(),
      ],
    );
  }
}
