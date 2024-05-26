import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Cart.dart';
import '../classes/product.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

enum PaymentType { cash, card } // Define PaymentType enum here



class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

void _pay() {

  print('Payment initiated');
  try {

    InAppPayments.setSquareApplicationId('sandbox-sq0idb-o6aUi04KTMQqMHAfOEc9QA');
    print("tamam");
    InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
      onCardEntryCancel: _cardEntryCancel,
    );
  } catch (e) {
    print('Error initiating payment: $e');
    // Optionally, you can show a snackbar or dialog to notify the user about the error.
  }
}


  void _cardNonceRequestSuccess(CardDetails result) {
    // Use this nonce from your backend to pay
    print(result.nonce);
    InAppPayments.completeCardEntry(
      onCardEntryComplete: _cardEntryComplete,
    );
  }

  void _cardEntryCancel() {

    // snack bar that says cancelled
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Payment Cancelled'),
      duration: Duration(seconds: 2),
    ));
  }
  void _cardEntryComplete() {
    // snack bar that says success
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Payment Successful'),
      duration: Duration(seconds: 2),
    ));
  }
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
                title: Icon(Icons.money),
                leading: Radio(
                  value: PaymentType.cash,
                  groupValue: _paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      _paymentType = value;
                      _showPaymentDetails = false; // Hide payment details widget when switching payment type
                      // snack bar that says order placed 
                      
                    });
                  },
                ),
              ),
              ListTile(
                title: Icon(Icons.credit_card),
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
                      // snack bar that says order placed
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Order Placed'),
                        duration: Duration(seconds: 2),
                      ));
                      cart.clearCart();
                    } else if (_paymentType == PaymentType.card) {

                      _pay();
// \                      setState(() {
//                         _showPaymentDetails = true;
//                       });
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
