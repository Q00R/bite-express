import 'package:flutter/material.dart';
import '../classes/product.dart';
import '../productsMockData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  final productsUrl = Uri.parse(
      'https://bite-express-b3634-default-rtdb.firebaseio.com/products.json');

  // Method to fetch products from database.
  Future<void> fetchProducts() async {
    try {
      var response = await http.get(productsUrl);
      var fetchedData = json.decode(response.body) as Map<String, dynamic>;
      _products.clear();

      fetchedData.forEach((key, productData) {
        Map<String, dynamic> ratings = productData['ratings'] == null
            ? {}
            : Map<String, dynamic>.from(productData['ratings']);
        Map<String, dynamic> comments = productData['comments'] == null
            ? {}
            : Map<String, dynamic>.from(productData['comments']);

        _products.add(Product(
          productId: key,
          title: productData['title'],
          description: productData['description'],
          category: productData['category'],
          subcategory: productData['subCategory'],
          price: productData['price'].toString(),
          createdVendor: productData['createdVendor'],
          image: productData['image'],
          ratings: ratings.map((key, value) =>
              MapEntry(key, int.tryParse(value.toString()) ?? 0)),
          comments: comments.map(
              (key, value) => MapEntry(key, Map<String, String>.from(value))),
        ));
      });

      notifyListeners();
    } catch (error) {
      print('DAMN BRUH, AN ERROR OCCURDED: $error');
    }
  }

  List<Product> get getAllProducts {
    return [..._products];
  }

  // Method to get products by category
  List<Product> getProductsByCategory(String category) {
    return _products
        .where((product) =>
            product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Method to get products by keyword, price range, and rating range
  List<Product> getProductsByKeyword(String keyword,
      {double priceFrom = 0,
      double priceTo = double.infinity,
      int minRating = 1,
      int maxRating = 5}) {
    // Step 1: Filter by keyword
    List<Product> filteredProducts = _products.where((product) {
      return product.title.toLowerCase().contains(keyword.toLowerCase()) ||
          product.description.toLowerCase().contains(keyword.toLowerCase()) ||
          product.category.toLowerCase().contains(keyword.toLowerCase()) ||
          product.subcategory.toLowerCase().contains(keyword.toLowerCase()) ||
          product.createdVendor.toLowerCase().contains(keyword.toLowerCase()) ||
          product.category.toLowerCase().contains(keyword.toLowerCase()) ||
          product.subcategory.toLowerCase().contains(keyword.toLowerCase()) ||
          product.price
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase());
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

  // Method to get products by subcategory
  List<Product> getProductsBySubCategory(
    String productId,
    String subCategory,
  ) {
    return _products
        .where((product) =>
            product.subcategory.toLowerCase() == subCategory.toLowerCase() &&
            product.productId != productId)
        .toList();
  }
}
