import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006633),
        title: const Text(
          'KHAO LAO',
          style: TextStyle(
            color: Color(0xFFFFC65C),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 40,
            height: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Color(0xFFFFC65C), size: 30),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFFFC65C), size: 35),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF00C853),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'User Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          const Center(
            child: Text(
              'user@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 30),
          _buildAccountMenuItem(context, 'My Orders', Icons.shopping_bag_outlined),
          _buildAccountMenuItem(context, 'Shipping Addresses', Icons.location_on_outlined),
          _buildAccountMenuItem(context, 'Payment Methods', Icons.credit_card_outlined),
          _buildAccountMenuItem(context, 'Settings', Icons.settings_outlined),
          _buildAccountMenuItem(context, 'Help & Support', Icons.help_outline),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Handle logout
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00C853)),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF00C853),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountMenuItem(BuildContext context, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00C853)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle menu item tap
        },
      ),
    );
  }
}