import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../classes/product.dart';
import 'dart:io';

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

  final List<String> _categories = ['Electronics', 'Fashion', 'Home'];
  final Map<String, List<String>> _subcategories = {
    'Electronics': ['Phones', 'Computers', 'Accessories'],
    'Fashion': ['Men', 'Women', 'Kids'],
    'Home': ['Furniture', 'Kitchen', 'Decor'],
  };

  List<String> get categories => _categories;
  List<String>? get subcategories => _subcategories[_selectedCategory];

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
        _selectedSubcategory == null ||
        _selectedImage == null) {
      return false;
    }
    return true;
  }

  Product createProduct() {
    return Product(
        productId: "a",
        createdVendor: "A",
        title: _titleController.text,
        description: _descriptionController.text,
        // image: _selectedImage!,
        image: "test",
        category: _selectedCategory!,
        subcategory: _selectedSubcategory!,
        price: double.parse(_priceController.text),
      );

  }
}
