import 'package:flutter/material.dart';
import 'package:khao_lao/pages/account_page.dart';
import 'package:khao_lao/pages/cart_page.dart';
import 'package:khao_lao/pages/category_page.dart';
import 'package:khao_lao/pages/home_page.dart';

class BottomNavigationPage extends StatefulWidget {
  final int initialIndex;
  
  const BottomNavigationPage({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);
  
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late int _selectedIndex;
  
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }
  
  // Define the pages for each tab
  static final List<Widget> _pages = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const AccountPage(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: const Color(0xFF006633), // Dark green background
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, 'ໜ້າຫຼັກ'),
              _buildNavItem(1, 'assets/images/type rice.png', 'ປະເພດເຂົ້າ', isImage: true),
              _buildNavItem(2, Icons.shopping_cart, 'ກະຕ່າ'),
              _buildNavItem(3, Icons.person, 'ບັນຊີ'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, dynamic icon, String label, {bool isImage = false}) {
    final isSelected = _selectedIndex == index;
   
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFFFFCC33) : Colors.white,
            ),
            child: isImage
                ? Image.asset(
                    icon,
                    width: 24,
                    height: 24,
                    color: isSelected ? Colors.white : const Color(0xFF006633),
                  )
                : Icon(
                    icon,
                    color: isSelected ? Colors.white : const Color(0xFF006633),
                    size: 24,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFFFCC33) : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}