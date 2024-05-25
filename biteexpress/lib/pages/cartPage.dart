import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Cart.dart';
import '../classes/product.dart';
import '../pages/CheckoutPage.dart'; // Import the CheckoutPage file

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final List<Product> products = cart.products;
    final double totalPrice = cart.totalPrice;

    // Create a set to keep track of unique product IDs
    Set<String> uniqueProductIds = {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.orange, // Set app bar color to orange
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (products.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 120,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Uh oh! Your cart is empty, go back & fill it up!!',
                        style: TextStyle(
                          color: Colors.orange, // Set text color to orange
                          fontSize: 16, // Set font size
                          fontWeight: FontWeight.bold, // Set font weight to bold
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final quantity = cart.getQuantity(product);

                    // Check if the product ID is already in the set
                    if (uniqueProductIds.contains(product.productId)) {
                      // If yes, skip creating ListTile
                      return SizedBox.shrink();
                    }

                    // If not, add the product ID to the set
                    uniqueProductIds.add(product.productId);

                    return ListTile(
                      leading: Image.network(
                        product.image, // Provide the product image URL
                        width: 50, // Adjust width as needed
                        height: 50, // Adjust height as needed
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                      title: Text(product.title),
                      subtitle: Text('Price: \$${(product.price * quantity).toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (quantity > 0)
                            IconButton(
                              onPressed: () {
                                cart.removeFromCart(product);
                              },
                              icon: Icon(Icons.remove),
                            ),
                          if (quantity > 0) Text('$quantity'),
                          IconButton(
                            onPressed: () {
                              cart.addToCart(product);
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            if (totalPrice > 0) // Only show buttons when total price is greater than 0
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            cart.clearCart();
                          },
                          child: Text('Clear Cart'),
                        ),
                        SizedBox(width: 8), // Add some spacing between buttons
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CheckoutPage()),
                            );
                          },
                          child: Text('Go to Checkout'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
