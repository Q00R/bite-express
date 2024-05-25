import 'package:flutter/foundation.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  // Singleton instance
  static final Cart _instance = Cart._internal();

  // Private constructor
  Cart._internal();

  // Factory constructor to return the singleton instance
  factory Cart() => _instance;

  // List to hold the products in the cart
  final List<Product> _products = [];

  // Method to add a product to the cart
  void addToCart(Product product) {
    _products.add(product);
    notifyListeners();
    print("PRODUCT " + product.title + " ADDED TO CART");
    print(_products.length);
  }

  // Method to remove a product from the cart
void removeFromCart(Product product) {
  final int index = _products.indexWhere((prod) => prod.productId == product.productId);
  if (index != -1) {
    _products.removeAt(index);
    notifyListeners();

    print("PRODUCT " + product.title + " REMOVED FROM CART");
    if(_products.length == 0){
      print("CART IS EMPTY");
    } else {

    print(_products.length);
  }
}
}


  // Method to clear the cart
  void clearCart() {
    _products.clear();
    notifyListeners();
  }

  // Method to get the total number of items in the cart
  int get itemCount => _products.length;

  // Method to get all products in the cart
  List<Product> get products => List<Product>.unmodifiable(_products);

  // Method to get the total price of all products in the cart
  double get totalPrice => _products.fold(0, (total, current) => total + current.price);

  // Method to get quantity of a product in the cart  
 int getQuantity(Product product) {
  return _products.where((prod) => prod.productId == product.productId).length;
}
}
