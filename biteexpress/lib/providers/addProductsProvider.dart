import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../classes/product.dart';

class ProductProvider with ChangeNotifier {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;
  String? _selectedSubcategory;
  File? _selectedImage;

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

  get formKey => null;

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
}
