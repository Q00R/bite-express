import 'package:flutter/material.dart';
import '../widgets/productListCategory.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(categoryName),
        centerTitle: true,
      ),
      body: ProductListCategory(categoryName: categoryName),
    );
  }
}
