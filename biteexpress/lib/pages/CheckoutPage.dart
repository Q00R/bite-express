import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Cart.dart';
import '../classes/product.dart';

enum PaymentType { cash, card } // Define PaymentType enum here

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentType? _paymentType = PaymentType.cash; // Default payment type is cash
  bool _showPaymentDetails = false; // Flag to control the visibility of payment details widget

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final List<Product> products = cart.products;

    // Create a set to keep track of unique product IDs
    Set<String> uniqueProductIds = {};

    // Controller for delivery information
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  // Check if the product ID is already in the set
                  if (uniqueProductIds.contains(product.productId)) {
                    // If yes, skip creating ListTile
                    return SizedBox.shrink();
                  }

                  // If not, add the product ID to the set
                  uniqueProductIds.add(product.productId);

                  return ListTile(
                    leading: Image.network(
                      product.image, 
                      width: 50,
                      height: 50, 
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Text('Quantity: ${cart.getQuantity(product)}'),
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                'Total Items: ${cart.itemCount}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Delivery Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Select Payment Type',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Cash'),
                leading: Radio(
                  value: PaymentType.cash,
                  groupValue: _paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      _paymentType = value;
                      _showPaymentDetails = false; // Hide payment details widget when switching payment type
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Card'),
                leading: Radio(
                  value: PaymentType.card,
                  groupValue: _paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      _paymentType = value;
                      _showPaymentDetails = false; // Hide payment details widget when switching payment type
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              // Button with more presence
              Container(
                width: double.infinity, // Make the button expand to full width
                padding: EdgeInsets.symmetric(vertical: 16.0), // Add vertical padding
                child: ElevatedButton(
                  onPressed: () {
                    if (_paymentType == PaymentType.cash) {
                      // Place order logic for cash payment
                    } else if (_paymentType == PaymentType.card) {
                      // Show payment details widget for card payment
                      setState(() {
                        _showPaymentDetails = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Change button color to orange
                    textStyle: TextStyle(fontSize: 20), // Increase font size
                  ),
                  child: Text(
                    _paymentType == PaymentType.cash ? 'Place Order' : 'Place and Pay',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Conditional rendering of payment details widget
              if (_showPaymentDetails && _paymentType == PaymentType.card) ...[
                SizedBox(height: 16),
                PaymentDetailsWidget(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Expiration Date',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'CVV',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
