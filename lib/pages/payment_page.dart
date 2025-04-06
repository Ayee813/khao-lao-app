import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khao_lao/pages/order_confirmation_page.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> deliveryDetails;

  const PaymentPage({Key? key, required this.deliveryDetails}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Payment method selection
  String _selectedPaymentMethod = 'QR';
  
  // File for receipt upload
  File? _receiptImage;
  final ImagePicker _picker = ImagePicker();
  
  // Order total (in a real app, this would come from cart/order data)
  final double _orderTotal = 150000; // 150,000 LAK
  
  // Loading state
  bool _isProcessing = false;
  
  // Primary color scheme
  final Color primaryColor = const Color(0xFFFFC65C);
  final Color backgroundColor = const Color(0xFF006633);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            _buildOrderSummary(),
            
            const SizedBox(height: 24),
            
            // Payment Method Selection
            _buildPaymentMethodSelection(),
            
            const SizedBox(height: 24),
            
            // Payment Instructions and QR
            _buildPaymentInstructions(),
            
            const SizedBox(height: 24),
            
            // Receipt Upload
            _buildReceiptUpload(),
            
            const SizedBox(height: 32),
            
            // Submit Payment Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _submitPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Confirm Payment',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: backgroundColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal:'),
                Text('${(_orderTotal * 0.9).toStringAsFixed(0)} LAK'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Fee:'),
                Text('${(_orderTotal * 0.1).toStringAsFixed(0)} LAK'),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_orderTotal.toStringAsFixed(0)} LAK',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: backgroundColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Bcel One'),
                value: 'QR',
                groupValue: _selectedPaymentMethod,
                activeColor: backgroundColor,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('LDB Bank'),
                value: 'BANK',
                groupValue: _selectedPaymentMethod,
                activeColor: backgroundColor,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentInstructions() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _selectedPaymentMethod == 'QR' 
                  ? 'Scan QR Code to Pay' 
                  : 'Bank Transfer Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: backgroundColor,
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedPaymentMethod == 'QR')
              Column(
                children: [
                  // Placeholder for QR code image
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/Bank_QR.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.qr_code_2, size: 80, color: Colors.grey),
                              const SizedBox(height: 8),
                              Text(
                                'QR Code for Payment',
                                style: TextStyle(color: backgroundColor),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Scan this QR code with your banking app or mobile wallet to complete payment.',
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bank: BCEL'),
                  SizedBox(height: 8),
                  Text('Account Name: Khao Lao'),
                  SizedBox(height: 8),
                  Text('Account Number: 010-12-00-123456789'),
                  SizedBox(height: 8),
                  Text('Amount: 150,000 LAK'),
                  SizedBox(height: 16),
                  Text(
                    'Please include your phone number in the transfer notes.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
                    ),
                  )
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bank: BCEL'),
                  SizedBox(height: 8),
                  Text('Account Name: Khao Lao'),
                  SizedBox(height: 8),
                  Text('Account Number: 010-12-00-123456789'),
                  SizedBox(height: 8),
                  Text('Amount: 150,000 LAK'),
                  SizedBox(height: 16),
                  Text(
                    'Please include your phone number in the transfer notes.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Payment Receipt',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: backgroundColor,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: _receiptImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _receiptImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 60,
                        color: backgroundColor.withOpacity(0.7),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tap to upload payment receipt',
                        style: TextStyle(
                          fontSize: 16,
                          color: backgroundColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please upload a clear image of your payment confirmation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        if (_receiptImage != null)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _receiptImage = null;
                });
              },
              icon: const Icon(Icons.delete, size: 20),
              label: const Text('Remove'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (pickedFile != null) {
        setState(() {
          _receiptImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _submitPayment() {
    // Validate that receipt has been uploaded
    if (_receiptImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your payment receipt'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show processing state
    setState(() {
      _isProcessing = true;
    });

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      // In a real app, this would be where you'd upload the image to your server
      // and process the payment information

      setState(() {
        _isProcessing = false;
      });

      // Navigate to confirmation page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationPage(
            orderDetails: {
              'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
              'amount': _orderTotal,
              'paymentMethod': _selectedPaymentMethod,
              'deliveryDetails': widget.deliveryDetails,
              'orderDate': DateTime.now().toString(),
            },
          ),
        ),
      );
    });
  }
}