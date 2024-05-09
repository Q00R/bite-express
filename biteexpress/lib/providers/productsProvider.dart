import 'package:flutter/material.dart';
import '../classes/product.dart';
import '../productsMockData.dart';

class ProductProvider extends ChangeNotifier {
  // This will simulate the database of products
  final List<Product> _products = [];

  // Function to fetch products from mock data
  // void fetchProducts() {
  //   _products.clear();

  //   products.forEach((productId, productData) {
  //     _products.add(Product(
  //       productId: productId,
  //       title: productData['title'],
  //       description: productData['description'],
  //       category: productData['category'],
  //       subcategory: productData['subCategory'],
  //       price: productData['price'],
  //       createdVendor: productData['createdVendor'],
  //       image: productData['image'],
  //       ratings: Map<String, int>.from(productData['ratings']),
  //       comments:
  //           Map<String, Map<String, String>>.from(productData['comments']),
  //     ));
  //   });
  //   notifyListeners();
  // }

  Future<void> fetchProducts() async {
    _products.clear();

    for (var entry in products.entries) {
      final productId = entry.key;
      final productData = entry.value;
      await Future.delayed(
          Duration.zero); // Ensure each iteration is asynchronous
      _products.add(Product(
        productId: productId,
        title: productData['title'],
        description: productData['description'],
        category: productData['category'],
        subcategory: productData['subCategory'],
        price: productData['price'],
        createdVendor: productData['createdVendor'],
        image: productData['image'],
        ratings: Map<String, int>.from(productData['ratings']),
        comments:
            Map<String, Map<String, String>>.from(productData['comments']),
      ));
    }

    notifyListeners();
  }

  List<Product> get getAllProducts {
    return [..._products];
  }

  // Method to get products by category
  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // Method to get products by keyword
  // List<Product> getProductsByKeyword(String keyword) {
  //   return _products.where((product) {
  //     return product.title.contains(keyword) ||
  //         product.description.contains(keyword) ||
  //         product.category.contains(keyword) ||
  //         product.subcategory.contains(keyword) ||
  //         product.createdVendor.contains(keyword) ||
  //         product.category.contains(keyword) ||
  //         product.subcategory.contains(keyword) ||
  //         product.price.contains(keyword);
  //   }).toList();
  // }

// Method to get products by keyword, price range, and rating range
  List<Product> getProductsByKeyword(String keyword,
      {double priceFrom = 0,
      double priceTo = double.infinity,
      int minRating = 1,
      int maxRating = 5}) {
    // Step 1: Filter by keyword
    List<Product> filteredProducts = _products.where((product) {
      return product.title.contains(keyword) ||
          product.description.contains(keyword) ||
          product.category.contains(keyword) ||
          product.subcategory.contains(keyword) ||
          product.createdVendor.contains(keyword) ||
          product.category.contains(keyword) ||
          product.subcategory.contains(keyword) ||
          product.price.toString().contains(keyword);
    }).toList();
    // If no products match the keyword, return an empty list
    if (filteredProducts.isEmpty) {
      return [];
    }

    // Step 2: Filter by price range
    filteredProducts = filteredProducts.where((product) {
      return double.parse(product.price) >= priceFrom &&
          double.parse(product.price) <= priceTo;
    }).toList();

    // If no products are in the price range, return an empty list
    if (filteredProducts.isEmpty) {
      return [];
    }

    // Step 3: Filter by rating range
    filteredProducts = filteredProducts.where((product) {
      double averageRating = 1;
      if (product.ratings.values.isNotEmpty) {
        averageRating = product.ratings.values.reduce((a, b) => a + b) /
            product.ratings.values.length;
      }
      return averageRating >= minRating && averageRating <= maxRating;
    }).toList();

    return filteredProducts;
  }
}
