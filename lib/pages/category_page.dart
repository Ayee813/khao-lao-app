// Update the CategoryPage to use the Product model and CartProvider
// Modified CategoryPage.dart

import 'package:flutter/material.dart';
import 'package:khao_lao/pages/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'product_model.dart';
import 'cart_provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample product data
    final List<Product> products = [
      Product(
        id: '1',
        name: 'ເຂົ້າຂາວມະລິ',
        weight: '10kg',
        price: 19000,
        image: 'assets/images/rice_list/IMG_bl22_rice_bag_2_1_3BBGUG9N.webp',
      ),
      Product(
        id: '2',
        name: 'ເຂົ້າຈ້າວ',
        weight: '5kg',
        price: 22500,
        image: 'assets/images/rice_list/1685758244536.jpg',
      ),
      Product(
        id: '3',
        name: 'ເຂົ້າໜຽວ',
        weight: '1kg',
        price: 28000,
        image: 'assets/images/rice_list/rice-featured-image.jpg',
      ),
      Product(
        id: '4',
        name: 'ເຂົ້າປອດສານພິດ',
        weight: '2kg',
        price: 32000,
        image: 'assets/images/rice_list/yellow_rice.jpg',
      ),
      Product(
        id: '5',
        name: 'ເຂົ້າຫອມ',
        weight: '5kg',
        price: 26500,
        image: 'assets/images/rice_list/1685758244536.jpg',
      ),
      Product(
        id: '6',
        name: 'ເຂົ້າດໍາ',
        weight: '5kg',
        price: 26500,
        image: 'assets/images/rice_list/black_rice.jpg',
      ),
    ];

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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search......',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          // Category Pills
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildCategoryPill('ທັງໝົດ', true),
                  _buildCategoryPill('ເຂົ້າຈ້າວ', false),
                  _buildCategoryPill('ເຂົ້າກ່ຳ', false),
                  _buildCategoryPill('ເຂົ້າຫອມມະລິ', false),
                  _buildCategoryPill('ເຂົ້າໜຽວ', false),
                  _buildCategoryPill('ອື່ນໆ', false),
                ],
              ),
            ),
          ),

          // Product Grid
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    _buildProductCard(context, products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated category pill widget with tap handling
  Widget _buildCategoryPill(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // In a stateful widget, you would update the state here
        print('Selected category: $title');
        // setState(() {
        //   selectedCategory = title;
        // });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Chip(
          backgroundColor: isSelected ? const Color(0xFFFFD051) : Colors.white,
          label: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: isSelected ? Colors.transparent : Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: isSelected ? 2 : 0,
          shadowColor: isSelected ? Colors.black38 : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Make the image clickable with GestureDetector
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Stack(
            children: [
              Hero(
                tag: 'product-${product.id}', // Add Hero animation
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Image.asset(
                      product.image,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, _) => Center(
                        child: Icon(Icons.image_not_supported,
                            size: 40, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${product.price.toStringAsFixed(0)} ກີບ/kg',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to detail page on Buy Now button press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF03BE6D),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'ຊື້ຕອນນີ້',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    flex: 10,
                    child: OutlinedButton(
                      onPressed: () {
                        cartProvider.addItem(product);

                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('ເພີ່ມໃສ່ກະຕ່າ'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: const Color(0xFF006633),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'ເພີ່ມໃສ່ກະຕ່າ',
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
}
