import 'package:flutter/material.dart';
import '../classes/product.dart';

class ProductComments extends StatelessWidget {
  final Product product;

  const ProductComments({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PRODUCT COMMENTS',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...product.comments.entries.map((entry) {
          final commentData = entry.value;
          final userFullName =
              '${commentData['firstName']} ${commentData['lastName']}';
          final comment = commentData['comment'];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$userFullName: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(child: Text(comment!)),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
