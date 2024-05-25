import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../classes/product.dart';
import './relatedProductsList.dart';
import '../providers/productsProvider.dart';
import 'package:provider/provider.dart';
import '../providers/authenticationProvider.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;

  double calculateAverageRating() {
    if (widget.product.ratings.isEmpty) {
      return 0;
    }
    double total = 0;
    widget.product.ratings.values.forEach((rating) {
      total += rating.toDouble();
    });
    return (total / widget.product.ratings.length);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();

    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
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
                      widget.product.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'EGP ${widget.product.price}',
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
                      'Vendor: ${widget.product.createdVendor}',
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
                    widget.product.description,
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
                  'Rating',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: RatingBar.builder(
                  initialRating: calculateAverageRating(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              const Divider(color: Colors.grey),
              if (authProvider.isAuthenticated)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rate and Review',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _commentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Write your review here...',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final comment = _commentController.text;
                        if (comment.isNotEmpty) {
                          Provider.of<ProductProvider>(context, listen: false)
                              .addCommentToProduct(
                            widget.product,
                            comment,
                            'userId', // Replace with actual userId
                            'FirstName', // Replace with actual firstName
                            'LastName', // Replace with actual lastName
                            _rating,
                          );
                          _commentController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Review and Rating added successfully!'),
                            ),
                          );
                        }
                      },
                      child: const Text('Submit Review'),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
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
                productId: widget.product.productId,
                subCategory: widget.product.subcategory,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
