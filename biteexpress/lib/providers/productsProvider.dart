import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../classes/product.dart';
import '../productsMockData.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;
  String? _selectedSubcategory;
  File? _selectedImage;

  final productsUrl = Uri.parse(
      'https://bite-express-b3634-default-rtdb.firebaseio.com/products.json');

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get priceController => _priceController;
  String? get selectedCategory => _selectedCategory;
  String? get selectedSubcategory => _selectedSubcategory;
  File? get selectedImage => _selectedImage;

  final List<String> _categories = [
    'Bakeries & Pastries',
    'Fruits & Vegetables',
    'Cold Cuts & Deli',
    'Dairy & Eggs',
    'Ready to Eat',
    'Milk',
    'Ice Cream',
    'Meat, Poultry & Seafood',
    'Frozen',
    'Snacks',
    'Beverages',
    'Canned & Jarred',
    'Cooking & Baking',
    'Condiments',
    'Breakfast Food',
  ];

  final Map<String, List<String>> _subcategories = {
    'Bakeries & Pastries': ['Bread', 'Pastries', 'Cakes', 'Cookies'],
    'Fruits & Vegetables': ['Fruits', 'Vegetables', 'Herbs'],
    'Cold Cuts & Deli': ['Cold Cuts', 'Deli Meats', 'Cheese'],
    'Dairy & Eggs': ['Milk', 'Eggs', 'Butter', 'Cheese'],
    'Ready to Eat': ['Sandwiches', 'Salads', 'Prepared Meals'],
    'Milk': ['Whole Milk', 'Skim Milk', 'Flavored Milk'],
    'Ice Cream': ['Vanilla', 'Chocolate', 'Strawberry', 'Cookies and Cream'],
    'Meat, Poultry & Seafood': ['Beef', 'Chicken', 'Fish', 'Shrimp'],
    'Frozen': ['Frozen Meals', 'Frozen Vegetables', 'Frozen Fruits'],
    'Snacks': ['Chips', 'Popcorn', 'Nuts', 'Crackers'],
    'Beverages': ['Soda', 'Juice', 'Water', 'Energy Drinks'],
    'Canned & Jarred': [
      'Canned Vegetables',
      'Canned Fruits',
      'Pickles',
      'Jams'
    ],
    'Cooking & Baking': ['Flour', 'Sugar', 'Oil', 'Spices'],
    'Condiments': ['Ketchup', 'Mustard', 'Mayonnaise', 'Sauces'],
    'Breakfast Food': ['Cereal', 'Oatmeal', 'Pancake Mix', 'Maple Syrup'],
  };

  List<String> get categories => _categories;
  List<String>? get subcategories => _subcategories[_selectedCategory];

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
          price: double.parse(productData['price'].toString()),
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
      return product.price >= priceFrom &&
          product.price <= priceTo;
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

  void setCategory(String? category) {
    _selectedCategory = category;
    _selectedSubcategory = null;
    notifyListeners();
  }

  void setSubcategory(String? subcategory) {
    _selectedSubcategory = subcategory;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  bool validateForm() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _selectedCategory == null ||
        _selectedSubcategory == null) {
      return false;
    }
    return true;
  }

  Product createProduct() {
    return Product(
      productId: "a",
      createdVendor: "Aikmk",
      title: _titleController.text,
      description: _descriptionController.text,
      image: "test",
      category: _selectedCategory!,
      subcategory: _selectedSubcategory!,
      price: _priceController.text,
    );
  }

  Future<void> addProductToDatabase(Product product) async {
    final url = Uri.parse(
        'https://bite-express-b3634-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'createdVendor': product.createdVendor,
          'title': product.title,
          'description': product.description,
          'image':
              "https://m.media-amazon.com/images/I/81reeFQjkuL._AC_UF894,1000_QL80_.jpg",
          'category': product.category,
          'subCategory': product.subcategory,
          'price': product.price,
        }),
      );

      if (response.statusCode == 200) {
        print("Product added successfully!");
        // Clear the form after successful addition
        clearForm();
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error adding product: $error");
    }
  }

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _selectedCategory = null;
    _selectedSubcategory = null;
    _selectedImage = null;
    notifyListeners();
  }

  Future<void> addCommentToProduct(Product product, String comment,
      String userId, String firstName, String lastName, double rating) async {
    print(rating);
    final url = Uri.parse(
        'https://bite-express-b3634-default-rtdb.firebaseio.com/products/${product.productId}.json');

    try {
      final existingComment =
          product.comments[userId]; // Check if user already commented
      final existingRating =
          product.ratings[userId]; // Check if user already rated

      final newCommentId = userId; // Use the user ID as the comment ID
      final newComment = {
        newCommentId: {
          'comment': comment,
          'firstName': firstName,
          'lastName': lastName,
          'userId': userId,
        }
      };

      final updatedComments = {
        ...product.comments,
        ...newComment
      }; // Merge new comment with existing comments

      final updatedRatings = {
        ...product.ratings,
        if (existingRating != null) // If user already rated, update the rating
          userId: rating,
        if (existingRating == null) // If user didn't rate, add the rating
          userId: rating,
      };

      final response = await http.patch(
        url,
        body: json.encode({
          'comments': updatedComments,
          'ratings': updatedRatings,
        }),
      );

      if (response.statusCode == 200) {
        // If the user already commented, update the existing comment
        if (existingComment != null) {
          // Remove the old comment
          updatedComments.remove(userId);
          // Merge the updated comment with existing comments
          updatedComments.addAll(newComment);
        }

        notifyListeners();
      } else {
        print("Failed to add comment. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error adding comment: $error");
    }
  }
}
