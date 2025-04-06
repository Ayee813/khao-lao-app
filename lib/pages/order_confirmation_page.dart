import 'package:flutter/material.dart';
import 'package:khao_lao/pages/home_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  const OrderConfirmationPage({Key? key, required this.orderDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Primary color scheme
    final Color primaryColor = const Color(0xFFFFC65C);
    final Color backgroundColor = const Color(0xFF006633);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmed', style: TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // Success Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 80,
                color: backgroundColor,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Thank you message
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: backgroundColor,
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              'Your order has been confirmed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Order details card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: backgroundColor,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildOrderInfoRow('Order ID', '${orderDetails['orderId']}'),
                    _buildOrderInfoRow(
                      'Date',
                      '${DateTime.parse(orderDetails['orderDate']).day}/${DateTime.parse(orderDetails['orderDate']).month}/${DateTime.parse(orderDetails['orderDate']).year}',
                    ),
                    _buildOrderInfoRow(
                      'Amount',
                      '${orderDetails['amount'].toStringAsFixed(0)} LAK',
                    ),
                    _buildOrderInfoRow(
                      'Payment Method',
                      orderDetails['paymentMethod'] == 'QR' ? 'QR Payment' : 'Bank Transfer',
                    ),
                    _buildOrderInfoRow(
                      'Delivery To',
                      orderDetails['deliveryDetails']['name'],
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'We\'ll notify you when your order is on the way.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Back to home button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to home page and clear all previous routes
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}