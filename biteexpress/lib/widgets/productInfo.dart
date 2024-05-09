import 'package:flutter/material.dart';
import '../classes/product.dart';
import './relatedProductsList.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'EGP ${product.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 255, 85, 0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vendor: ${product.createdVendor}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'In Stock',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 167, 17),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Related Products',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          RelatedProductsList(
            productId: product.productId,
            subCategory: product.subcategory,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
